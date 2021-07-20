FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SMBUS_BINDING = "smbus"

SRC_URI_transformers-nuv = "git://github.com/Nuvoton-Israel/pmci.git;protocol=ssh"

SRCREV_transformers-nuv = "bbbe833676c74b61fdc7bcc67d756eb8f557641a"

SRC_URI_append_transformers-nuv = " file://mctp_config.json"

do_install_append_transformers-nuv() {
    install -m 0644 -D ${WORKDIR}/mctp_config.json \
        ${D}${datadir}/mctp/mctp_config.json
}
