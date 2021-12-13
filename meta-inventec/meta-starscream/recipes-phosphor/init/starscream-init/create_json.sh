#!/bin/sh

# create_json.sh $Target $bus

if [ -z $1 ]; then
    echo "I2C bus not given"
fi

if [ -z $2 ]; then
    echo "I2C bus not given"
fi

SPECIAL_CHAR="$"
BASIC_I2C_BUS=$2
ENTITY_MANAGER_CONIG_PATH="/usr/share/entity-manager/configurations"
ENTITY_MANAGER_RISER1_JSON="$ENTITY_MANAGER_CONIG_PATH/riser1.json"
ENTITY_MANAGER_RISER2_JSON="$ENTITY_MANAGER_CONIG_PATH/riser2.json"
ENTITY_MANAGER_BP1_JSON="$ENTITY_MANAGER_CONIG_PATH/bp1.json"
ENTITY_MANAGER_BP2_JSON="$ENTITY_MANAGER_CONIG_PATH/bp2.json"

NVME_CONFG_JSON="/etc/nvme/nvme_config.json"
NVME_EACH_BP=11

create_riser1() {
# BASIC_I2C_BUS would expect to be 28 in full device
# Riser1_FRU - 30(BASIC_I2C_BUS + 2) - 0x50
# PAC1934_U1 - 21(Fixed) - 0x12
# EMC1462T_U6 - 31(BASIC_I2C_BUS + 3) - 0x3c

cat <<EOF >$ENTITY_MANAGER_RISER1_JSON
{
    "Exposes": [
        {
            "Bus": "21",
            "Address": "0x12",
            "Index": 0,
            "Name": "Riser1_1_12V",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 13.0
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 11.0
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser1_1_12V",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x10",
                    "EntityId": "0x05",
                    "EntityInstance": "0"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "21",
            "Address": "0x12",
            "Index": 1,
            "Name": "Riser1_1_3V3",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 4.3
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 2.3
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser1_1_3V3",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x11",
                    "EntityId": "0x05",
                    "EntityInstance": "1"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "21",
            "Address": "0x12",
            "Index": 2,
            "Name": "Riser1_2_12V",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 13.0
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 11.0
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser1_2_12V",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x12",
                    "EntityId": "0x05",
                    "EntityInstance": "2"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "21",
            "Address": "0x12",
            "Index": 3,
            "Name": "Riser1_2_3V3",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 4.3
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 2.3
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser1_2_3V3",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x13",
                    "EntityId": "0x05",
                    "EntityInstance": "3"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "$(($BASIC_I2C_BUS+3))",
            "Address": "0x3C",
            "Name": "Riser1_Temp",
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 56
                },
                {
                    "Direction": "greater than",
                    "Name": "upper non critical",
                    "Severity": 0,
                    "Value": 55
                },
                {
                    "Direction": "less than",
                    "Name": "lower non critical",
                    "Severity": 0,
                    "Value": 10
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 5
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser1_Temp",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x14",
                    "EntityId": "0x05",
                    "EntityInstance": "4"
                }
            ],
            "Type": "EMC1412"
        }
    ],
    "Name": "riser1",
    "Probe": "xyz.openbmc_project.FruDevice({'BUS': $(($BASIC_I2C_BUS+2)), 'ADDRESS' : 80})",
    "Type": "Board",
    "xyz.openbmc_project.Inventory.Decorator.Asset": {
        "Manufacturer": "${SPECIAL_CHAR}BOARD_MANUFACTURER",
        "Model": "${SPECIAL_CHAR}BOARD_PRODUCT_NAME",
        "PartNumber": "${SPECIAL_CHAR}BOARD_PART_NUMBER",
        "SerialNumber": "${SPECIAL_CHAR}BOARD_SERIAL_NUMBER",
        "BuildDate": "${SPECIAL_CHAR}BOARD_MANUFACTURE_DATE"
    },
    "xyz.openbmc_project.Inventory.Decorator.FruDevice":{
        "Bus":$(($BASIC_I2C_BUS+2)),
        "Address":80
    },
    "xyz.openbmc_project.Inventory.Decorator.Ipmi": {
        "EntityId": "0x05",
        "EntityInstance": 0
    }
}
EOF
}

