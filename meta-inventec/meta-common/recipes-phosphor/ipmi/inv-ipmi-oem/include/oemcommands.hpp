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

#pragma once

#include <ipmid/api-types.hpp>
#include <stdexcept>

#define EXAMPLE 0

namespace ipmi
{
namespace inv
{

static constexpr NetFn netFnOem30 = netFnOemOne;
static constexpr NetFn netFnOem3e = netFnOemEight;

static constexpr NetFn netFnInventec = netFnOemSix;
#ifdef SUPPORT_BIOS_OEM_CMD
static constexpr NetFn netFnBios = netFnOemTwo;
#endif //SUPPORT_BIOS_OEM_CMD

namespace cmdsNetFnOem30
{
    static constexpr Cmd cmdSendRawPeci = 0xE6;

} // namespace cmdsNetFnOem30

namespace cmdsNetFnOem3e
{
//An example of IPMI OEM command registration
#if EXAMPLE
static constexpr Cmd cmdExample = 0xff;
#endif

} // namespace cmdsNetFnOem3e

namespace cmdsNetFnInventec
{
    constexpr Cmd cmdGetBmcInterfaceStatus = 0x50;

    static constexpr uint8_t _BIOS_USER = 0x1;
    static constexpr uint8_t _OS_USER = 0x2;
    static constexpr uint8_t _DELETE_FW_USER = 0x4;
    static constexpr uint8_t _DELETE_OS_USER = 0x8;

    static constexpr uint8_t MAX_PASSWORD_LENGTH = 20;

    static constexpr uint8_t _HOST_INTERFACE_ENABLED = 0x01;
    static constexpr uint8_t _KERNEL_AUTH_ENABLED = 0x02;
    static constexpr uint8_t _FIRMWARE_AUTH_ENABLED = 0x04;

    static constexpr auto NETWORK_SERVICE = "xyz.openbmc_project.Network";
    static constexpr auto NETWORK_USB0_OBJECT = "/xyz/openbmc_project/network/usb0";
    static constexpr auto NETWORK_ETH_INTERFACE = "xyz.openbmc_project.Network.EthernetInterface";

    static constexpr auto WATCHDOG_SERVICE = "xyz.openbmc_project.Watchdog";
    static constexpr auto WATCHDOG_HOST0_OBJECT = "/xyz/openbmc_project/watchdog/host0";
    static constexpr auto WATCHDOG_STATE_INTERFACE = "xyz.openbmc_project.State.Watchdog";

    static constexpr auto IPMI_SESSION_SERVICE = "xyz.openbmc_project.Ipmi.Channel.usb0";
    static constexpr auto IPMI_SESSION_SESSIONINFO_INTERFACE = "xyz.openbmc_project.Ipmi.SessionInfo";

    static const std::string OSUsername = "HostAutoOS";
    static const std::string FWUsername = "HostAutoFW";

    constexpr Cmd cmdOemGenerateRandomPassword = 0x5D;

    static inline auto responseHostInterfaceNotReady()
    {
        return response(0x85);
    }


} // namespace cmdsNetFnInventec

constexpr uint8_t BMC_INTF_NONE = 0x0;
constexpr uint8_t BMC_INTF_SUPPORTED = 0x1;
constexpr uint8_t BMC_INTF_ACTIVE = 0x2;

#ifdef SUPPORT_BIOS_OEM_CMD
namespace cmdsNetFnBios
{
    constexpr Cmd cmdGetBmcInfStatus = 0x3d;
    constexpr Cmd cmdEnableVHub = 0xaa;
    constexpr Cmd cmdGetVHubStatus = 0xab;
} // namespace cmdsNetFnBios

constexpr uint8_t BIOS_INTF_NONE = 0x0;
constexpr uint8_t BIOS_INTF_STARTED = 0x2;
constexpr uint8_t BIOS_INTF_ERROR = 0x4;
constexpr uint8_t BIOS_INTF_READY = 0x6;

constexpr uint8_t BIOS_IPMI_USB_INTF = 0x1;
constexpr uint8_t BIOS_LAN_USB_INTF = 0x2;
constexpr uint8_t BIOS_REDFISH_INTF = 0x4;
#endif //SUPPORT_BIOS_OEM_CMD

} // namespace inv
} // namespace ipmi
