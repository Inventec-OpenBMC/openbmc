SUMMARY = "Inventec GPIO library"
DESCRIPTION = "Inventec GPIO library"
PR = "r0"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

S = "${WORKDIR}"

SRC_URI = "file://*"


inherit cmake

DEPENDS = " \
      boost \
      libgpiod \
      nlohmann-json \
   "

EXTRA_OECMAKE=""

LIBRARY_NAMES = "libinvgpiolib.so"
