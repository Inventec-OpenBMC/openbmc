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

#include <array>
#include <filesystem>
#include <iostream>
#include <regex>
#include <string>
#include <variant>
#include <vector>
#include <peci.h>

using namespace std;

namespace ipmi
{
static void registerOEMFunctions() __attribute__((constructor));

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
static void registerOEMFunctions(void)
{
    phosphor::logging::log<phosphor::logging::level::INFO>(
        "Registering INV OEM commands");

    /*This is an example of IPMI OEM command registration*/
#if EXAMPLE
    registerOemCmdHandler(inv::netFnOem3e, inv::cmdsNetFnOem3e::cmdExample,
                            Privilege::Admin, ipmiOemExampleCommand);
#endif
    registerOemCmdHandler(inv::netFnOem30, inv::cmdsNetFnOem30::cmdSendRawPeci,
                            Privilege::Admin, ipmiOemSendRawPeci);
}

} // namespace ipmi
