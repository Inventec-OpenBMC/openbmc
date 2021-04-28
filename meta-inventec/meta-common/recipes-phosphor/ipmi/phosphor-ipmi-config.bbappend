FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://lan_config.json \
           "

FILES_${PN} += " \
                ${datadir}/ipmi-providers/lan_config.json \
               "

do_install_append() {
    install -m 0644 -D ${WORKDIR}/lan_config.json \
        ${D}/usr/share/ipmi-providers/lan_config.json
}
