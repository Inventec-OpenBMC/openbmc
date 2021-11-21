FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://transformers-nuv-host-s0-set-failsafe.service \
    file://transformers-nuv-host-s5-set-failsafe.service \
    file://transformers-nuv-host-set-boot-failsafe@.service \
    file://transformers-nuv-check-host-state.service \
    file://transformers-nuv-set-boot-failsafe.sh \
    file://transformers-nuv-set-failsafe.sh \
    file://transformers-nuv-check-host-state.sh \
    file://transformers-nuv-host-ready.target \
    "

RDEPENDS_${PN}_append = "bash"

CHASSIS_INSTANCE="0"

SYSTEMD_SERVICE_${PN}_append = " \
    transformers-nuv-host-s0-set-failsafe.service \
    transformers-nuv-host-s5-set-failsafe.service \
    transformers-nuv-host-set-boot-failsafe@${CHASSIS_INSTANCE}.service \
    transformers-nuv-check-host-state.service \
    transformers-nuv-host-ready.target \
    "

FILES_${PN}_append = " \
    ${systemd_system_unitdir}/transformers-nuv-host-set-boot-failsafe@.service \
    "

do_install_append() {
    install -d ${D}${bindir}

    install -m 0755 ${WORKDIR}/transformers-nuv-set-failsafe.sh ${D}${bindir}/.
    install -m 0755 ${WORKDIR}/transformers-nuv-set-boot-failsafe.sh ${D}${bindir}/.
    install -m 0755 ${WORKDIR}/transformers-nuv-check-host-state.sh ${D}${bindir}/.

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-nuv-host-s0-set-failsafe.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-nuv-host-s5-set-failsafe.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-nuv-host-set-boot-failsafe@.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-nuv-check-host-state.service ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/transformers-nuv-host-ready.target ${D}${systemd_system_unitdir}
}
