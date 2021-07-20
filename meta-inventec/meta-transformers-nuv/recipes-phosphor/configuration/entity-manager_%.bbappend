FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append_transformers-nuv = " file://F0B_BMC_BMC.json"

FILES_${PN}_append_transformers-nuv = " \
    ${datadir}/entity-manager/F0B_BMC_BMC.json"

do_install_append_transformers-nuv() {
    install -d ${D}${datadir}/entity-manager
    install -m 0644 -D ${WORKDIR}/F0B_BMC_BMC.json \
        ${D}${datadir}/entity-manager/configurations/F0B_BMC_BMC.json
}
