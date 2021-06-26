DESCRIPTION = "Inventec utilities"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS_prepend := "${THISDIR}:"

inherit cmake


S = "${WORKDIR}/${BPN}"

SRC_URI = "file://${BPN}/CMakeLists.txt       \
           file://${BPN}/include/mac_util.hpp \
           file://${BPN}/README.md            \
           file://${BPN}/src/mac_util.cpp     \
"


EXTRA_OECMAKE=""
