FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://lan_config.json \
            file://sys_info.json \
            file://warm_reset.json \
           "

FILES_${PN} += " \
                ${datadir}/ipmi-providers/lan_config.json \
                ${datadir}/ipmi-providers/sys_info.json \
                ${datadir}/ipmi-providers/warm_reset.json \
               "

do_install_append() {
    install -m 0644 -D ${WORKDIR}/lan_config.json \
        ${D}/usr/share/ipmi-providers/lan_config.json
    install -m 0644 -D ${WORKDIR}/sys_info.json \
        ${D}/usr/share/ipmi-providers/sys_info.json
    install -m 0644 -D ${WORKDIR}/warm_reset.json \
        ${D}/usr/share/ipmi-providers/warm_reset.json
}
