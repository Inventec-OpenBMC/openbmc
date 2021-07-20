inherit obmc-phosphor-systemd
inherit buv-entity-utils

FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

DEPENDS_append_transformers-nuv = " \
    ${@entity_enabled(d, '', 'buv-runbmc-yaml-config')}"


EXTRA_OECONF_transformers-nuv = " \
    ${@entity_enabled(d, '', 'YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-fru-read.yaml')} \
    ${@entity_enabled(d, '', 'PROP_YAML=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-extra-properties.yaml')} \
    "

EEPROM_NAMES = "bmc"

EEPROMFMT = "system/chassis/{0}"
EEPROM_ESCAPEDFMT = "system-chassis-{0}"
EEPROMS = "${@compose_list(d, 'EEPROMFMT', 'EEPROM_NAMES')}"
EEPROMS_ESCAPED = "${@compose_list(d, 'EEPROM_ESCAPEDFMT', 'EEPROM_NAMES')}"

ENVFMT = "obmc/eeproms/{0}"
ENVF = "${@compose_list(d, 'ENVFMT', 'EEPROMS')}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_transformers-nuv := "${@entity_enabled(d, '', ' ${ENVF}')}"

TMPL = "obmc-read-eeprom@.service"
TGT = "${SYSTEMD_DEFAULT_TARGET}"
INSTFMT = "obmc-read-eeprom@{0}.service"
FMT = "../${TMPL}:${TGT}.wants/${INSTFMT}"
LINKS = "${@compose_list(d, 'FMT', 'EEPROMS_ESCAPED')}"
SYSTEMD_LINK_${PN}_append_transformers-nuv := "${@entity_enabled(d, '', ' ${LINKS}')}"
