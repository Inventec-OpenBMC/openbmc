SUMMARY = "OpenBMC for BUV RUNBMC system - Applications"
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
PROVIDES += "virtual/oobmc-chassis-mgmt"
PROVIDES += "virtual/obmc-fan-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-system = "virtual-obmc-system-mgmt"

SUMMARY_${PN}-chassis = "BUV RUNBMC Chassis"
RDEPENDS_${PN}-chassis = " \
    phosphor-pid-control \
    "

SUMMARY_${PN}-fans = "BUV RUNBMC Fans"
RDEPENDS_${PN}-fans = " \
    phosphor-pid-control \
    "

SUMMARY_${PN}-system = "BUV RUNBMC System"
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

SUMMARY_${PN}-entity = "BUV RUNBMC entity"
RDEPENDS_${PN}-entity = " \
    intel-ipmi-oem \
    "

SUMMARY_${PN}-dev = "BUV RUNBMC development tools"
RDEPENDS_${PN}-dev = " \
    ent \
    dhrystone \
    rw-perf \
    htop \
    "

