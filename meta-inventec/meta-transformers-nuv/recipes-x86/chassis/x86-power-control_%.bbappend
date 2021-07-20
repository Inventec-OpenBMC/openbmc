FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append_transformers-nuv = " file://power-config-host0.json"

FILES_${PN} += " ${datadir}/x86-power-control/power-config-host0.json \"

do_install_append_transformers-nuv() {
    install -d ${D}${datadir}/x86-power-control
    install -m 0644 -D ${WORKDIR}/power-config-host0.json \
        ${D}${datadir}/x86-power-control/power-config-host0.json
}
