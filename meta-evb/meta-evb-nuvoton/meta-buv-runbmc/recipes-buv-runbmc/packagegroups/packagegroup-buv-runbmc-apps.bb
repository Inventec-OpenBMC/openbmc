SUMMARY = "OpenBMC for BUV RunBMC system - Applications"
PR = "r1"

inherit packagegroup
inherit buv-entity-utils

PROVIDES = "${PACKAGES}"
PACKAGES = " \
    ${PN}-chassis \
    ${PN}-fans \
    ${PN}-system \
    ${@entity_enabled(d, '${PN}-entity')} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'buv-dev', '${PN}-dev', '', d)} \
    "

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-system = "virtual-obmc-system-mgmt"

SUMMARY_${PN}-chassis = "BUV RunBMC Chassis"
RDEPENDS_${PN}-chassis = " \
    x86-power-control \
    "

SUMMARY_${PN}-fans = "BUV RunBMC Fans"
RDEPENDS_${PN}-fans = " \
    phosphor-pid-control \
    "

SUMMARY_${PN}-system = "BUV RunBMC System"
RDEPENDS_${PN}-system = " \
    ipmitool \
    webui-vue \
    phosphor-host-postd \
    loadsvf \
    obmc-console \
    phosphor-sel-logger \
    rsyslog \
    obmc-ikvm \
    iperf3 \
    iperf2 \
    usb-network \
    nmon \
    memtester \
    usb-emmc-storage \
    loadmcu \
    "

SUMMARY_${PN}-entity = "BUV RunBMC entity"
RDEPENDS_${PN}-entity = " \
    intel-ipmi-oem \
    "

SUMMARY_${PN}-dev = "BUV RunBMC development tools"
RDEPENDS_${PN}-dev = " \
    ent \
    dhrystone \
    rw-perf \
    htop \
    "

