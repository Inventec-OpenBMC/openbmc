/*
*  Inventec virtual hwmon driver
*
*/


#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/i2c.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/of_device.h>
#include <linux/of.h>
#include <linux/regmap.h>
#include <linux/util_macros.h>
#include "virtual.h"


static virtual_hwmon_temp_params_t device_params_temp = {
	.value1 = 0,
	.value2 = 0,
	.value3 = 0,
	.value4 = 0,
	.value5 = 0,
	.value6 = 0,
	.value7 = 0,
	.value8 = 0,
	.value9 = 0,
};

static virtual_hwmon_eeprom_params_t device_params_eeprom = {
	.data = {
			0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0xfe, 0x01, 0x09, 0x19, 0x49, 0xbd, 0xc2, 0xca, 0x49,
			0x6e, 0x76, 0x65, 0x6e, 0x74, 0x65, 0x63, 0x20, 0x20, 0xc8, 0x53, 0x43, 0x4d, 0x20, 0x20, 0x20,
			0x20, 0x20, 0xca, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0xcc, 0x31, 0x33,
			0x39, 0x35, 0x41, 0x33, 0x32, 0x30, 0x39, 0x34, 0x30, 0x31, 0xc9, 0x46, 0x52, 0x55, 0x20, 0x76,
			0x30, 0x2e, 0x30, 0x39, 0xc4, 0x41, 0x20, 0x20, 0x20, 0xc1, 0x00, 0x00, 0x00, 0x00, 0x00,		
		}
};


static const struct i2c_device_id virtual_hwmon_ids[] = {
	{ "virtual_tmp", VIRTUAL_TMP, },
	{ "virtual_eeprom", VIRTUAL_EEPROM, },
	{ /* LIST END */ }
};
MODULE_DEVICE_TABLE(i2c, virtual_hwmon_ids);

static const struct of_device_id __maybe_unused virtual_hwmon_of_match[] = {
	{
		.compatible = "inventec,virtual_tmp",
		.data = (void *)VIRTUAL_TMP
	},
	{
		.compatible = "inventec,virtual_eeprom",
		.data = (void *)VIRTUAL_EEPROM
	},
	{ },
};
MODULE_DEVICE_TABLE(of, virtual_hwmon_of_match);




static umode_t virtual_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
			       u32 attr, int channel)
{
	switch (type) {
	case hwmon_temp:
		switch (attr) {
		case hwmon_temp_input:
			return 0644;
		}
		break;
	default:
		break;
	}
	return 0;
}


static int virtual_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
		     u32 attr, int channel, long *val)
{
	virtual_hwmon_data_t *data = dev_get_drvdata(dev);
	virtual_hwmon_temp_params_t *para = data->params;

	switch (attr) {
	case hwmon_temp_input:
		switch(channel) {
		case 0:
			*val = para->value1;
			break;
		case 1:
			*val = para->value2;
			break;
		case 2:
			*val = para->value3;
			break;
		case 3:
			*val = para->value4;
			break;
		case 4:
			*val = para->value5;
			break;
		case 5:
			*val = para->value6;
			break;
		case 6:
			*val = para->value7;
			break;
		case 7:
			*val = para->value8;
			break;
		case 8:
			*val = para->value9;
			break;
		default:
			dev_info(dev, "hwmon temp not support channel %d\n", channel);
			return -EINVAL;
		}
		break;
	default:
		dev_info(dev, "hwmon temp not support attr %d\n", attr);
		return -EINVAL;
	}

	return 0;
}


static int virtual_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
		      u32 attr, int channel, long val)
{
	virtual_hwmon_data_t *data = dev_get_drvdata(dev);
	virtual_hwmon_temp_params_t *para = data->params;


	switch (attr) {
	case hwmon_temp_input:
		switch(channel) {
		case 0:
			para->value1 = val;
			break;
		case 1:
			para->value2 = val;
			break;
		case 2:
			para->value3 = val;
			break;
		case 3:
			para->value4 = val;
			break;
		case 4:
			para->value5 = val;
			break;
		case 5:
			para->value6 = val;
			break;
		case 6:
			para->value7 = val;
			break;
		case 7:
			para->value8 = val;
			break;
		case 8:
			para->value9 = val;
			break;
		default:
			dev_info(dev, "hwmon temp not support channel %d\n", channel);
			return -EINVAL;
		}
		break;
	default:
		dev_info(dev, "hwmon temp not support attr %d\n", attr);
		return -EINVAL;
	}
	return 0;
}


static ssize_t virtual_eeprom_read(struct file *filp, struct kobject *kobj,
			   struct bin_attribute *bin_attr,
			   char *buf, loff_t off, size_t count)
{
	struct i2c_client *client = to_i2c_client(kobj_to_dev(kobj));
	virtual_hwmon_data_t *data = i2c_get_clientdata(client);
	virtual_hwmon_eeprom_params_t *para = data->params;

	memcpy(buf, &para->data[off], count);

	return count;
}


