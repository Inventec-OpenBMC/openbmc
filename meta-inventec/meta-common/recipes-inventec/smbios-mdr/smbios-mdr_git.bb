SUMMARY = "Smbios-mdr"
DESCRIPTION = "SMBIOS MDR"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"
inherit cmake
inherit obmc-phosphor-dbus-service

SRC_URI = "git://github.com/openbmc/smbios-mdr"

DEPENDS = "boost systemd sdbusplus phosphor-logging phosphor-dbus-interfaces libpeci i2c-tools phosphor-ipmi-blobs"

PV = "0.1+git${SRCPV}"
SRCREV = "5b285892fe22bc5ed9ddf5a5f1322b58a55cfca8"

S = "${WORKDIR}/git"

FILES_${PN}_append = " ${libdir}/ipmid-providers/lib*${SOLIBS}"
FILES_${PN}-dev_append = " ${libdir}/ipmid-providers/lib*${SOLIBSDEV}"

SYSTEMD_SERVICE_${PN} += "smbios-mdrv2.service \
                          xyz.openbmc_project.cpuinfo.service"

EXTRA_OECMAKE = "-DYOCTO=1"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-support-mmap-smbios-table-from-video-shared-memory-a.patch"
