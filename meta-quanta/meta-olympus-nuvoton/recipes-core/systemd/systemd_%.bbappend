FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0001-networkd-create-new-socket.patch \
    file://0001-network-Fix-crash-while-dhcp4-address-gets-update.patch \
"
