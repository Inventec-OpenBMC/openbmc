FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "90305dcaff88e06b5703973658bba7ff1294974e"

FILES_${PN}-updater_append_buv-runbmc = " \
    ${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG_buv-runbmc += "verify_signature"
