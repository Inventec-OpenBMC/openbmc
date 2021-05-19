FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Add-RequestedPowerIntervalMs-property.patch \
            file://0002-inventec-common-Read-intervals-from-config-file.patch \
           "

