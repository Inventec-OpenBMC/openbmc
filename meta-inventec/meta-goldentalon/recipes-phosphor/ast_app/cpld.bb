DESCRIPTION = "Aspeed SDK jtag CPLD program Tool"
PR = "r1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS_append := "${THISDIR}/cpld:"

BB_NO_NETWORK = "0"
S = "${WORKDIR}"

HASHSTYLE = "gnu"
INSANE_SKIP_${PN} = "ldflags"

SRC_URI += "file://ast-jtag.h"
SRC_URI += "file://lattice.h"
SRC_URI += "file://ast-jtag.c"
SRC_URI += "file://lattice.c"
SRC_URI += "file://main.c"
SRC_URI += "file://Makefile"

do_compile() {
        oe_runmake SRCDIR=${S}
}

do_install() {
        install -d ${D}${sbindir}
        install -m 0755 ${S}/cpld ${D}${sbindir}
}
