SUMMARY = "Goldentalon DBUS FRU Inventory mapping."
PR = "r1"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit native
inherit phosphor-ipmi-fru

# Using the same file with transformers-ipmi-fru-read-inventory
FILESEXTRAPATHS_prepend := "${THISDIR}/transformers-ipmi-fru-read-inventory:"

SRC_URI += "file://config.yaml"

PROVIDES += "virtual/phosphor-ipmi-fru-inventory"

S = "${WORKDIR}"

do_install() {
        # TODO: install this to inventory_datadir
        # after ipmi-fru-parser untangles the host
        # firmware config from the machine inventory.
        DEST=${D}${config_datadir}

        install -d ${DEST}
        install config.yaml ${DEST}
}

