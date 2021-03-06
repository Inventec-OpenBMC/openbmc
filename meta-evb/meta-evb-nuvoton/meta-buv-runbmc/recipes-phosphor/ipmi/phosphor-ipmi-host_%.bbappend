inherit buv-entity-utils

SRC_URI_remove_buv-runbmc = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend_buv-runbmc = "git://github.com/Nuvoton-Israel/phosphor-host-ipmid"
SRCREV_buv-runbmc = "3f553e155500938a51a06173633c51be87ec463a"

DEPENDS_append_buv-runbmc= " \
    ${@entity_enabled(d, '', ' buv-runbmc-yaml-config')}"

EXTRA_OECONF_buv-runbmc = " \
    --with-journal-sel \
    ${@entity_enabled(d, '', ' SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-sensors.yaml')} \
    ${@entity_enabled(d, '', ' FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-fru-read.yaml')} \
    ${@entity_enabled(d, '', ' --disable-dynamic_sensors')} \
    "

do_install_append_buv-entity(){
    install -d ${D}${includedir}/phosphor-ipmi-host
    install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
    install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}
