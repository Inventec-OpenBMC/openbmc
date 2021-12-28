#!/bin/sh

# Init GPIO setting
# gpio init
gpioset `gpiofind CPLD_PWRBRK_N`=1
gpioset `gpiofind ASSERT_CPU0_PROCHOT_R_N`=1
gpioset `gpiofind ASSERT_CPU1_PROCHOT_R_N`=1
gpioset `gpiofind BIOS_RECOVERY_BUF_N`=1
gpioset `gpiofind IRQ_BMC_CPU0_BUF_NMI_N`=1
gpioset `gpiofind NCSI_OCP_CLK_EN_N`=0
gpioset `gpiofind SCM_JTAG_MUX_SE`=0


# sgpio init
gpioset `gpiofind RST_BMC_CPU0_I2C_N`=1
gpioset `gpiofind RST_BMC_CPU1_I2C_N`=1
gpioset `gpiofind I2C_BUS7_RESET_N`=1
gpioset `gpiofind BMC_USB2514_1_RESET_N`=1
gpioset `gpiofind BMC_CPU0_UART_EN`=0
gpioset `gpiofind HDT_BUF_EN_N`=0
gpioset `gpiofind BMC_ASSERT_CLR_CMOS`=0
gpioset `gpiofind HDT_MUX_SELECT_MON`=0
gpioset `gpiofind CPLD_JTAG_OE_R_N`=1
gpioset `gpiofind CPLD_HDT_RESET_N`=1
gpioset `gpiofind SPI_MUX_SELECT`=0

#if bmc reboot while mb power stays on , following conditions need to be checked
bios_post_complete=$(gpioget `gpiofind FM_BIOS_POST_CMPLT_BUF_N`)
if [ "$bios_post_complete" = "0" ]; then
    echo "bios post comeplete is low"
    systemctl start dimm-plug@init.service
else
    echo "bios post comeplete is high, set mux to cpu"
    gpioset `gpiofind I3C_MUX_SELECT`=0
fi

psu1_present=$(gpioget `gpiofind PSU0_CPLD_PRESENT_N`)
if [ "$psu1_present" = "0" ]; then
    echo "PSU1 pluged"
    systemctl start inv-psu-update@11plug.service
else
    echo "PSU1 unpluged"
    systemctl start inv-psu-update@11unplug.service
fi

psu2_present=$(gpioget `gpiofind PSU1_CPLD_PRESENT_N`)
if [ "$psu2_present" = "0" ]; then
    echo "PSU2 pluged"
    systemctl start inv-psu-update@12plug.service
else
    echo "PSU2 unpluged"
    systemctl start inv-psu-update@12unplug.service
fi

