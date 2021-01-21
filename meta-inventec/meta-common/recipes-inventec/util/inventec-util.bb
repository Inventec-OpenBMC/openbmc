DESCRIPTION = "Inventec utilities"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit cmake


S = "${WORKDIR}"

SRC_URI = "file://*"


EXTRA_OECMAKE=""
