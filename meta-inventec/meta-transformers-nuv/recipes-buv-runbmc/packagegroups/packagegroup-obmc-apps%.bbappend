inherit buv-entity-utils

RDEPENDS_${PN}-fru-ipmi_remove_transformers-nuv = "${@entity_enabled(d, '', 'fru-device')}"
RDEPENDS_${PN}-inventory_remove_transformers-nuv = " phosphor-fan-presence-tach"
