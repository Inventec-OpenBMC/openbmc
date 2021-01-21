FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI_append = "  
                    file://0001-Initial-goldentalon-dts.patch \
                    file://0002-Correct-phy-led-with-speed-1Gbps-100Mbps-10Mbps.patch \
                    file://0003-Enable-kcs1-io-address.patch \
                    file://0004-Subject-Disable-mac3-in-kernel-to-avoid-kernel-excep.patch \
                    file://0005-Support-Intel-icelake-CPU-PECI-to-get-DIMM-temperatu.patch \
                    file://0006-Revise-kernel-spi-frequency-approximate-to-33MHz.patch \
                    file://0007-Add-PSU-pmbus-defne-on-goldentalon-dts.patch \
                    file://0008-Add-GPIO-Led-define-on-Goldentalon-dts.patch \
                    file://0009-Subject-Add-lpc-snoop-driver-in-kernel-dts.patch \
                    file://0010-Revise-ADT7462-driver-in-kernel.patch \
                    file://0011-Patched-hsc-setting-on-dts-and-Pmbus-HSC-driver.patch \
                    file://0012-Corrected-adm1278-default-parameter-vi_avg-setting.patch \
                    file://0013-Subject-Patch-kernel-driver-Set-max31790-default-ena.patch \
                    file://0014-Enables-the-voltage-measurement-input-for-Pin-19.patch \
                    file://0015-Subject-Patch-kernel-RTC-Set-a-default-timestamp-for.patch \
                    file://0016-Subject-Patch-kernel-pmbus-Add-a-DTS-node-of-pmbus-t.patch \
                    file://0017-Add-Intel-ASD-JTAG-driver.patch \
                    file://0018-Move-goldentalon-dts-to-the-openbmc-folder.patch \
                    file://0019-Add-virtual-driver-to-simulate-driver-behavier.patch \
                    file://0020-Add-p2a-ctrl-driver-for-in-band-update.patch \
                    file://0021-Enhance-p2a-ctrl-driver-security.patch \
                 "

SRC_URI_append = " file://goldentalon.cfg \
                   file://arch \
                   file://drivers \
                 "

do_add_overwrite_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
    cp -r "${WORKDIR}/drivers" \
          "${STAGING_KERNEL_DIR}"
}

addtask do_add_overwrite_files after do_patch before do_compile



