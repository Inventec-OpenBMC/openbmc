
# Overwrite the service configuration "bmc_booted.conf"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI +=  " \
        file://bmc_booted.conf \
        file://group_manager.conf \
    "

SYSTEMD_OVERRIDE_${PN} += \
    "group_manager.conf:xyz.openbmc_project.LED.GroupManager.service.d/group_manager.conf"

do_compile_prepend_starscream() {
    install -m 0644 ${STAGING_DATADIR_NATIVE}/${PN}/led.yaml ${S}
}

