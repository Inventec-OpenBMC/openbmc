FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DISTRO_FEATURES += "ipmi-fru"


SRC_URI_append =  " file://blacklist.json \
                    file://motherboard.json \
                    file://runbmc.json \
                    file://scmbridge.json \
                    file://ocp_addr_80.json \
                    file://ocp_addr_81.json \
                  "

do_install_append() {
    install -d 0755 ${D}/usr/share/entity-manager/configurations
    rm  -rf ${D}/usr/share/entity-manager/configurations/*.json
    install -m 0644 ${WORKDIR}/blacklist.json ${D}/usr/share/entity-manager/blacklist.json
    install -m 0644 ${WORKDIR}/motherboard.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/runbmc.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/scmbridge.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/ocp_addr_80.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/ocp_addr_81.json ${D}/usr/share/entity-manager/configurations
}

