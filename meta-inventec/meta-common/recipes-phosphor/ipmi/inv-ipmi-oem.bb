SUMMARY = "INV IPMI OEM commands"
DESCRIPTION = "INV IPMI OEM commands"
PR = "r0"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "file://inv-ipmi-oem/*.*"

S = "${WORKDIR}/inv-ipmi-oem"

DEPENDS = "boost phosphor-ipmi-host phosphor-logging systemd sdbusplus libpeci"
DEPENDS += "nlohmann-json"

inherit cmake obmc-phosphor-ipmiprovider-symlink

EXTRA_OECMAKE=""

LIBRARY_NAMES = "libinvoemcmds.so"

HOSTIPMI_PROVIDER_LIBRARY += "${LIBRARY_NAMES}"
NETIPMI_PROVIDER_LIBRARY += "${LIBRARY_NAMES}"

FILES_${PN}_append = " ${libdir}/ipmid-providers/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/host-ipmid/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/net-ipmid/lib*${SOLIBS}"
FILES_${PN}-dev_append = " ${libdir}/ipmid-providers/lib*${SOLIBSDEV}"

#linux-libc-headers guides this way to include custom uapi headers
CFLAGS_append = " -I ${STAGING_KERNEL_DIR}/include/uapi"
CFLAGS_append = " -I ${STAGING_KERNEL_DIR}/include"
CXXFLAGS_append = " -I ${STAGING_KERNEL_DIR}/include/uapi"
CXXFLAGS_append = " -I ${STAGING_KERNEL_DIR}/include"
do_configure[depends] += "virtual/kernel:do_shared_workdir"

do_install_append(){
   install -d ${D}${includedir}/inv-ipmi-oem
   install -m 0644 -D ${S}/include/*.hpp ${D}${includedir}/inv-ipmi-oem
}