create_riser2() {
# BASIC_I2C_BUS would expect to be 32 in full device
# Riser2_FRU - 34(BASIC_I2C_BUS + 2) - 0x50
# PAC1934_U1 - 22(Fixed) - 0x12
# EMC1462T_U6 - 35(BASIC_I2C_BUS + 3) - 0x3c

cat <<EOF >$ENTITY_MANAGER_RISER2_JSON
{
    "Exposes": [
        {
            "Bus": "22",
            "Address": "0x12",
            "Index": 0,
            "Name": "Riser2_1_12V",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 13.0
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 11.0
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser2_1_12V",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x15",
                    "EntityId": "0x05",
                    "EntityInstance": "5"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "22",
            "Address": "0x12",
            "Index": 1,
            "Name": "Riser2_1_3V3",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 4.3
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 2.3
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser2_1_3V3",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x16",
                    "EntityId": "0x05",
                    "EntityInstance": "6"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "22",
            "Address": "0x12",
            "Index": 2,
            "Name": "Riser2_2_12V",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 13.0
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 11.0
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser2_2_12V",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x17",
                    "EntityId": "0x05",
                    "EntityInstance": "7"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "22",
            "Address": "0x12",
            "Index": 3,
            "Name": "Riser2_2_3V3",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 4.3
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 2.3
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser2_2_3V3",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x18",
                    "EntityId": "0x05",
                    "EntityInstance": "8"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "$(($BASIC_I2C_BUS+3))",
            "Address": "0x3C",
            "Name": "Riser2_Temp",
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 56
                },
                {
                    "Direction": "greater than",
                    "Name": "upper non critical",
                    "Severity": 0,
                    "Value": 55
                },
                {
                    "Direction": "less than",
                    "Name": "lower non critical",
                    "Severity": 0,
                    "Value": 10
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 5
                }
            ],
            "SensorInfo": [
                {
                    "Label": "Riser2_Temp",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x19",
                    "EntityId": "0x05",
                    "EntityInstance": "9"
                }
            ],
            "Type": "EMC1412"
        }
    ],
    "Name": "riser2",
    "Probe": "xyz.openbmc_project.FruDevice({'BUS': $(($BASIC_I2C_BUS+2)), 'ADDRESS' : 80})",
    "Type": "Board",
    "xyz.openbmc_project.Inventory.Decorator.Asset": {
        "Manufacturer": "${SPECIAL_CHAR}BOARD_MANUFACTURER",
        "Model": "${SPECIAL_CHAR}BOARD_PRODUCT_NAME",
        "PartNumber": "${SPECIAL_CHAR}BOARD_PART_NUMBER",
        "SerialNumber": "${SPECIAL_CHAR}BOARD_SERIAL_NUMBER",
        "BuildDate": "${SPECIAL_CHAR}BOARD_MANUFACTURE_DATE"
    },
    "xyz.openbmc_project.Inventory.Decorator.FruDevice":{
        "Bus":$(($BASIC_I2C_BUS+2)),
        "Address":80
    },
    "xyz.openbmc_project.Inventory.Decorator.Ipmi": {
        "EntityId": "0x05",
        "EntityInstance": 1
    }
}
EOF
}


create_bp1() {
# BASIC_I2C_BUS would expect to be 36 in full device
# BP1_FRU - 24(Fixed) - 0x50
# PAC1932T_U7 - 24(Fixed) - 0x12
# EDSFF - 40~50(BASIC_I2C_BUS + 4~14) - 0x6a NvMe

cat <<EOF >$ENTITY_MANAGER_BP1_JSON
{
    "Exposes": [
        {
            "Bus": "24",
            "Address": "0x12",
            "Index": 0,
            "Name": "BP1_12V",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 13.0
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 11.0
                }
            ],
            "SensorInfo": [
                {
                    "Label": "BP1_12V",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x50",
                    "EntityId": "0x0F",
                    "EntityInstance": "0"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "24",
            "Address": "0x12",
            "Index": 1,
            "Name": "BP1_3V3",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 4.3
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 2.3
                }
            ],
            "SensorInfo": [
                {
                    "Label": "BP1_3V3",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x51",
                    "EntityId": "0x0F",
                    "EntityInstance": "1"
                }
            ],
            "Type": "ADC"
        }
    ],
    "Name": "bp1",
    "Probe": "xyz.openbmc_project.FruDevice({'BUS': 24, 'ADDRESS' : 80})",
    "Type": "Board",
    "xyz.openbmc_project.Inventory.Decorator.Asset": {
        "Manufacturer": "${SPECIAL_CHAR}BOARD_MANUFACTURER",
        "Model": "${SPECIAL_CHAR}BOARD_PRODUCT_NAME",
        "PartNumber": "${SPECIAL_CHAR}BOARD_PART_NUMBER",
        "SerialNumber": "${SPECIAL_CHAR}BOARD_SERIAL_NUMBER",
        "BuildDate": "${SPECIAL_CHAR}BOARD_MANUFACTURE_DATE"
    },
    "xyz.openbmc_project.Inventory.Decorator.FruDevice":{
        "Bus":24,
        "Address":80
    },
    "xyz.openbmc_project.Inventory.Decorator.Ipmi": {
        "EntityId": "0x0F",
        "EntityInstance": 0
    }
}
EOF
}


