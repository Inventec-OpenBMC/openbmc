DESCRIPTION = "Inventec DCMI power handler"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

FILESEXTRAPATHS_prepend := "${THISDIR}:"


FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

S = "${WORKDIR}"

SRC_URI = "file://meson.build       \
           file://include/inventec-dcmi-power.hpp \
           file://include/util.hpp \
           file://src/inventec-dcmi-power.cpp \
           file://src/meson.build \
           file://service_files/inventec-dcmi-power.service \
           file://service_files/meson.build \
"

SYSTEMD_SERVICE_${PN} += "inventec-dcmi-power.service"

DEPENDS = "boost sdbusplus nlohmann-json"
inherit meson systemd

