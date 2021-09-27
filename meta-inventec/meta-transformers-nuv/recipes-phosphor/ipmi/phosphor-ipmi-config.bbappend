FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${BPN}:"

SRC_URI_append_transformers-nuv = " file://dev_id.json"
SRC_URI_append_transformers-nuv = " file://channel_access.json"
SRC_URI_append_transformers-nuv = " file://channel_config.json"

do_install_append_transformers-nuv() {
    install -m 0644 -D ${WORKDIR}/dev_id.json \
        ${D}/usr/share/ipmi-providers/dev_id.json
    install -m 0644 -D ${WORKDIR}/channel_access.json \
        ${D}/usr/share/ipmi-providers/channel_config.json
    install -m 0644 -D ${WORKDIR}/channel_config.json \
        ${D}/usr/share/ipmi-providers/channel_config.json
}
