FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_buv-runbmc = " \
  file://arch \
  file://buv-runbmc.cfg \
  file://0002-move-emc-debug-message-to-dev_dbg.patch \
  file://0006-driver-SPI-add-w25q01jv-support.patch \
  file://0007-Ampere-Altra-MAX-SSIF-IPMI-driver.patch \
  file://0008-driver-misc-seven-segment-display-gpio-driver.patch \
  "

# Merge source tree by original project with our layer of additional files
do_add_vesnin_files () {
    cp -r "${WORKDIR}/arch" \
          "${STAGING_KERNEL_DIR}"
}
addtask do_add_vesnin_files after do_kernel_checkout before do_patch
