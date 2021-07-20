FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"
SRC_URI_append_transformers-nuv = " file://busybox.cfg"
SRC_URI_append_transformers-nuv = "${@bb.utils.contains('DISTRO_FEATURES', 'buv-dev', ' file://buv-dev.cfg', '', d)}"
