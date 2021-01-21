FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://whitelist"

do_install_append() {
    install -m 0644 whitelist ${D}/whitelist
}
