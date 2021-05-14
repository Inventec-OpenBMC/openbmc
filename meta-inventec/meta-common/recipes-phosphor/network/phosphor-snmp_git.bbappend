FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

DEPENDS_append = " \
    nlohmann-json \
  "

SRC_URI += " file://0001-Implement-LAN-Config-Community-String.patch \
             file://0002-Implement-LAN-Config-Destination-Addresses.patch \
"
