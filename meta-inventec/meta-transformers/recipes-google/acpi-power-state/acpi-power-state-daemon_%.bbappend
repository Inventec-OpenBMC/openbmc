FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://transformers-host-s0-set-failsafe.service \
    file://transformers-host-s5-set-failsafe.service \
    file://transformers-host-set-boot-failsafe@.service \
    file://transformers-check-host-state.service \
    file://transformers-set-boot-failsafe.sh \
    file://transformers-set-failsafe.sh \
    file://transformers-check-host-state.sh \
    file://transformers-host-ready.target \
    "

RDEPENDS_${PN}_append = "bash"

CHASSIS_INSTANCE="0"

SYSTEMD_SERVICE_${PN}_append = " \
    transformers-host-s0-set-failsafe.service \
    transformers-host-s5-set-failsafe.service \
    transformers-host-set-boot-failsafe@${CHASSIS_INSTANCE}.service \
    transformers-check-host-state.service \
    transformers-host-ready.target \
    "

FILES_${PN}_append = " \
    ${systemd_system_unitdir}/transformers-host-set-boot-failsafe@.service \
    "

do_install_append() {
    install -d ${D}${bindir}

    install -m 0755 ${WORKDIR}/transformers-set-failsafe.sh ${D}${bindir}/.
    install -m 0755 ${WORKDIR}/transformers-set-boot-failsafe.sh ${D}${bindir}/.
    install -m 0755 ${WORKDIR}/transformers-check-host-state.sh ${D}${bindir}/.

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-host-s0-set-failsafe.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-host-s5-set-failsafe.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-host-set-boot-failsafe@.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-check-host-state.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-host-ready.target ${D}${systemd_system_unitdir}
}
