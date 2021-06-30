SUMMARY = "OpenBMC for Inventec - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-chassis \
        ${PN}-fans \
        ${PN}-flash \
        ${PN}-system \
        ${PN}-ipmi-oem \
        "

PROVIDES += "virtual/obmc-chassis-mgmt"
PROVIDES += "virtual/obmc-fan-mgmt"
PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"
PROVIDES += "virtual/obmc-ipmi-oem"

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"
RPROVIDES_${PN}-ipmi-oem += "virtual-obmc-ipmi-oem"

SUMMARY_${PN}-chassis = "Inventec Chassis"
RDEPENDS_${PN}-chassis = " \
        x86-power-control \
        obmc-host-failure-reboots \
        "

SUMMARY_${PN}-fans = "Inventec Fans"
RDEPENDS_${PN}-fans = " \
        phosphor-pid-control \
        "

SUMMARY_${PN}-flash = "Inventec Flash"
RDEPENDS_${PN}-flash = " \
        obmc-flash-bmc \
        obmc-mgr-download \
        obmc-control-bmc \
        phosphor-ipmi-blobs \
        phosphor-ipmi-flash \
        "

SUMMARY_${PN}-system = "Inventec System"
RDEPENDS_${PN}-system = " \
        bmcweb \
        entity-manager \
        dbus-sensors \
        webui-vue \
        phosphor-snmp \
        phosphor-sel-logger \
        phosphor-gpio-monitor \
        phosphor-gpio-monitor-monitor \
        vlan \
	tzdata \
        "

SUMMARY_${PN}-ipmi-oem = "Inventec IPMI OEM"
RDEPENDS_${PN}-ipmi-oem = " \
        intel-ipmi-oem \
        "


