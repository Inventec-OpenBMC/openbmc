FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

KERNEL_FEATURES_remove += " phosphor-gpio-keys \
                            phosphor-vlan \
                          "

SRC_URI_append = " file://transformers.cfg \
                   file://arch \
                   file://drivers \
                   file://0001-Replace-aspeed-g6-dtsi-and-g6-pinctrl-dtsi.patch \
                   file://0002-Replace-clk-ast2600.patch \
                   file://0003-Add-aspeed-JTAG-support.patch \
                   file://0004-Add-Icelake-into-intel-peci-client-support-list.patch \
                   file://0005-Fix-MTD-partitions-were-deleted-due-to-another-flash-not-found.patch \
                   file://0006-Add-flash-layout-64MB.patch \
                   file://0007-Add-espi-slave-in-dtsi-setting.patch \
                   file://0008-Add-espi-slave-driver.patch \
                   file://0009-Add-ast2600-adc-hwmon-driver.patch \
                   file://0010-Add-ast2600-pwm-driver.patch \
                   file://0011-Add-spi-master-driver.patch \
                   file://0012-Yield-ball-pin-H24-for-using-GPIO_C0.patch \
                   file://0013-Correct-phy-led-with-speed-1Gbps-100Mbps-10Mbps.patch \
                   file://0014-Support-Intel-icelake-CPU-PECI-to-get-DIMM-temperatu.patch \
                   file://0015-Add-1.8V-GPIO-pin-definition.patch \
                   file://0016-Revise-ADT7462-driver-in-kernel.patch \
                   file://0017-Kernel-dts-driver-Patched-hsc-setting-on-dts-and-Pmb.patch \
                   file://0018-Corrected-adm1278-default-parameter-vi_avg-setting.patch \
                   file://0019-Set-max31790-default-enable-pwm.patch \
                   file://0020-Enables-the-voltage-measurement-input-for-Pin-19.patch \
                   file://0021-Patch-kernel-RTC-Set-a-default-timestamp.patch \
                   file://0022-Patch-hwmon-pmbus-Add-a-DTS-node-of-fanConfig.patch \
                   file://0023-Support-I3C-driver.patch \
                   file://0024-inventec-transformers-enable-peci-interface-get-cpu.patch \
                   file://0025-inventec-transformers-Add-tmp468-driver.patch \
                   file://0026-inventec-transformers-intel-asd-1.4.4-jtag-driver.patch \
                   file://0027-inventec-transformers-Add-virtual-driver-to-simulate.patch \
                   file://0028-inventec-transformers-KCS3-can-t-be-created-because.patch \
                   file://0029-inventec-transformers-Sync-sgpio-driver-with-aspeed-.patch \
                   file://0030-Add-Aspeed-VHUB-dirver-support-on-Transformers.patch \
                   file://0031-inventec-transformers-force-spi-to-run-at-single-mode.patch \
		   file://0032-inventec-transformers-Modify-RGMII-TX-Clock-delay-an.patch \
                   file://0033-Fix-bug-virtural-UART-device-node-cannot-be-created.patch \
                 "

do_add_overwrite_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
    cp -r "${WORKDIR}/drivers" \
          "${STAGING_KERNEL_DIR}"
}

addtask do_add_overwrite_files after do_patch before do_compile
