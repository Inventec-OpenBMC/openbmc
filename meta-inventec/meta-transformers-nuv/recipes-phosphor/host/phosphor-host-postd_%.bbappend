FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append_transformers-nuv = " file://0001-add-postcode-portled-service.patch"

inherit obmc-phosphor-systemd
PACKAGECONFIG_remove = "7seg"

DEPENDS += "libgpiod"
SYSTEMD_SERVICE_${PN} += "postcode-portled.service"
