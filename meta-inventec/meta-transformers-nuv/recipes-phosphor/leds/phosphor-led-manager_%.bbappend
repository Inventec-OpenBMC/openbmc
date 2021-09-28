
# Overwrite the service configuration "bmc_booted.conf"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " file://bmc_booted.conf"

do_compile_prepend_transformers-nuv() {
    install -m 0644 ${STAGING_DATADIR_NATIVE}/${PN}/led.yaml ${S}
}
