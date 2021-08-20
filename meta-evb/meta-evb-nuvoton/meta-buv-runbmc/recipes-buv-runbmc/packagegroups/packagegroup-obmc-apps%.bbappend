inherit buv-entity-utils

RDEPENDS_${PN}-fru-ipmi_remove_buv-runbmc = "${@entity_enabled(d, '', 'fru-device')}"
RDEPENDS_${PN}-inventory_remove_buv-runbmc = " phosphor-fan-presence-tach"
