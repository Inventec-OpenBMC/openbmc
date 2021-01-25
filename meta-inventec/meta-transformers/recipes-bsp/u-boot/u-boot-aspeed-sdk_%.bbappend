FILESEXTRAPATHS_append := "${THISDIR}/${BPN}:"


SRC_URI_append = " file://transformers-ast2600.cfg \
                   file://transformers-ast2600_defconfig \
                   file://ast2600-transformers.dts \
                   file://0001-Modify-bootfile-name-and-env-offset.patch \
                   file://0002-Add-debug-mesg-to-show-SPI-cloc.patch \
                   file://0003-Read-MAC0-address-from-EEPROM.patch \
                   file://0004-Support-max31790-device-driver.patch \
                   file://0005-Initial-transformers-machine.patch \
                 "

do_copyfile () {
    if [ -e ${WORKDIR}/ast2600-transformers.dts ] ; then
        cp -v ${WORKDIR}/ast2600-transformers.dts ${S}/arch/arm/dts/
    else
        # if use devtool modify, then the append files were stored under oe-local-files
        cp -v ${S}/oe-local-files/ast2600-transformers.dts ${S}/arch/arm/dts/
    fi

    if [ -e ${WORKDIR}/transformers-ast2600_defconfig  ] ; then
        cp -v ${WORKDIR}/transformers-ast2600_defconfig  ${S}/configs/
    else
        cp -v ${S}/oe-local-files/transformers-ast2600_defconfig ${S}/configs/
    fi
}

addtask copyfile after do_patch before do_configure

include conf/machine/platform_configs.inc

EEPROM_MAC_I2C_BUS ?= "14"
EEPROM_MAC_I2C_ADDRESS ?= "0x50"
EEPROM_MAC_OFFSET ?= "0x1000"
EEPROM_MAC_I2C_DEV_SPEED ?= "100000"
EEPROM_MAC_I2C_ADDR_LEN ?= "2"

do_patch_headerfile () {
  cat >${S}/include/configs/IECplatformConfigs.h <<EOF
// This header file is automatically created, DO NOT EDIT IT.
#ifndef __IEC_PLATFORM_CONFIGS_H__
#define __IEC_PLATFORM_CONFIGS_H__

#define EEPROM_MAC_I2C_BUS (${EEPROM_MAC_I2C_BUS})
#define EEPROM_MAC_I2C_ADDRESS (${EEPROM_MAC_I2C_ADDRESS})
#define EEPROM_MAC_OFFSET (${EEPROM_MAC_OFFSET})
#define EEPROM_MAC_I2C_DEV_SPEED (${EEPROM_MAC_I2C_DEV_SPEED})
#define EEPROM_MAC_I2C_ADDR_LEN (${EEPROM_MAC_I2C_ADDR_LEN})

#endif /* __IEC_PLATFORM_CONFIGS_H__ */
EOF
}

addtask patch_headerfile after do_patch before do_configure
