SUMMARY = "Inventec PSU update service"
DESCRIPTION = "Post inventory data to dbus interface"
PR = "r1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit obmc-phosphor-systemd

DEPENDS += "systemd"
RDEPENDS_${PN} += "libsystemd"


FILESEXTRAPATHS_prepend := "${THISDIR}/inv-psu-update:"
SRC_URI += "file://inv-psu-plug.sh"
SRC_URI += "file://inv-psu-unplug.sh"

S = "${WORKDIR}"

do_install() {
        install -d ${D}${sbindir}
        install -m 0755 inv-psu-plug.sh ${D}${sbindir}
        install -m 0755 inv-psu-unplug.sh ${D}${sbindir}
}

SYSTEMD_SERVICE_${PN} += "inv-psu-plug@.service"
SYSTEMD_SERVICE_${PN} += "inv-psu-plug@1.service"
SYSTEMD_SERVICE_${PN} += "inv-psu-plug@2.service"
SYSTEMD_SERVICE_${PN} += "inv-psu-unplug@.service"
SYSTEMD_SERVICE_${PN} += "inv-psu-unplug@1.service"
SYSTEMD_SERVICE_${PN} += "inv-psu-unplug@2.service"
