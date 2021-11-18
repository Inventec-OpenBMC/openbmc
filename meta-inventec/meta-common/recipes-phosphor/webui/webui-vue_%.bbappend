FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Fix-Fan-and-Powersupply-path.patch \
                   file://0002-Bug-465-error-enabling-DHCP-conf.patch \
"

