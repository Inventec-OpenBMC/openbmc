FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DISTRO_FEATURES += "ipmi-fru"

SRC_URI += "file://blacklist.json"
SRC_URI += "file://motherboard.json"
SRC_URI += "file://runbmc.json"
SRC_URI += "file://scmbridge.json"

do_install_append() {
    install -d 0755 ${D}/usr/share/entity-manager/configurations
    rm  -rf ${D}/usr/share/entity-manager/configurations/*.json
    install -m 0644 ${WORKDIR}/blacklist.json ${D}/usr/share/entity-manager/blacklist.json
    install -m 0644 ${WORKDIR}/motherboard.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/runbmc.json ${D}/usr/share/entity-manager/configurations
    install -m 0644 ${WORKDIR}/scmbridge.json ${D}/usr/share/entity-manager/configurations
}
