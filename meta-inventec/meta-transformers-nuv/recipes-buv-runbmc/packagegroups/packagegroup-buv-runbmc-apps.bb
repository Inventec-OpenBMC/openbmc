SUMMARY = "OpenBMC for TRANSFORMERS NUVOTON system - Applications"
PR = "r1"

inherit packagegroup
inherit buv-entity-utils

PROVIDES = "${PACKAGES}"
PACKAGES = " \
    ${PN}-chassis \
    ${PN}-fans \
    ${PN}-flash \
    ${PN}-system \
    ${PN}-ipmi-oem \
    ${@bb.utils.contains('DISTRO_FEATURES', 'buv-dev', '${PN}-dev', '', d)} \
    "

PROVIDES += "virtual/oobmc-chassis-mgmt"
PROVIDES += "virtual/obmc-fan-mgmt"
PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"
PROVIDES += "virtual/obmc-ipmi-oem"

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"
RPROVIDES_${PN}-ipmi-oem += "virtual-obmc-ipmi-oem"


SUMMARY_${PN}-chassis = "TRANSFORMERS NUVOTON Chassis"
RDEPENDS_${PN}-chassis = " \
    x86-power-control \
    obmc-host-failure-reboots \
    "

SUMMARY_${PN}-fans = "TRANSFORMERS NUVOTON Fans"
RDEPENDS_${PN}-fans = " \
    phosphor-pid-control \
    "

SUMMARY_${PN}-flash = "TRANSFORMERS NUVOTON Flash"
RDEPENDS_${PN}-flash = " \
        obmc-flash-bmc \
        obmc-mgr-download \
        obmc-control-bmc \
        phosphor-ipmi-blobs \
        phosphor-ipmi-flash \
        "

SUMMARY_${PN}-system = "TRANSFORMERS NUVOTON System"
RDEPENDS_${PN}-system = " \
    bmcweb \
    entity-manager \
    dbus-sensors \
    ipmitool \
    webui-vue \
    loadsvf \
    obmc-console \
    phosphor-sel-logger \
    phosphor-snmp \
    phosphor-gpio-monitor \
    phosphor-gpio-monitor-monitor \
    rsyslog \
    obmc-ikvm \
    iperf3 \
    iperf2 \
    usb-network \
    nmon \
    memtester \
    usb-emmc-storage \
    loadmcu \
    vlan \
    tzdata \
    "

SUMMARY_${PN}-ipmi-oem = "TRANSFORMERS NUVOTON IPMI OEM"
RDEPENDS_${PN}-ipmi-oem = " \
        intel-ipmi-oem \
        "

SUMMARY_${PN}-dev = "TRANSFORMERS NUVOTON development tools"
RDEPENDS_${PN}-dev = " \
    ent \
    dhrystone \
    rw-perf \
    htop \
    "

