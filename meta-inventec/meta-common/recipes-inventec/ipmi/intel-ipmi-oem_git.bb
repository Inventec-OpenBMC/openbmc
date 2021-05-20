SUMMARY = "Intel OEM IPMI commands"
DESCRIPTION = "Intel OEM IPMI commands"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a6a4edad4aed50f39a66d098d74b265b"

SRC_URI = "git://github.com/openbmc/intel-ipmi-oem"
SRCREV = "aedf5a9efe124853b3c722e155fea931befce89d"

S = "${WORKDIR}/git"
PV = "0.1+git${SRCPV}"

DEPENDS = "boost phosphor-ipmi-host phosphor-logging systemd intel-dbus-interfaces libgpiod"

inherit cmake obmc-phosphor-ipmiprovider-symlink

EXTRA_OECMAKE="-DENABLE_TEST=0 -DYOCTO=1"

LIBRARY_NAMES = "libzinteloemcmds.so"

HOSTIPMI_PROVIDER_LIBRARY += "${LIBRARY_NAMES}"
NETIPMI_PROVIDER_LIBRARY += "${LIBRARY_NAMES}"

FILES_${PN}_append = " ${libdir}/ipmid-providers/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/host-ipmid/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/net-ipmid/lib*${SOLIBS}"
FILES_${PN}-dev_append = " ${libdir}/ipmid-providers/lib*${SOLIBSDEV}"

do_install_append(){
   install -d ${D}${includedir}/intel-ipmi-oem
   install -m 0644 -D ${S}/include/*.hpp ${D}${includedir}/intel-ipmi-oem
}


FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append += " file://0001-Removed-Get-Device-ID-command.patch \
                    file://0002-IPMI-Patch-sensor-reading-command-to-get-sensor-numb.patch \
                    file://0003-Remove-Intel-IPMI-OEM-commands.patch \
                    file://0004-SEL-Patched-to-get-match-snesor-number-from-event-db.patch \
                    file://0005-IPMI-SEL-Modified-Event-Reading-type-detect-from-sen.patch \
                    file://0006-IPMI-SEL-Implement-Set-SEL-Time-command.patch \
                    file://0007-Modified-IPMI-command-Add-Get-SEL-Entry.patch \
                    file://0008-Modified-Platform-Event-a.k.a.-Event-Message-command.patch \
                    file://0009-Fix-Get-Wrong-ObjPath-and-Enhance-the-performance.patch \
                    file://0010-PATCH-Modified-IPMI-Clear-SEL-function.patch \
                    file://0011-dont-register-mfg-filters.patch \
                    file://0012-De-register-Get-and-Set-threshold.patch \
		    file://0013-Replace-sensor-commands-used-phosphor-ipmi-host-befo.patch \
                    file://0014-disable-whitelist-filter.patch \
                    file://0015-Disable-sel-log-clear-message.patch \
                    file://0016-inventec-common-Add-more-sensor-type-and-event-type.patch \
                  "

