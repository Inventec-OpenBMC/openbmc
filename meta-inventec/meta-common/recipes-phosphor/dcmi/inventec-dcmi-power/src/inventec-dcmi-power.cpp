#include "inventec-dcmi-power.hpp"
#include "util.hpp"

#include <iostream>
#include <nlohmann/json.hpp>


using namespace std;

static constexpr bool DEBUG = false;


std::shared_ptr<sdbusplus::asio::connection> bus;
std::shared_ptr<sdbusplus::asio::dbus_interface> powerInterface;
PowerStore powerStore;


void setPowerPath(PowerStore& powerStore)
{
	std::ifstream sensorFile(POWER_READING_SENSOR);
	std::string objectPath;
	if (!sensorFile.is_open()) {
		std::fprintf(stderr, "Power reading configuration file not found");
		throw std::runtime_error("error");
	}

	auto data = nlohmann::json::parse(sensorFile, nullptr, false);
	if (data.is_discarded()) {
		std::fprintf(stderr, "Error in parsing configuration file");
		throw std::runtime_error("error");
	}

	objectPath = data.value("path", "");
	if (objectPath.empty()) {
		std::fprintf(stderr, "Power sensor D-Bus object path is empty");
		throw std::runtime_error("error");
	}

	powerStore.powerPath = objectPath;
}



double readPower(void)
{
	double value;
	try {
		auto service = getService(bus, SENSOR_VALUE_INTF, powerStore.powerPath);

		// Read the sensor value and scale properties
		auto properties = getAllDbusProperties(bus, service, powerStore.powerPath,
		                                       SENSOR_VALUE_INTF, DBUS_TIMEOUT);
		value = std::get<double>(properties[SENSOR_VALUE_PROP]);
	} catch (std::exception& e) {
		std::fprintf(stderr, "Failure to read power value from D-Bus object %s\n",
		             powerStore.powerPath.c_str());
		throw std::runtime_error("Failure to read power value from D-Bus object");
	}
	return value;
}



inline static sdbusplus::bus::match::match
startPowerCapMonitor(std::shared_ptr<sdbusplus::asio::connection> conn, PowerStore& powerStore)
{
	auto powerCapMatcherCallback = [&](sdbusplus::message::message & msg) {
		std::string interface;
		boost::container::flat_map<std::string, std::variant<std::string, uint16_t, bool, uint32_t>> propertiesChanged;
		msg.read(interface, propertiesChanged);
		std::string event = propertiesChanged.begin()->first;

		if (propertiesChanged.empty() || event.empty()) {
			return;
		}

		if (event == "SamplingPeriod") {
			auto value = std::get_if<uint32_t>(&propertiesChanged.begin()->second);
			powerStore.samplingPeriod = *value;
		}
		if (event == "PowerCapEnable") {
			auto value = std::get_if<bool>(&propertiesChanged.begin()->second);
			powerStore.powerCapEnable = *value;
			powerStore.actionEnable = *value;
		}
		if (event == "CorrectionTime") {
			auto value = std::get_if<uint32_t>(&propertiesChanged.begin()->second);
			powerStore.correctionTime = *value;
		}
		if (event == "ExceptionAction") {
			auto value = std::get_if<std::string>(&propertiesChanged.begin()->second);
			powerStore.exceptionAction = *value;
		}
		if (event == "PowerCap") {
			auto value = std::get_if<uint32_t>(&propertiesChanged.begin()->second);
			powerStore.powerCap = *value;
		}

		if constexpr (DEBUG) {
			std::cerr << "Properties changed event: " << event << "\n";
			std::cerr << "PowerStore.samplingPeriod: " <<  powerStore.samplingPeriod << "\n";
			std::cerr << "PowerStore.powerCapEnable: " <<  powerStore.powerCapEnable << "\n";
			std::cerr << "PowerStore.correctionTime: " <<  powerStore.correctionTime << "\n";
			std::cerr << "PowerStore.exceptionAction: " <<  powerStore.exceptionAction << "\n";
			std::cerr << "PowerStore.powerCap: " <<  powerStore.powerCap << "\n";
		}

	};

	sdbusplus::bus::match::match powerCapMatcher(
	    static_cast<sdbusplus::bus::bus &>(*conn),
	    "type='signal',interface='org.freedesktop.DBus.Properties',member='"
	    "PropertiesChanged',arg0namespace='xyz.openbmc_project.Control.Power.Cap'",
	    std::move(powerCapMatcherCallback));

	return powerCapMatcher;
}

void powerHandler(boost::asio::io_context& io, PowerStore& powerStore, double delay)
{
	static boost::asio::steady_timer timer(io);

	timer.expires_after(std::chrono::microseconds((long)delay));

	timer.async_wait([&io, &powerStore](const boost::system::error_code&) {
		double start, end, delayTime;
		double max = 0;
		double min = 0;
		double average = 0;
		uint64_t averageCount = 0;
		Power currentPower;

		start = getCurrentTimeWithMs();

		currentPower.time = start * MILLI_OFFSET;


		try {
			currentPower.value = readPower();
		} catch (...) {
			end = getCurrentTimeWithMs();
			delayTime = (SAMPLING_INTERVEL - (end - start)) * MICRO_OFFSET;
			if (delayTime < 0) {
				delayTime = 0;
			}

			powerHandler(io, powerStore, delayTime);
			return;
		}

		if (powerStore.collectedPower.size() >= MAX_COLLECTION_POWER_SIZE) {
			powerStore.collectedPower.erase(powerStore.collectedPower.begin());
			powerStore.collectedPower.push_back(currentPower);
		} else {
			powerStore.collectedPower.push_back(currentPower);
		}

		end = getCurrentTimeWithMs();
		delayTime = (SAMPLING_INTERVEL - (end - start)) * MICRO_OFFSET;
		if (delayTime < 0) {
			delayTime = 0;
		}

		powerHandler(io, powerStore, delayTime);
		return;
	});
}


