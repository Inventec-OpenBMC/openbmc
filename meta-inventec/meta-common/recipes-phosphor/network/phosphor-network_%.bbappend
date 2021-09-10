FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Add-hook-to-mACAddress-to-call-mac_util.patch \
                   file://0002-Fix-IP-address-of-usb0-net-interface.patch \
                   file://0003-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
                   file://0004-Implement-LAN-Config-VLAN-Priority.patch \
                   file://0005-Fix-Network-Constantly-Restart-Issue.patch \
                   file://0006-Add-IPv4-IPv6-Addressing-Mode-Support.patch \
                   file://0007-Abandon-static-IP-address-when-switched-to-another-I.patch \
                   file://0008-Add-channel-config-for-usb0.patch \
                   file://0009-Bug-412-lanpus-can-not-work-with-vlan.patch \
                   file://0010-Implement-ChannelAccess-d-bus-interface.patch \
"