static ssize_t virtual_eeprom_write(struct file *filp, struct kobject *kobj,
			   struct bin_attribute *bin_attr,
			   char *buf, loff_t off, size_t count)
{
	struct i2c_client *client = to_i2c_client(kobj_to_dev(kobj));
	virtual_hwmon_data_t *data = i2c_get_clientdata(client);
	virtual_hwmon_eeprom_params_t *para = data->params;

	memcpy(&para->data[off],buf, count);

	return count;
}


/*************************/

static const struct hwmon_channel_info *virtual_hwmon_info[] = {
	HWMON_CHANNEL_INFO(temp,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT,
			   HWMON_T_INPUT),
	NULL
};

static const struct hwmon_ops virtual_hwmon_ops = {
	.is_visible = virtual_hwmon_is_visible,
	.read = virtual_hwmon_read,
	.write = virtual_hwmon_write,
};

static const struct hwmon_chip_info virtual_hwmon_chip_info = {
	.ops = &virtual_hwmon_ops,
	.info = virtual_hwmon_info,
};


static const struct bin_attribute virtual_eeprom_attr = {
	.attr = {
		.name = "eeprom",
		.mode = S_IRUGO|S_IWUGO ,
	},
	.size = VIRTUAL_EEPROM_SIZE,
	.read = virtual_eeprom_read,
	.write = virtual_eeprom_write,
};


/*******
  Remove
*******/

static int virtual_hwmon_remove(struct i2c_client *client)
{
	struct device *dev = &client->dev;
	virtual_hwmon_data_t *data = dev_get_drvdata(dev);
	int err = 0;

	switch(data->kind)
	{
	case VIRTUAL_TMP:
		break;
	case VIRTUAL_EEPROM:
		sysfs_remove_bin_file(&client->dev.kobj, &virtual_eeprom_attr);
		break;
	default:
		dev_info(dev, "sensor '%s' not support kind %d\n", client->name, data->kind);
		err = -EINVAL;
		break;
	}

	dev_info(dev, "sensor '%s'\n", client->name);

	return err;
}


/*******
  Probe
*******/

static int
virtual_tmp_probe(struct i2c_client *client )
{
	struct device *dev = &client->dev;
	struct device *hwmon_dev;
	virtual_hwmon_data_t *data;
	int err;

	err = 0;

	data = devm_kzalloc(dev, sizeof(virtual_hwmon_data_t), GFP_KERNEL);
	if (!data) {
		return -ENOMEM;
	}

	data->client = client;
	data->kind = VIRTUAL_TMP;
	data->params = &device_params_temp;

	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
							 data, &virtual_hwmon_chip_info,
							 NULL);

	if (IS_ERR(hwmon_dev))
		return PTR_ERR(hwmon_dev);

	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);

	return err;
}

static int
virtual_eeprom_probe(struct i2c_client *client )
{
	struct device *dev = &client->dev;
	virtual_hwmon_data_t *data;

	data = devm_kzalloc(dev, sizeof(virtual_hwmon_data_t), GFP_KERNEL);
	if (!data) {
		return -ENOMEM;
	}

	data->client = client;
	data->kind = VIRTUAL_EEPROM;
	data->params = &device_params_eeprom;

	i2c_set_clientdata(client, data);

	/* create the sysfs eeprom file */
	return sysfs_create_bin_file(&client->dev.kobj, &virtual_eeprom_attr);
}

static int
virtual_hwmon_probe(struct i2c_client *client, const struct i2c_device_id *id)
{
	struct device *dev = &client->dev;
	virtual_hwmon_type_enum kind;
	int err;

	err = 0;

	if (client->dev.of_node)
		kind = (virtual_hwmon_type_enum)of_device_get_match_data(&client->dev);
	else
		kind = id->driver_data;

	switch (kind) {
	case VIRTUAL_TMP:
		err = virtual_tmp_probe(client);
		break;
	case VIRTUAL_EEPROM:
		err = virtual_eeprom_probe(client);
		break;
	default:
		dev_info(dev, "sensor '%s' not support kind\n", client->name, kind);
		err = -EINVAL;
		break;
	}

	return err;
}


static struct i2c_driver virtual_driver = {
	.class		= I2C_CLASS_HWMON,
	.driver = {
		.name	= "virtual",
		.of_match_table = of_match_ptr(virtual_hwmon_of_match),
	},
	.probe		= virtual_hwmon_probe,
	.remove     = virtual_hwmon_remove,
	.id_table	= virtual_hwmon_ids,
};

module_i2c_driver(virtual_driver);


MODULE_AUTHOR("Inventec");
MODULE_DESCRIPTION("virtual hwmon driver");
MODULE_LICENSE("GPL");