create_bp2() {
# BASIC_I2C_BUS would expect to be 52 in full device
# BP2_FRU - 25(Fixed) - 0x50
# PAC1932T_U7 - 25(Fixed) - 0x12
# EDSFF - 56~66(BASIC_I2C_BUS + 4~14) - 0x6a NvMe

cat <<EOF >$ENTITY_MANAGER_BP2_JSON
{
    "Exposes": [
        {
            "Bus": "25",
            "Address": "0x12",
            "Index": 0,
            "Name": "BP2_12V",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 13.0
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 11.0
                }
            ],
            "SensorInfo": [
                {
                    "Label": "BP2_12V",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x52",
                    "EntityId": "0x0F",
                    "EntityInstance": "2"
                }
            ],
            "Type": "ADC"
        },
        {
            "Bus": "25",
            "Address": "0x12",
            "Index": 1,
            "Name": "BP2_3V3",
            "PowerState": "Always",
            "ScaleFactor": 1000,
            "Thresholds": [
                {
                    "Direction": "greater than",
                    "Name": "upper critical",
                    "Severity": 1,
                    "Value": 4.3
                },
                {
                    "Direction": "less than",
                    "Name": "lower critical",
                    "Severity": 1,
                    "Value": 2.3
                }
            ],
            "SensorInfo": [
                {
                    "Label": "BP2_3V3",
                    "SensorModel": "Threshold",
                    "SensorNum": "0x53",
                    "EntityId": "0x0F",
                    "EntityInstance": "3"
                }
            ],
            "Type": "ADC"
        }
    ],
    "Name": "bp2",
    "Probe": "xyz.openbmc_project.FruDevice({'BUS': 25, 'ADDRESS' : 80})",
    "Type": "Board",
    "xyz.openbmc_project.Inventory.Decorator.Asset": {
        "Manufacturer": "${SPECIAL_CHAR}BOARD_MANUFACTURER",
        "Model": "${SPECIAL_CHAR}BOARD_PRODUCT_NAME",
        "PartNumber": "${SPECIAL_CHAR}BOARD_PART_NUMBER",
        "SerialNumber": "${SPECIAL_CHAR}BOARD_SERIAL_NUMBER",
        "BuildDate": "${SPECIAL_CHAR}BOARD_MANUFACTURE_DATE"
    },
    "xyz.openbmc_project.Inventory.Decorator.FruDevice":{
        "Bus":25,
        "Address":80
    },
    "xyz.openbmc_project.Inventory.Decorator.Ipmi": {
        "EntityId": "0x0F",
        "EntityInstance": 1
    }
}
EOF
}

create_nvme() {
echo -e \
"{\n\
        \"config\": [" > $NVME_CONFG_JSON

INDEX=0
if [ $BP1_BASIC_I2C -ne 0 ]; then
for i in $(seq 0 $(($NVME_EACH_BP-1)));
do

if [ $i -eq $(($NVME_EACH_BP-1)) ]; then
    DOT=""
else
    DOT=","
fi

if [ $BP2_BASIC_I2C -ne 0 ]; then
    DOT=","
fi

echo -e \
"\
            {\n\
                \"NVMeDriveIndex\": $INDEX,\n\
                \"NVMeDriveBusID\": $(($BP1_BASIC_I2C+$i+4))\n\
            }$DOT\
" >> $NVME_CONFG_JSON

    INDEX=$(($INDEX+1))
done
fi

INDEX=$NVME_EACH_BP
if [ $BP2_BASIC_I2C -ne 0 ]; then

for i in $(seq 0 $(($NVME_EACH_BP-1)));
do
if [ $i -eq $(($NVME_EACH_BP-1)) ]; then
    DOT=""
else
    DOT=","
fi

echo -e \
"\
            {\n\
                \"NVMeDriveIndex\": $INDEX,\n\
                \"NVMeDriveBusID\": $(($BP2_BASIC_I2C+$i+4))\n\
            }$DOT\
" >> $NVME_CONFG_JSON

    INDEX=$(($INDEX+1))
done
fi

echo -e \
"       ],\n\
        \"threshold\": [\n\
            {\n\
                \"criticalHigh\": 75,\n\
                \"criticalLow\": 0,\n\
                \"maxValue\": 127,\n\
                \"minValue\": -127\n\
            }\n\
    ]\n\
}\n" >> $NVME_CONFG_JSON

}

# Switch module
if [ $1 = "riser1" ]; then
    create_riser1
elif [ $1 = "riser2" ]; then
    create_riser2
elif [ $1 = "bp1" ]; then
    create_bp1
elif [ $1 = "bp2" ]; then
    create_bp2
elif [ $1 = "nvme" ]; then
    BP1_BASIC_I2C=$2
    BP2_BASIC_I2C=$3
    create_nvme
else
    echo "No match module"
fi


