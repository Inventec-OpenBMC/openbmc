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
#include <fstream>
#include <gpiod.h>

using namespace std;

namespace ipmi
{
static void registerOEMFunctions() __attribute__((constructor));

static vector<string> getDirFiles(string dirPath, string regexStr)
{
    vector<string> result;

    for (const auto& entry : filesystem::directory_iterator(dirPath))
    {
        // If filename matched the regular expression put it in result.
        if (regex_match(entry.path().filename().string(), regex(regexStr)))
        {
            result.emplace_back(move(entry.path().string()));
        }
    }

    return result;
}

ipmi::RspType<uint8_t> ipmiOemSetFanPwm(uint8_t fanId, uint8_t pwm)
{
    uint8_t rc = 0;
    uint32_t newFanId = 0;
    uint32_t scaledPwm = 0;
    
    if (fanId < FAN_ID_MIN ||
        fanId > FAN_ID_MAX) {
        phosphor::logging::log<phosphor::logging::level::INFO>(
        "fanId out of range");
        return ipmi::responseUnspecifiedError();
    }
    if (pwm > PWM_MAX) {
        phosphor::logging::log<phosphor::logging::level::INFO>(
        "pwm out of range");
        return ipmi::responseUnspecifiedError();
    }

    newFanId = fanId - FAN_ID_BASE;
    scaledPwm = static_cast<uint32_t>(pwm) * PWM_REG_RANGE / PWM_RANGE;
    auto pwmDirVec = getDirFiles(parentPwmDir, "hwmon[0-9]+");
    if (pwmDirVec.size() != 1)
    {
        phosphor::logging::log<phosphor::logging::level::INFO>(
        "didnt find unique hwmon path");
        return ipmi::responseUnspecifiedError();
    }
    auto pwmFilePath = pwmDirVec[0] + "/pwm" + std::to_string(newFanId);
    std::ofstream ofs;
    ofs.open(pwmFilePath);
    if (!ofs.is_open()) {
        phosphor::logging::log<phosphor::logging::level::INFO>(
        "fail to open the file");
        return ipmi::responseUnspecifiedError();
    }
    ofs << static_cast<int64_t>(scaledPwm);
    ofs.close(); 
    phosphor::logging::log<phosphor::logging::level::INFO>(
    "set fan pwm ok");
    return ipmi::responseSuccess(rc);
}

static void registerOEMFunctions(void)
{
    phosphor::logging::log<phosphor::logging::level::INFO>(
        "Registering INV TRANSFORMERS OEM commands");

    registerOemCmdHandler(inv::netFnOem30, inv::cmdsNetFnOem30::cmdSetFanPwm,
                            Privilege::Admin, ipmiOemSetFanPwm);
}

} // namespace ipmi
