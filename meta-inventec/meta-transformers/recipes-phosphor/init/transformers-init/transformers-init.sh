#!/bin/sh

# Init GPIO setting

gpioset `gpiofind BMC_READY`=0
echo BMC ready !!
gpioset `gpiofind RST_BMC_SGPIO`=1
echo Release reset SGPIO !!
gpioset `gpiofind RESET_OUT`=1
echo bmc notify cpld to reset system, set high !!
gpioset `gpiofind POWER_OUT`=1
echo bmc notify cpld to power on system, set high !!
