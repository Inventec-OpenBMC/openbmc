SUMMARY = "Transformers inventory map for phosphor-ipmi-host"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit native
inherit phosphor-ipmi-host

PROVIDES += "virtual/phosphor-ipmi-fru-read-inventory"

SRC_URI += "file://config.yaml"

S = "${WORKDIR}"

do_install() {
        DEST=${D}${config_datadir}
        install -d ${DEST}
        install config.yaml ${DEST}/config.yaml
}
