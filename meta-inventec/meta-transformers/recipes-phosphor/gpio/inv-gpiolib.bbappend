# This bbappend file is used to overwirte the platform GPIO pin define config

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append += "file://config.json "

do_install_append() {
    install -d 0755 ${D}/etc/default/obmc/gpio
    install -m 0644 ${WORKDIR}/config.json ${D}/etc/default/obmc/gpio/gpio_defs_inv.json
}
