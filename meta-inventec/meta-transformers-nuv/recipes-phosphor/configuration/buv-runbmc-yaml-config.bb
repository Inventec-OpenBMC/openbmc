SUMMARY = "YAML configuration for Olympus Nuvoton"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch

SRC_URI_transformers-nuv = " \
    file://buv-runbmc-ipmi-fru.yaml \
    file://buv-runbmc-ipmi-fru-properties.yaml \
    "

S = "${WORKDIR}"

do_install_transformers-nuv() {
    install -m 0644 -D buv-runbmc-ipmi-fru-properties.yaml \
        ${D}${datadir}/${BPN}/ipmi-extra-properties.yaml
    install -m 0644 -D buv-runbmc-ipmi-fru.yaml \
        ${D}${datadir}/${BPN}/ipmi-fru-read.yaml
}

FILES_${PN}-dev = " \
    ${datadir}/${BPN}/ipmi-extra-properties.yaml \
    ${datadir}/${BPN}/ipmi-fru-read.yaml \
    "

ALLOW_EMPTY_${PN} = "1"
