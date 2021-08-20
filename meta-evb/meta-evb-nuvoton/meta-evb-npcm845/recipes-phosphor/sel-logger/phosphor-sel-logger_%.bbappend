FILESEXTRAPATHS_append_evb-npcm845 := "${THISDIR}/${PN}:"

DEPENDS_append_evb-npcm845 = " phosphor-dbus-interfaces"

SRCREV := "df7bc1c6951fb7dd2776008aa0b7dc6bea44bed4"

SRC_URI_append_evb-npcm845 = " file://0001-Revert-match-thresholdAsserted-signal-for-threshold-.patch"
SRC_URI_append_evb-npcm845 = " file://xyz.openbmc_project.Logging.IPMI.service"

# Enable threshold monitoring
EXTRA_OECMAKE_append_evb-npcm845 = " -DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON \
"
do_install_append_evb-npcm845() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/xyz.openbmc_project.Logging.IPMI.service \
        ${D}${systemd_unitdir}/system
}
