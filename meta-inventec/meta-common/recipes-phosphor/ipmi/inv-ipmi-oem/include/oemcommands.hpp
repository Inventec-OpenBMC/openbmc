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

} // namespace cmdsNetFnInventec

constexpr uint8_t BMC_INTF_NONE = 0x0;
constexpr uint8_t BMC_INTF_SUPPORTED = 0x1;
constexpr uint8_t BMC_INTF_ACTIVE = 0x2;

#ifdef SUPPORT_BIOS_OEM_CMD
namespace cmdsNetFnBios
{
    constexpr Cmd cmdGetBmcInfStatusForBios = 0x3d;

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
