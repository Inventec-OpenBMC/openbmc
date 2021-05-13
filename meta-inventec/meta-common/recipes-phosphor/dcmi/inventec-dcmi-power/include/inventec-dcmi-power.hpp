#pragma once

#include <iostream>
#include <vector>
#include <variant>
#include <filesystem>
#include <fstream>
#include <chrono>
#include <unistd.h>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/replace.hpp>
#include <boost/container/flat_map.hpp>
#include <boost/container/flat_set.hpp>
#include <boost/asio/io_context.hpp>
#include <boost/asio/steady_timer.hpp>
#include <sdbusplus/bus.hpp>
#include <sdbusplus/server.hpp>
#include <sdbusplus/asio/connection.hpp>
#include <sdbusplus/asio/object_server.hpp>

constexpr auto MILLI_OFFSET = 1000;
constexpr auto MICRO_OFFSET = 1000000;
constexpr auto MAX_COLLECTION_POWER_SIZE = 86400; /*if interval is 1, sample for 24HR*/
constexpr auto SAMPLING_INTERVEL = 1; /*in sec*/

constexpr auto SENSOR_VALUE_INTF = "xyz.openbmc_project.Sensor.Value";
constexpr auto SENSOR_VALUE_PROP = "Value";
constexpr auto POWER_READING_SENSOR = "/usr/share/ipmi-providers/power_reading.json";


constexpr auto DCMI_SERVICE = "xyz.openbmc_project.DCMI";
constexpr auto DCMI_POWER_PATH = "/xyz/openbmc_project/DCMI/Power";
constexpr auto DCMI_POWER_INTERFACE = "xyz.openbmc_project.DCMI.Value";
constexpr auto PCAP_PATH = "/xyz/openbmc_project/control/host0/power_cap";
constexpr auto PCAP_INTERFACE = "xyz.openbmc_project.Control.Power.Cap";

constexpr auto PERIOD_MAX_PROP = "MaxValue";
constexpr auto PERIOD_MIN_PROP = "MinValue";
constexpr auto PERIOD_AVERAGE_PROP = "AverageValue";
constexpr auto POWER_CAP_PROP = "PowerCap";
constexpr auto POWER_CAP_ENABLE_PROP = "PowerCapEnable";
constexpr auto EXCEPTION_ACTION_PROP = "ExceptionAction";
constexpr auto CORRECTION_TIME_PROP = "CorrectionTime";
constexpr auto SAMPLING_PERIOD_PROP = "SamplingPeriod";

constexpr std::chrono::microseconds DBUS_TIMEOUT = std::chrono::microseconds(5*1000000);


typedef struct{
    double time = 0;
    double value = 0; /*in Watts*/
}Power;


typedef struct{
    double max=0;
    double min=0;
    double average=0;
    bool powerCapEnable=false;
    bool actionEnable=true;
    uint32_t samplingPeriod=0;
    uint32_t correctionTime=0;
    uint32_t correctionTimeout=0;
    uint32_t powerCap=0;
    std::string exceptionAction="";
    std::string powerPath="";
    std::vector<Power> collectedPower;
}PowerStore;




