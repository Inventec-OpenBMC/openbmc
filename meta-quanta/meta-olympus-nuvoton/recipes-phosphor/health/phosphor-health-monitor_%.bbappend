FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://bmc_health_config.json"

do_install_append_olympus-nuvoton() {
    install -m 0644 -D ${WORKDIR}/bmc_health_config.json \
        ${D}${sysconfdir}/healthMon/bmc_health_config.json
}
