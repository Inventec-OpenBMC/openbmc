## Inventec utilities
### Mac utility 
MAC address (eth address) read
```
/usr/bin/mac_util r
```
MAC address (eth address) write
```
/usr/bin/mac_util w $MAC_ADDRESS
/usr/bin/mac_util w 02:00:ff:00:00:01
```
<br>
The i2c parameters defined in include/mac_util.hpp.<br>
```
#define INVENTEC_MACADDR_I2C_BUS            8
#define INVENTEC_MACADDR_I2C_ADDR        0x53
#define INVENTEC_MACADDR_EEPROM_OFFSET  0x400
```
For different platform, should add bbappend to change the parameters.<br>

