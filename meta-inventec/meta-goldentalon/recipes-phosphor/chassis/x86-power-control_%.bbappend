FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRC_URI += "file://power-config-host0.json"

do_install_append() {
    install -m 0644 ${WORKDIR}/power-config-host0.json ${D}/usr/share/x86-power-control
}


