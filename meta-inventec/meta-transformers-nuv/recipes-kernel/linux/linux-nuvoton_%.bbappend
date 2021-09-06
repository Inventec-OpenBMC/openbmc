FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_transformers-nuv = " \
  file://arch \
  file://drivers \
  file://buv-runbmc.cfg \
  file://0002-move-emc-debug-message-to-dev_dbg.patch \
  file://0006-driver-SPI-add-w25q01jv-support.patch \
  file://0007-Ampere-Altra-MAX-SSIF-IPMI-driver.patch \
  file://0008-driver-misc-seven-segment-display-gpio-driver.patch \
  file://0009-virtual-Add-virtual-driver-config.patch \
  file://0010-inventec-transformers-nuv-Modify-TOCK-to-PLL0-for-RGMII-issue.patch \
  file://0011-peci-Sync-peci-verion-with-Intel-BMC-linux-and-Eagle.patch \
  "

# Merge source tree by original project with our layer of additional files
do_add_vesnin_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
    cp -r "${WORKDIR}/drivers" \
          "${STAGING_KERNEL_DIR}"
}
addtask do_add_vesnin_files after do_patch before do_compile
