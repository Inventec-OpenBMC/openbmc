FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

KERNEL_FEATURES_remove += " phosphor-gpio-keys \
                            phosphor-vlan \
                          "

SRC_URI_append = " file://starscream.cfg \
                   file://arch \
                   file://drivers \
                   file://0001-peci-Add-support-for-PECI-bus-driver-core.patch \
                   file://0002-peci-Add-Aspeed-PECI-adapter-driver.patch \
                   file://0003-peci-npcm-add-NPCM-PECI-driver.patch \
                   file://0004-peci-fix-error-handling-in-peci_dev_ioctl.patch \
                   file://0005-hwmon-Add-PECI-dimmtemp-driver.patch \
                   file://0006-mfd-intel-peci-client-Add-Intel-PECI-client-driver.patch \
                   file://0007-hwmon-Add-PECI-cputemp-driver.patch \
                   file://0008-peci-cputemp-label-CPU-cores-from-zero-instead-of-on.patch \
                   file://0009-peci-Sync-peci-verion-with-Intel-BMC-linux.patch \
                   file://0010-Implement-a-memory-driver-share-memory.patch \
                   file://0011-Subject-Patch-Replace-some-aspeed-drivers-with-the-n.patch \
                   file://0012-Subject-Patch-kernel-Add-aspeed-JTAG-support.patch \
                   file://0013-Subject-Patch-kernel-Fix-MTD-partitions-were-deleted.patch \
                   file://0014-Add-flash-layout-64MB.patch \
                   file://0015-aspeed-espi-slave-feature-support.patch \
                   file://0016-Add-some-ast2600-drivers.patch \
                   file://0017-Subject-Patch-kernel-Yield-ball-pin-H24-for-using-GP.patch \
                   file://0018-Correct-phy-led-with-speed-1Gbps-100Mbps-10Mbps.patch \
                   file://0019-Subject-PATCH-Kernel-GPIO-Add-1.8V-GPIO-pin-definiti.patch \
                   file://0020-Subject-PATCH-Revise-ADT7462-driver-in-kernel.patch \
                   file://0021-Subject-PATCH-Kernel-dts-driver-Patched-hsc-setting-.patch \
                   file://0022-Subject-Patch-kernel-driver-Set-max31790-default-ena.patch \
                   file://0023-Subject-Patch-kernel-RTC-Set-a-default-timestamp-for.patch \
                   file://0024-Subject-Patch-kernel-pmbus-Add-a-DTS-node-of-pmbus-t.patch \
                   file://0025-Subject-Patch-Support-I3C-driver.patch \
                   file://0026-Add-tmp468-driver.patch \
                   file://0027-intel-asd-1.4.4-jtag-driver-support.patch \
                   file://0028-Add-virtual-driver-to-simulate-driver-behavier.patch \
                   file://0029-KCS3-can-t-be-created-because-kcs-binding-method-is-.patch \
                   file://0030-Sync-sgpio-driver-with-aspeed-linux.patch \
                   file://0031-Add-Aspeed-VHUB-dirver-support-on-Transformers.patch \
                   file://0032-force-spi-to-run-at-single-mode.patch \
                   file://0033-Starscream-Modify-RGMII-TX-driving-strength.patch \
                   file://0034-Fix-bug-virtural-UART-device-node-cannot-be-created.patch \
                   file://0035-HWMON-driver-for-SMSC-EMC2301-2302-2303-2305-chips.patch \
                   file://0036-Add-Microchip-pac1934-2-1-chip-family-ADC-driver.patch \
                 "

do_add_overwrite_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
    cp -r "${WORKDIR}/drivers" \
          "${STAGING_KERNEL_DIR}"
}

addtask do_add_overwrite_files after do_patch before do_compile
