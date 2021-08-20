FILESEXTRAPATHS_prepend_evb-npcm845 := "${THISDIR}/${PN}:"

SRC_URI_append_evb-npcm845 = " file://99-ipmi-kcs.rules.rules"

KCS_DEVICE_evb-npcm845 = "ipmi_kcs1"

do_install_append_evb-npcm845() {
        install -d ${D}/lib/udev/rules.d
        install -m 0644 ${WORKDIR}/99-ipmi-kcs.rules.rules ${D}/lib/udev/rules.d
}
