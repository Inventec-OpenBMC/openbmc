FILESEXTRAPATHS_prepend_evb-npcm845 := "${THISDIR}/${PN}:"

SRC_URI_append_evb-npcm845 = " \
    file://fan-default-speed.sh \
    file://config-evb-npcm845.json \
    file://fan-reboot-control.service \
    file://fan-boot-control.service \
    file://phosphor-pid-control.service \
    "

FILES_${PN}_append_evb-npcm845 = " ${bindir}/fan-default-speed.sh"
FILES_${PN}_append_evb-npcm845 = " ${datadir}/swampd/config.json"

RDEPENDS_${PN} += "bash"

SYSTEMD_SERVICE_${PN}_append_evb-npcm845 = " fan-reboot-control.service"
SYSTEMD_SERVICE_${PN}_append_evb-npcm845 = " fan-boot-control.service"
# default recipe already include phosphor-pid-control.service

do_install_append_evb-npcm845() {
    install -d ${D}/${bindir}
    install -m 0755 ${WORKDIR}/fan-default-speed.sh ${D}/${bindir}

    install -d ${D}${datadir}/swampd
    install -m 0644 -D ${WORKDIR}/config-evb-npcm845.json \
        ${D}${datadir}/swampd/config.json

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-pid-control.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fan-reboot-control.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fan-boot-control.service \
        ${D}${systemd_unitdir}/system
}

