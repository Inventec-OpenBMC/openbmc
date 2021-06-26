SUMMARY = "Intel ASD Utility"
DESCRIPTION = "Intel At-Scale Debug utility"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0d1c657b2ba1e8877940a8d1614ec560"

SRC_URI = "git://github.com/Intel-BMC/asd"
SRCREV = "f31661d92e80b3f097d37055f590595898cef6b6"

S = "${WORKDIR}/git"
PV = "0.1+git${SRCPV}"

DEPENDS = "openssl libpam libgpiod systemd libsafec"

inherit cmake systemd