double get_power(void)
{
	Power currentPower;

	if (powerStore.collectedPower.size() == 0) {
		currentPower.time = getCurrentTimeWithMs() * MILLI_OFFSET;

		try {
			currentPower.value = readPower();
		} catch (...) {
			std::fprintf(stderr, "cannot get power value\n");
			return 0;
		}
		powerStore.collectedPower.push_back(currentPower);
	} else {
		currentPower = *powerStore.collectedPower.rbegin();
	}

	return currentPower.value;
}


double get_power_max(void)
{
	double max = 0;
	double currentTime = getCurrentTimeWithMs() * MILLI_OFFSET;
	bool init = true;


	for (auto it = powerStore.collectedPower.rbegin(); it != powerStore.collectedPower.rend(); it++) {
		if (init) {
			max = it->value;
			init = false;
		}

		if (it->time + (powerStore.samplingPeriod * MILLI_OFFSET) < currentTime) {
			break;
		}
		if (max < it->value ) {
			max = it->value;
		}
	}

	return max;
}

double get_power_min(void)
{
	double min = 0;
	double currentTime = getCurrentTimeWithMs() * MILLI_OFFSET;
	bool init = true;

	for (auto it = powerStore.collectedPower.rbegin(); it != powerStore.collectedPower.rend(); it++) {
		if (init) {
			min = it->value;
			init = false;
		}
		if (it->time + (powerStore.samplingPeriod * MILLI_OFFSET) < currentTime) {
			break;
		}
		if (min > it->value ) {
			min = it->value;
		}

	}

	return min;
}

double get_power_average(void)
{
	double average = 0;
	uint32_t averageCount = 0;
	double currentTime = getCurrentTimeWithMs() * MILLI_OFFSET;

	for (auto it = powerStore.collectedPower.rbegin(); it != powerStore.collectedPower.rend(); it++) {
		if (it->time + (powerStore.samplingPeriod * MILLI_OFFSET) < currentTime) {
			if (averageCount) {
				average = average / averageCount;
			} else {
				average = powerStore.collectedPower.rbegin()->value;
			}
			break;
		}
		average = average + it->value;
		averageCount++;
	}

	return average;
}


uint32_t get_last_sample_time(void)
{
	Power currentPower;


	if (powerStore.collectedPower.size() == 0) {
		currentPower.time = getCurrentTimeWithMs() * MILLI_OFFSET;

		try {
			currentPower.value = readPower();
		} catch (...) {
			std::fprintf(stderr, "cannot get power value\n");
			return 0;
		}
		powerStore.collectedPower.push_back(currentPower);
	} else {
		currentPower = *powerStore.collectedPower.rbegin();
	}

	return (uint32_t)currentPower.time/MILLI_OFFSET;
}



uint32_t get_average_count(void)
{
	uint32_t averageCount = 0;

	double currentTime = getCurrentTimeWithMs() * MILLI_OFFSET;

	for (auto it = powerStore.collectedPower.rbegin(); it != powerStore.collectedPower.rend(); it++) {
		if (it->time + (powerStore.samplingPeriod * MILLI_OFFSET) < currentTime) {
			break;
		}
		averageCount++;
	}

	return averageCount;
}



int main(int argc, char *argv[])
{
	boost::asio::io_context  io;
	bus = std::make_shared<sdbusplus::asio::connection>(io);
	bus->request_name(DCMI_SERVICE);
	sdbusplus::asio::object_server objectServer(bus);

	try {
		setPowerPath(powerStore);
	} catch (std::exception& e) {
		std::fprintf(stderr, "cannot find patch setting\n");
		return -1;
	}

	/* Init property setting*/
	powerInterface = objectServer.add_interface(DCMI_POWER_PATH, DCMI_POWER_INTERFACE);


	powerInterface->register_property_r(
	    "TotalPower", double(),
	    sdbusplus::vtable::property_::emits_change,
	    [](const auto &) {
	        return get_power();
	    });

	powerInterface->register_property_r(
	    "MaxValue", double(),
	    sdbusplus::vtable::property_::emits_change,
	    [](const auto &) {
	        return get_power_max();
	    });


	powerInterface->register_property_r(
	    "MinValue", double(),
	    sdbusplus::vtable::property_::emits_change,
	    [](const auto &) {
	        return get_power_min();
	    });

	powerInterface->register_property_r(
	    "AverageValue", double(),
	    sdbusplus::vtable::property_::emits_change,
	    [](const auto &) {
	        return get_power_average();
	    });

	powerInterface->register_property_r(
	    "LastSampleTime", uint32_t(),
	    sdbusplus::vtable::property_::emits_change,
	    [](const auto &) {
	        return get_last_sample_time();
	    });

	powerInterface->register_property_r(
	    "AverageCount", uint32_t(),
	    sdbusplus::vtable::property_::emits_change,
	    [](const auto &) {
	        return get_average_count();
	    });



	powerInterface->initialize();



	sdbusplus::bus::match::match powerCapMonitor = startPowerCapMonitor(bus, powerStore);

	io.post(
		[&]() { powerHandler(io, powerStore, 0); });

	io.run();

	return 0;
}



