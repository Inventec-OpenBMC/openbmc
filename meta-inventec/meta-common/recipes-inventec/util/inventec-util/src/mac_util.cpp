#include <iostream>
#include <iomanip>
#include <fstream>
#include <string.h> 
#include <netinet/ether.h>

#include "mac_util.hpp"


using namespace std;

static void print_help(void)
{
	printf("mac_util usage:\n");
	printf("\n");
	printf("mac_util r <interface name>\n");
	printf("mac_util w <interface name> <mac address>\n");
	printf("\n");
	printf("example:\n");
	printf("mac_util r eth0\n");
	printf("0x38 0x68 0xdd 0x3e 0x99 0xec\n");
	printf("\n");
	printf("mac_util w eth0 02:00:ff:00:00:01\n");
	printf("\n");
	return;
}



static IntfInfo* findIntfInfo(char* intfName)
{
	int intfSize, i;
	IntfInfo* ret=NULL;

	intfSize = sizeof(intfInfoList)/sizeof(IntfInfo);

	for(i=0; i< intfSize; i++)
	{
		if(strcmp(intfName,intfInfoList[i].name)==0)
		{
			ret = &intfInfoList[i];
			break;
		}
	}
	return ret;
}

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


int get_mac(string path, int offset)
{
	int ret = 0;
	char mac_addr[MAC_UTIL_MAC_LEN] = {0};

	ifstream file (path.c_str(), ios::in | ios::binary | ios::ate);
	if (file.is_open()) {
		file.seekg (offset, ios::beg);
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

int set_mac(string path, char* mac_addr, int offset)
{
	int ret = 0;
	fstream file (path.c_str(), ios::out | ios::binary | ios::ate);

	if (file.is_open()) {
		file.seekp (offset, ios::beg);
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
	IntfInfo* intfInfo;

	for (i = 0; i < argc; i++) {
		switch (argv[i][0]) {
		case 'r':
			if (argc < i + 2) {
				std::fprintf(stderr, "mac_util:input not enought\n");
				print_help();
				return -1;
			}
			intfInfo = findIntfInfo(argv[i + 1]);
			if(intfInfo == NULL)
			{
				std::fprintf(stderr, "mac_util:interface %s not found\n",argv[i + 1]);
				return -1;
			}
		
			path = getEepromPath(intfInfo->bus, intfInfo->address);
			ret = get_mac(path, intfInfo->offset);
			/*leave loop*/
			i = argc;
			break;
		case 'w':
			if (argc < i + 3) {
				std::fprintf(stderr, "mac_util:input not enought\n");
				print_help();
				return -1;
			}
			intfInfo = findIntfInfo(argv[i + 1]);
			if(intfInfo == NULL)
			{
				std::fprintf(stderr, "mac_util:interface %s not found\n",argv[i + 1]);
				return -1;
			}

			path = getEepromPath(intfInfo->bus, intfInfo->address);

			ret = parse_mac(mac_addr, argv[i + 2]);
			if (!ret) {
				ret = set_mac(path, mac_addr, intfInfo->offset);
			}
			/*leave loop*/
			i = argc;
			break;
		case 'h':
			print_help();
		default:
			break;
		}
	}

	return ret;
}


