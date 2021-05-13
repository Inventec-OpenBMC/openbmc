#pragma once

#include <iostream>
#include <vector>
#include <filesystem>
#include <regex>
#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <sdbusplus/bus.hpp>

using DbusProperty = std::string;
using Value = std::variant<bool, uint8_t, int16_t, uint16_t, int32_t, uint32_t,
                           int64_t, uint64_t, double, std::string>;
using PropertyMap = std::map<DbusProperty, Value>;

constexpr auto PROP_INTERFACE = "org.freedesktop.DBus.Properties";
constexpr auto METHOD_SET = "Set";
constexpr auto METHOD_GET_ALL = "GetAll";


/**
 * @brief Get current timestamp in milliseconds.
 * 
 * @param[in] Null.
 * @return current timestamp in milliseconds.
 */
double getCurrentTimeWithMs()
{
    time_t s;
    long ms;
    struct timespec spec;

    clock_gettime(CLOCK_REALTIME, &spec);


    s  = spec.tv_sec;
    ms = round(spec.tv_nsec / 1.0e6); // Convert nanoseconds to milliseconds
    if (ms > 999) {
        s++;
        ms = 0;
    }

    double  result = (intmax_t)s + ((double)ms/1000);

    return result;
}



/**
 * @brief Get the DBUS Service name for the input dbus path.
 * @param[in] bus - DBUS Bus Object.
 * @param[in] intf - DBUS Interface.
 * @param[in] path - DBUS Object Path.
 */
std::string getService(std::shared_ptr<sdbusplus::asio::connection>& bus, const std::string& intf,
                       const std::string& path)
{

    auto mapperCall =
        bus->new_method_call("xyz.openbmc_project.ObjectMapper",
                            "/xyz/openbmc_project/object_mapper",
                            "xyz.openbmc_project.ObjectMapper", "GetObject");

    mapperCall.append(path);
    mapperCall.append(std::vector<std::string>({intf}));

    auto mapperResponseMsg = bus->call(mapperCall);

    if (mapperResponseMsg.is_method_error())
    {
        throw std::runtime_error("ERROR in mapper call");
    }

    std::map<std::string, std::vector<std::string>> mapperResponse;
    mapperResponseMsg.read(mapperResponse);

    if (mapperResponse.begin() == mapperResponse.end())
    {
        throw std::runtime_error("ERROR in reading the mapper response");
    }

    return mapperResponse.begin()->first;
}


/** @brief Gets all the properties associated with the given object
 *         and the interface.
 *  @param[in] bus - DBUS Bus Object.
 *  @param[in] service - Dbus service name.
 *  @param[in] objPath - Dbus object path.
 *  @param[in] interface - Dbus interface.
 *  @return On success returns the map of name value pair.
 */
PropertyMap getAllDbusProperties(std::shared_ptr<sdbusplus::asio::connection>& bus,
                                 const std::string& service,
                                 const std::string& objPath,
                                 const std::string& interface,
                                 std::chrono::microseconds timeout)
{
    PropertyMap properties;

    auto method = bus->new_method_call(service.c_str(), objPath.c_str(),
                                      PROP_INTERFACE, METHOD_GET_ALL);

    method.append(interface);

    auto reply = bus->call(method, timeout.count());

    if (reply.is_method_error())
    {
        std::fprintf(stderr,"Failed to get all properties");
    }

    reply.read(properties);
    return properties;
}


