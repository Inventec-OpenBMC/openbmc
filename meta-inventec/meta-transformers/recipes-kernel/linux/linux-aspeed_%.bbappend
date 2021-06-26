FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

KERNEL_FEATURES_remove += " phosphor-gpio-keys \
                            phosphor-vlan \
                          "

SRC_URI_append = " file://transformers.cfg \
                   file://arch \
                   file://drivers \
                   file://0001-Subject-Patch-Replace-some-aspeed-drivers-with-the-n.patch \
                   file://0002-Subject-Patch-kernel-Add-aspeed-JTAG-support.patch \
                   file://0003-Subject-Patch-kernel-intel-peci-client-support-Icela.patch \
                   file://0004-Subject-Patch-kernel-Fix-MTD-partitions-were-deleted.patch \
                   file://0005-Add-flash-layout-64MB.patch \
                   file://0006-aspeed-espi-slave-feature-support.patch \
                   file://0007-Add-some-ast2600-drivers.patch \
                   file://0008-Subject-Patch-kernel-Yield-ball-pin-H24-for-using-GP.patch \
                   file://0009-Correct-phy-led-with-speed-1Gbps-100Mbps-10Mbps.patch \
                   file://0010-Subject-PATCH-Kernel-GPIO-Add-1.8V-GPIO-pin-definiti.patch \
                   file://0011-Subject-PATCH-Revise-ADT7462-driver-in-kernel.patch \
                   file://0012-Subject-PATCH-Kernel-dts-driver-Patched-hsc-setting-.patch \
                   file://0013-Subject-Patch-kernel-driver-Set-max31790-default-ena.patch \
                   file://0014-Subject-Patch-kernel-RTC-Set-a-default-timestamp-for.patch \
                   file://0015-Subject-Patch-kernel-pmbus-Add-a-DTS-node-of-pmbus-t.patch \
                   file://0016-Subject-Patch-Support-I3C-driver.patch \
                   file://0017-Add-tmp468-driver.patch \
                   file://0018-intel-asd-1.4.4-jtag-driver-support.patch \
                   file://0019-Add-virtual-driver-to-simulate-driver-behavier.patch \
                   file://0020-KCS3-can-t-be-created-because-kcs-binding-method-is-.patch \
                   file://0021-Sync-sgpio-driver-with-aspeed-linux.patch \
                   file://0022-Add-Aspeed-VHUB-dirver-support-on-Transformers.patch \
                   file://0023-force-spi-to-run-at-single-mode.patch \
                   file://0024-Modify-RGMII-TX-Clock-delay-and-TX-driving-strength.patch \
                   file://0025-Fix-bug-virtural-UART-device-node-cannot-be-created.patch \
                 "

do_add_overwrite_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
    cp -r "${WORKDIR}/drivers" \
          "${STAGING_KERNEL_DIR}"
}

addtask do_add_overwrite_files after do_patch before do_compile
