FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI_append = " file://goldentalon-ast2600.cfg \
                   file://0001-Initial-goldentalon-u-boot-dts.patch \
                   file://0002-Subject-Apply-patch-from-original-develop-folder-and.patch \
                   file://0003-Revise-spi-frequency-in-uboot.patch \
                   file://0004-GPIO-WDT-default-setting-and-add-MAX31790-driver-in-.patch \
                   file://0005-Subject-PATCH-Uboot-Patch-diable-hardware-heartbeat-.patch \
                 "
