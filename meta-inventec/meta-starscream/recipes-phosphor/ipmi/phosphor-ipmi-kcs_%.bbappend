FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KCS_DEVICE_2 ?= "ipmi-kcs2"

SYSTEMD_SERVICE_${PN} += " ${PN}@${KCS_DEVICE_2}.service "

