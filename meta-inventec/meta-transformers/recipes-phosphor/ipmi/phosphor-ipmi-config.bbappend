FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
            file://dev_id.json \
           "

FILES_${PN} += " \
                ${datadir}/ipmi-providers/dev_id.json \
               "

do_install_append() {
    install -m 0644 -D ${WORKDIR}/dev_id.json \
        ${D}/usr/share/ipmi-providers/dev_id.json
}
