FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRC_URI_append = " file://0001-inventec-transformers-Set-power-button-and-post-comp.patch \
                   file://power-config-host0.json \
                   file://host-power-off.service \
                   file://host-power-on.service \
                   file://host-power-off.sh \
                   file://host-power-on.sh \
                 "

do_install_append() {
    install -m 0644 ${WORKDIR}/power-config-host0.json ${D}/usr/share/x86-power-control
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/host-power-off.sh ${D}${sbindir}
    install -m 0755 ${WORKDIR}/host-power-on.sh ${D}${sbindir}
}
