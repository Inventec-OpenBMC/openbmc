FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://ipmi_pass_admin"

do_install_append() {
	    install -m 0644 ${WORKDIR}/ipmi_pass_admin ${D}${sysconfdir}/ipmi_pass
}

