/*
*  Inventec virtual hwmon driver
*
*/
#ifndef _DRIVER_VIRTUAL_H_
#define _DRIVER_VIRTUAL_H_

#include <linux/kernel.h>

#define VIRTUAL_EEPROM_SIZE		256


typedef enum _virtual_hwmon_type_enum {
	VIRTUAL_TMP,
	VIRTUAL_EEPROM,
} virtual_hwmon_type_enum;


typedef struct _virtual_hwmon_temp_params_t {
	long  value1;
	long  value2;
	long  value3;
	long  value4;
	long  value5;
	long  value6;
	long  value7;
	long  value8;
	long  value9;
} virtual_hwmon_temp_params_t;

typedef struct _virtual_hwmon_eeprom_params_t {
	u8 data[VIRTUAL_EEPROM_SIZE];
} virtual_hwmon_eeprom_params_t;


/* Each client has this additional data */
typedef struct _virtual_hwmon_data_t {
	struct i2c_client  *client;
	virtual_hwmon_type_enum  kind;
	void  *params;
} virtual_hwmon_data_t;



#endif
