FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI_append = " file://fw_env.config \
		   file://0001-Goldentalon-Initial-u-boot-fw-utility.patch \
                 "


do_install_append () {
        install -d ${D}${sysconfdir}
        install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}

