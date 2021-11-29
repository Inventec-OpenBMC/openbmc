SUMMARY = "starscream init service"
DESCRIPTION = "Essential init commands for starscream"
PR = "r1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit obmc-phosphor-systemd

DEPENDS += "systemd"
RDEPENDS_${PN} += "libsystemd"


FILESEXTRAPATHS_prepend := "${THISDIR}/starscream-init:"
SRC_URI += "file://starscream-init.sh \
            file://create_json.sh \
"

S = "${WORKDIR}"

do_install() {
        install -d ${D}${sbindir}
        install -m 0755 starscream-init.sh ${D}${sbindir}
        install -m 0755 create_json.sh ${D}${sbindir}
}

SYSTEMD_SERVICE_${PN} += "starscream-init.service"
