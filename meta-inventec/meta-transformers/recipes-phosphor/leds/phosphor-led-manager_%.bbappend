
# Overwrite the service configuration "bmc_booted.conf"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " file://bmc_booted.conf"
