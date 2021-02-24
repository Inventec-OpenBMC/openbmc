/*
*  Inventec virtual hwmon driver
*
*/
#ifndef _DRIVER_VIRTUAL_H_
#define _DRIVER_VIRTUAL_H_

#include <linux/kernel.h>

#define VIRTUAL_EEPROM_SIZE		1024


typedef enum _virtual_hwmon_type_enum {
	VIRTUAL_TEMP,
	VIRTUAL_EEPROM,
	VIRTUAL_PSU,
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

typedef struct _virtual_hwmon_psu_params_t {
	long   in1_input;
	long   in2_input;
	long   in3_input;
	long   curr1_input;
	long   curr2_input;
	long   power1_input;
	long   power2_input;
	long   fan1_input;
	long   fan2_input;
	u8  pwm1_input;
	long   temp1_input;
} virtual_hwmon_psu_params_t;


/* Each client has this additional data */
typedef struct _virtual_hwmon_data_t {
	struct i2c_client  *client;
	virtual_hwmon_type_enum  kind;
	void  *params;
} virtual_hwmon_data_t;



#endif
