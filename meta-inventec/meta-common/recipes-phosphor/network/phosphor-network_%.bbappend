FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Fix-IP-address-of-usb0-net-interface.patch \
                   file://0002-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
"

