SUMMARY = "BMC ready"
DESCRIPTION = "BMC ready for OpenBMC"
PR = "r1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit obmc-phosphor-systemd

DEPENDS += "systemd"
RDEPENDS_${PN} += "libsystemd"

FILESEXTRAPATHS_prepend := "${THISDIR}/bmc-ready:"
SRC_URI += "file://bmc-ready.sh"

S = "${WORKDIR}"
HASHSTYLE = "gnu"

do_install() {
        install -d ${D}${sbindir}
        install -m 0755 bmc-ready.sh ${D}${sbindir}
}

SYSTEMD_SERVICE_${PN} += "bmc-ready.service"
