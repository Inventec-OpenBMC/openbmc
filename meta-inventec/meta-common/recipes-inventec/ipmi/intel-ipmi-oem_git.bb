SUMMARY = "Intel OEM IPMI commands"
DESCRIPTION = "Intel OEM IPMI commands"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a6a4edad4aed50f39a66d098d74b265b"

SRC_URI = "git://github.com/openbmc/intel-ipmi-oem" 

SRCREV = "fb9f1aa1ea3c944fbba17b51ab26264af1c67a25"

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
                    file://0002-Remove-Intel-IPMI-OEM-commands.patch \
                    file://0003-IPMI-SEL-Implement-Set-SEL-Time-command.patch \
                    file://0004-Modified-IPMI-command-Add-Get-SEL-Entry.patch \
                    file://0005-Modified-Platform-Event-a.k.a.-Event-Message-command.patch \
                    file://0006-dont-register-mfg-filters.patch \
                    file://0007-Replace-sensor-commands-used-phosphor-ipmi-host-befo.patch \
                    file://0008-disable-whitelist-filter.patch \
                    file://0009-IPMI-Patch-sensor-reading-command-to-get-sensor-numb.patch \
                    file://0010-inventec-common-Add-more-sensor-type-and-event-type.patch \
                    file://0011-inventec-common-Fix-sensor-reading-factor-un-match-i.patch \
                    file://0012-Implement-SEL-get-set-UTC-time-offset.patch  \
                    file://0013-Implement-get-set-system-boot-option.patch \
                    file://0014-The-main-implementation-of-WARM-RESET.patch  \
                    file://0015-Change-the-way-to-generate-fru-id.patch \
                    file://0016-Fix-set-sensor-threshold-command-fail-issue.patch \
                    file://0017-Modify-the-Repository-Update-Support-to-non-modal.patch \
                    file://0018-Bug-629-SW-Transformers-OpenBMC-Support-mc-selftest-.patch \
                    file://0019-Implement-Get-system-GUID-function.patch \
                    file://0020-Implement-Get-Set-global-enables-and-modify-related-.patch \
                    file://0021-Implement-get-chassis-status-command.patch \
                    file://0022-Implement-Get-Sensor-Reading-Factors-Command.patch \
                    file://0023-Add-Get-Sensor-Type-command-support.patch \
                  "

