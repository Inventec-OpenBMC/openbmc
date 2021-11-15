FILESEXTRAPATHS_prepend_transformers := "${THISDIR}/${PN}:"
SRC_URI_append_transformers = " file://chassis-capabilities.override.yml"
SRC_URI_append_transformers = " file://sol-parameters.override.yml"
