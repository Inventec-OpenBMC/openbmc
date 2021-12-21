#!/bin/sh

plug_type=$1
DELAY=2 #unit sec

tsod_drv_op() {

    op=$1
    ADDR_MIN=16
    ADDR_MAX=21
    BUS_MIN=0
    BUS_MAX=3
    
    bus=$BUS_MIN

    while [ $bus -le $BUS_MAX ]; do
        addr=$ADDR_MIN
        while [ $addr -le  $ADDR_MAX ]; do

            if [ "$op" = "new" ]
            then
                echo tsod $addr > /sys/bus/i2c/devices/i2c-$bus/new_device
            else
                echo $addr > /sys/bus/i2c/devices/i2c-$bus/delete_device
            fi
            let addr=addr+1
        done
        let bus=bus+1
    done

}
if [ "$plug_type" = "insert" ]; then
    echo "dimm insert action"

    echo "set i3c mux to bmc"
    gpioset `gpiofind I3C_MUX_SELECT`=1
    sleep $DELAY
    tsod_drv_op "new"

    systemctl restart xyz.openbmc_project.tsodsensor.service
elif [ "$plug_type" = "remove" ]; then
    echo "dimm remove action"
    systemctl stop xyz.openbmc_project.tsodsensor.service
    sleep $DELAY
    tsod_drv_op "delete"
        
    echo "set i3c mux to cpu"
    gpioset `gpiofind I3C_MUX_SELECT`=0

elif [ "$plug_type" = "init" ]; then

    echo "dimm init action"
    echo "set i3c mux to bmc"
    gpioset `gpiofind I3C_MUX_SELECT`=1
    sleep $DELAY
    tsod_drv_op "new"
else
    echo "unknow type"
    exit 1;
fi

exit 0;


