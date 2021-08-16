FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Fix-IP-address-of-usb0-net-interface.patch \
                   file://0002-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
                   file://0003-Implement-LAN-Config-VLAN-Priority.patch \
                   file://0004-Fix-Network-Constantly-Restart-Issue.patch \
                   file://0005-Add-IPv4-IPv6-Addressing-Mode-Support.patch \
                   file://0006-Abandon-static-IP-address-when-switched-to-another-I.patch \
                   file://0007-Add-channel-config-for-usb0.patch \
"

