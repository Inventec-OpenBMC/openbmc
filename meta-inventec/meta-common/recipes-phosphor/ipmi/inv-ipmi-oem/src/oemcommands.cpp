/*
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
*/

#include <oemcommands.hpp>
#include <commandutils.hpp>

#include <ipmid/api.hpp>
#include <ipmid/utils.hpp>
#include <sdbusplus/bus.hpp>
#include <sdbusplus/message/types.hpp>
#include <phosphor-logging/log.hpp>
#include <systemd/sd-bus.h>

#include <array>
#include <filesystem>
#include <iostream>
#include <regex>
#include <string>
#include <variant>
#include <vector>
#include <peci.h>
#include <sstream>
#include <iomanip>

using namespace std;
using namespace ipmi::inv::cmdsNetFnInventec;

static constexpr const char* chassisIntf =
    "xyz.openbmc_project.State.Chassis";
static constexpr auto SYSTEMDMGR_DEST = "org.freedesktop.systemd1";
static constexpr auto SYSTEMDMGR_PATH = "/org/freedesktop/systemd1";
static constexpr auto SYSTEMDMGR_INTF = "org.freedesktop.systemd1.Manager";
static constexpr auto SYSTEMDMGR_UNIT_INTF = "org.freedesktop.systemd1.Unit";
static constexpr auto NETWORK_DEST = "xyz.openbmc_project.Network";
static constexpr auto ETH_USB_PATH = "/xyz/openbmc_project/network/usb0";
static constexpr auto ETH_INTF = "xyz.openbmc_project.Network.EthernetInterface";
static constexpr auto REDFISH_UNIT = "bmcweb.service";

