FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://dev_id.json \
            file://channel_config.json \
           "

FILES_${PN} += " \
                ${datadir}/ipmi-providers/dev_id.json \
                ${datadir}/ipmi-providers/channel_config.json \
               "

do_install_append() {
    install -m 0644 -D ${WORKDIR}/dev_id.json \
        ${D}/usr/share/ipmi-providers/dev_id.json
    install -m 0644 -D ${WORKDIR}/channel_config.json \
        ${D}/usr/share/ipmi-providers/channel_config.json
}
