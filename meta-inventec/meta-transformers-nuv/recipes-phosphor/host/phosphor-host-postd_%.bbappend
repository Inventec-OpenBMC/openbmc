FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append_transformers-nuv = " file://0001-add-postcode-portled-service.patch"

inherit obmc-phosphor-systemd
PACKAGECONFIG = "7seg"
PACKAGECONFIG_remove = "7seg"

SERVICE_FILE_7SEG = "postcode-7seg.service"

DEPENDS += "libgpiod"
SYSTEMD_SERVICE_${PN} += "postcode-portled.service"
