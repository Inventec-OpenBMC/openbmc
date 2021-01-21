inherit obmc-phosphor-systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

EEPROM_NAMES = "bmc"

EEPROMFMT = "system/chassis/{0}"
EEPROM_ESCAPEDFMT = "system-chassis-{0}"
EEPROMS = "${@compose_list(d, 'EEPROMFMT', 'EEPROM_NAMES')}"
EEPROMS_ESCAPED = "${@compose_list(d, 'EEPROM_ESCAPEDFMT', 'EEPROM_NAMES')}"

ENVFMT = "obmc/eeproms/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append := " ${@compose_list(d, 'ENVFMT', 'EEPROMS')}"

TMPL = "obmc-read-eeprom@.service"
TGT = "multi-user.target"
INSTFMT = "obmc-read-eeprom@{0}.service"
FMT = "../${TMPL}:${TGT}.wants/${INSTFMT}"

SYSTEMD_LINK_${PN}_append := " ${@compose_list(d, 'FMT', 'EEPROMS_ESCAPED')}"
SYSTEMD_SERVICE_${PN} += " eeprom-guid-sync.service"

SRC_URI_append += " file://0001-Patched-to-check-Multi-Record-Area-first-record-head.patch \
                  "
