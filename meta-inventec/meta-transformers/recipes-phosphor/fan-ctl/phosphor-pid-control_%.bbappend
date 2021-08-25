FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

FILES_${PN}_append = " ${datadir}/swampd/config.json"
FILES_${PN}_append = " ${bindir}/fan-default-speed.sh"

SRCREV = "f54b260b6261f644a65efe5445a9e93a418c2eed"
SRC_URI_append = " file://config.json \
                   file://fan-default-speed.sh \
                   file://phosphor-pid-control.service \
                   file://0001-fix-sensor-reading-logging-problem.patch \
                   file://0002-Change-service-setting-from-name-to-readpath.patch \
                   file://0003-Adding-moving-average-method-length-2-for-thermal.patch \
                   file://0004-Modify-zone-startup-mechanism.patch \
                   file://0005-add-etc-adaptive-pid-control-algorithm.patch \
                 "

inherit obmc-phosphor-systemd
RDEPENDS_${PN} += "bash"

SYSTEMD_SERVICE_${PN} = "phosphor-pid-control.service"

do_install_append (){
    install -m 0755 -D ${WORKDIR}/config.json \
                   ${D}/usr/share/swampd/config.json
    install -d ${D}/${bindir}
    install -m 0755 ${WORKDIR}/fan-default-speed.sh ${D}/${bindir}
}
