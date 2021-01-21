#include <iostream>
#include <iomanip>
#include <fstream>
#include <netinet/ether.h>

#include "mac_util.hpp"


using namespace std;


static string getEepromPath(size_t bus, size_t address)
{
	stringstream output;
	output << "/sys/bus/i2c/devices/" << bus << "-" << std::right
	       << std::setfill('0') << std::setw(4) << std::hex << address
	       << "/eeprom";
	return output.str();
}


int parse_mac(char* out, char* in)
{
	int ret = 0;
	int i;
	int byte[MAC_UTIL_MAC_LEN] = {0};

	if (std::sscanf(in,
	                "%02x:%02x:%02x:%02x:%02x:%02x",
	                &byte[0], &byte[1], &byte[2],
	                &byte[3], &byte[4], &byte[5]) != MAC_UTIL_MAC_LEN) {
		std::fprintf(stderr, "%s is an invalid MAC address\n", in);
		ret = -1;
	}

	for (i = 0; i < MAC_UTIL_MAC_LEN; i++) {
		out[i] = byte[i];
	}


	return ret;
}


int get_mac(string path)
{
	int ret = 0;
	char mac_addr[MAC_UTIL_MAC_LEN] = {0};

	ifstream file (path.c_str(), ios::in | ios::binary | ios::ate);
	if (file.is_open()) {
		file.seekg (INVENTEC_MACADDR_EEPROM_OFFSET, ios::beg);
		file.read (mac_addr, MAC_UTIL_MAC_LEN);
		file.close();

		std::fprintf(stdout, "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
		             mac_addr[0], mac_addr[1], mac_addr[2],
		             mac_addr[3], mac_addr[4], mac_addr[5]);
	} else {
		std::fprintf(stderr, "Unable to oepn file %s\n", path.c_str());
	}


	return ret;
}

int set_mac(string path, char* mac_addr)
{
	int ret = 0;
	fstream file (path.c_str(), ios::out | ios::binary | ios::ate);

	if (file.is_open()) {
		file.seekp (INVENTEC_MACADDR_EEPROM_OFFSET, ios::beg);
		file.write (mac_addr, MAC_UTIL_MAC_LEN);
		file.close();

	} else {
		std::fprintf(stderr, "Unable to open file %s\n", path.c_str());
	}

	return ret;
}



int main(int argc, char* argv[])
{
	string path;
	int ret;
	int i;
	char mac_addr[MAC_UTIL_MAC_LEN] = {0};

	for (i = 0; i < argc; i++) {
		switch (argv[i][0]) {
		case 'r':
			path = getEepromPath(INVENTEC_MACADDR_I2C_BUS, INVENTEC_MACADDR_I2C_ADDR);
			ret = get_mac(path);
			/*leave loop*/
			i = argc;
			break;
		case 'w':
			if (argc < i + 2) {
				std::fprintf(stderr, "mac_util:input not enought\n");
				return -1;
			} else {
				path = getEepromPath(INVENTEC_MACADDR_I2C_BUS, INVENTEC_MACADDR_I2C_ADDR);
			}
			ret = parse_mac(mac_addr, argv[i + 1]);
			if (!ret) {
				ret = set_mac(path, mac_addr);
			}
			/*leave loop*/
			i = argc;
			break;
		default:
			break;
		}
	}

	return ret;
}


