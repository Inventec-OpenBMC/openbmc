FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

OBMC_CONSOLE_HOST_TTY = "ttyVUART0"

SRC_URI += "file://obmc-console0.conf" 
SRC_URI += "file://obmc-console1.conf" 
SRC_URI += "file://obmc-console2.conf" 
SRC_URI += "file://obmc-console3.conf" 

do_install_append() {
    install -m 0644 ${WORKDIR}/obmc-console0.conf ${D}${sysconfdir}/obmc-console.conf
    install -m 0644 ${WORKDIR}/obmc-console1.conf ${D}${sysconfdir}/obmc-console1.conf
    install -m 0644 ${WORKDIR}/obmc-console2.conf ${D}${sysconfdir}/obmc-console2.conf
    install -m 0644 ${WORKDIR}/obmc-console3.conf ${D}${sysconfdir}/obmc-console3.conf
}