namespace ipmi
{
static void registerOEMFunctions() __attribute__((constructor));
ipmi::RspType<message::Payload> ipmiOemGenerateRandomPassword(const uint8_t paramSelector, const uint8_t bmcInst);

/*
An example of IPMI OEM command registration
*/
#if EXAMPLE
ipmi::RspType<bool, //just return the req param
             uint7_t // reserved
             >
    ipmiOemExampleCommand(bool req, uint7_t reserved1)
{
    return ipmi::responseSuccess(req, 0);
}
#endif
ipmi::RspType<std::vector<uint8_t>>
    ipmiOemSendRawPeci(uint8_t clientAddr, uint8_t writeLength, uint8_t readLength,
                        std::vector<uint8_t> writeData)
{
    std::vector<uint8_t> rawResp(readLength);
    if (peci_raw(clientAddr, readLength, writeData.data(), writeData.size(),
                             rawResp.data(), rawResp.size()) != PECI_CC_SUCCESS)
    {
        phosphor::logging::log<phosphor::logging::level::ERR>(
        "sendRawPeci command: PECI command failed");
        return ipmi::responseResponseError();
    }

    return ipmi::responseSuccess(rawResp);

}

ipmi::RspType<> ipmiChassisSetPowerInterval(uint8_t interval)
{
    try
    {
        sdbusplus::bus::bus bus(ipmid_get_sd_bus_connection());
        ipmi::DbusObjectInfo chassisPowerObject =
            ipmi::getDbusObject(bus, chassisIntf);
        ipmi::setDbusProperty(bus, chassisPowerObject.second,
                              chassisPowerObject.first, chassisIntf,
                              "RequestedPowerIntervalMs", ((int)interval) * 1000);
    }
    catch (std::exception& e)
    {
        phosphor::logging::log<phosphor::logging::level::ERR>(
                        "Fail to set RequestedPowerIntervalMs property",
                        phosphor::logging::entry("ERROR=%s", e.what()));
        return ipmi::responseUnspecifiedError();
    }
    return ipmi::responseSuccess();
}

ipmi::RspType<message::Payload>
    ipmiOemGetBmcIntfStatus(void)
{
    message::Payload ret;
    std::bitset<2> st_redfish = inv::BMC_INTF_NONE;
    std::bitset<2> st_usb_lan = inv::BMC_INTF_NONE;
    sd_bus_message *reply = NULL;
    char *path;
    char *str_ret;

    try
    {
        int rc, active = 0;
        sd_bus* bus = ipmid_get_sd_bus_connection();

        //Check Redfish status
        rc = sd_bus_call_method(
                bus,
                SYSTEMDMGR_DEST,
                SYSTEMDMGR_PATH,
                SYSTEMDMGR_INTF,
                "GetUnit", NULL, &reply, "s", REDFISH_UNIT);
        if (rc >= 0)
        {
            st_redfish |= inv::BMC_INTF_SUPPORTED;
            rc = sd_bus_message_read(reply, "o", &path);
            if (rc >= 0)
            {
                rc = sd_bus_get_property_string(
                        bus,
                        SYSTEMDMGR_DEST,
                        path,
                        SYSTEMDMGR_UNIT_INTF,
                        "ActiveState", NULL, &str_ret);
                if (rc >= 0 && strcmp(str_ret, "active") == 0)
                {
                    st_redfish |= inv::BMC_INTF_ACTIVE;
                }
            }
        }

        //Check USB LAN status
        rc = sd_bus_get_property_trivial(
                bus,
                NETWORK_DEST,
                ETH_USB_PATH,
                ETH_INTF,
                "NICEnabled", NULL, 'b', &active);
        if (rc >= 0 && active)
        {
            st_usb_lan |= inv::BMC_INTF_SUPPORTED;
            rc = sd_bus_get_property_trivial(
                    bus,
                    NETWORK_DEST,
                    ETH_USB_PATH,
                    ETH_INTF,
                    "LinkUp", NULL, 'b', &active);
            if (rc >= 0 && active)
            {
                st_usb_lan |= inv::BMC_INTF_ACTIVE;
            }
        }
    }
    catch (std::exception& e)
    {
        phosphor::logging::log<phosphor::logging::level::ERR>(
                        "Fail to get BMC interface status",
                        phosphor::logging::entry("ERROR=%s", e.what()));
        return ipmi::responseUnspecifiedError();
    }
    ret.pack(st_redfish, uint6_t{});
    ret.pack(st_usb_lan, uint6_t{});
    reply = sd_bus_message_unref(reply);
    return ipmi::responseSuccess(std::move(ret));
}

#ifdef SUPPORT_BIOS_OEM_CMD
ipmi::RspType<message::Payload>
    ipmiBiosGetBmcIntfStatus(uint8_t param, uint8_t block, uint8_t interfaces)
{
    message::Payload ret;
    std::bitset<3> st_usb_ipmi = inv::BIOS_INTF_NONE;
    std::bitset<3> st_usb_lan = inv::BIOS_INTF_NONE;
    std::bitset<3> st_redfish = inv::BIOS_INTF_NONE;
    sd_bus_message *reply = NULL;
    char *path;
    char *str_ret;

    if (param != 0x01 || block != 0)
    {
        return ipmi::responseInvalidFieldRequest();
    }

    try
    {
        int rc, active = 0;
        sd_bus* bus = ipmid_get_sd_bus_connection();

        if (interfaces & inv::BIOS_LAN_USB_INTF)
        {
            //Check USB LAN status
            rc = sd_bus_get_property_trivial(
                    bus,
                    NETWORK_DEST,
                    ETH_USB_PATH,
                    ETH_INTF,
                    "NICEnabled", NULL, 'b', &active);
            if (rc >= 0 && active)
            {
                st_usb_lan = inv::BIOS_INTF_STARTED;
                rc = sd_bus_get_property_trivial(
                        bus,
                        NETWORK_DEST,
                        ETH_USB_PATH,
                        ETH_INTF,
                        "LinkUp", NULL, 'b', &active);
                if (rc >= 0 && active)
                {
                    st_usb_lan = inv::BIOS_INTF_READY;
                }
            }
        }

        if (interfaces & inv::BIOS_REDFISH_INTF)
        {
            //Check Redfish status
            rc = sd_bus_call_method(
                    bus,
                    SYSTEMDMGR_DEST,
                    SYSTEMDMGR_PATH,
                    SYSTEMDMGR_INTF,
                    "GetUnit", NULL, &reply, "s", REDFISH_UNIT);
            if (rc >= 0)
            {
                rc = sd_bus_message_read(reply, "o", &path);
                if (rc >= 0)
                {
                    st_redfish = inv::BIOS_INTF_ERROR;
                    rc = sd_bus_get_property_string(
                            bus,
                            SYSTEMDMGR_DEST,
                            path,
                            SYSTEMDMGR_UNIT_INTF,
                            "ActiveState", NULL, &str_ret);
                    if (rc >= 0)
                    {
                        if (strcmp(str_ret, "active") == 0)
                        {
                            st_redfish = inv::BIOS_INTF_READY;
                        }
                        else if (strcmp(str_ret, "reloading") == 0 || strcmp(str_ret, "activating") == 0)
                        {
                            st_redfish = inv::BIOS_INTF_STARTED;
                        }
                    }
                }
            }
        }
    }
    catch (std::exception& e)
    {
        phosphor::logging::log<phosphor::logging::level::ERR>(
                        "Fail to get BMC interface status for BIOS",
                        phosphor::logging::entry("ERROR=%s", e.what()));
        return ipmi::responseUnspecifiedError();
    }
    ret.pack(st_usb_ipmi, uint5_t{});
    ret.pack(st_usb_lan, uint5_t{});
    ret.pack(st_redfish, uint5_t{});
    reply = sd_bus_message_unref(reply);
    return ipmi::responseSuccess(std::move(ret));
}
#endif //SUPPORT_BIOS_OEM_CMD

static void registerOEMFunctions(void)
{
    phosphor::logging::log<phosphor::logging::level::INFO>(
        "Registering INV OEM commands");

    // Chassis command 0x00, 0x0B
    registerOemCmdHandler(ipmi::netFnChassis, ipmi::chassis::cmdSetPowerCycleInterval,
                            Privilege::Admin, ipmiChassisSetPowerInterval);

#ifdef SUPPORT_BIOS_OEM_CMD
    // Inventec OEM command for BIOS
    registerOemCmdHandler(inv::netFnBios, inv::cmdsNetFnBios::cmdGetBmcInfStatusForBios,
                            Privilege::Admin, ipmiBiosGetBmcIntfStatus);
#endif //SUPPORT_BIOS_OEM_CMD

    // Inventec OEM command
    registerOemCmdHandler(inv::netFnInventec, inv::cmdsNetFnInventec::cmdGetBmcInterfaceStatus,
                            Privilege::Admin, ipmiOemGetBmcIntfStatus);

    /*This is an example of IPMI OEM command registration*/
#if EXAMPLE
    registerOemCmdHandler(inv::netFnOem3e, inv::cmdsNetFnOem3e::cmdExample,
                            Privilege::Admin, ipmiOemExampleCommand);
#endif
    registerOemCmdHandler(inv::netFnOem30, inv::cmdsNetFnOem30::cmdSendRawPeci,
                            Privilege::Admin, ipmiOemSendRawPeci);

    //Inventec OEM command  Generated password 0x3a 0x5d
    registerOemCmdHandler(inv::netFnInventec, inv::cmdsNetFnInventec::cmdOemGenerateRandomPassword,
                          Privilege::Admin, ipmiOemGenerateRandomPassword);
}


} // namespace ipmi
