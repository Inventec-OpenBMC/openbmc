#pragma once

#include <string>
#include <vector>


#define INTF_NAME_MAX_LEN 50
#define MAC_UTIL_MAC_LEN  6

typedef struct IntfInfoStruct
{
    char name[INTF_NAME_MAX_LEN];
    int bus;
    int address;
    int offset;
}IntfInfo;


IntfInfo intfInfoList[] = {
    {"eth0", 8, 0x51, 0x400},
    {"eth1", 8, 0x51, 0x406}
};

