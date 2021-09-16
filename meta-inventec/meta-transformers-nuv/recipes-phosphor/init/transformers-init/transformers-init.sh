#!/bin/sh

# Init GPIO setting

gpioset `gpiofind BMC_READY`=0
echo BMC ready !!
gpioset `gpiofind RST_BMC_SGPIO`=1
echo Release reset SGPIO !!
echo c0000000.spi > /sys/bus/platform/drivers/NPCM-FIU/unbind
