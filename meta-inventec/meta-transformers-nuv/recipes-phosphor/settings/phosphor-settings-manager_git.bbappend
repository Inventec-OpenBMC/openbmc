FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"
SRC_URI_append_transformers-nuv = " file://chassis-capabilities.override.yml"
SRC_URI_append_transformers-nuv = " file://sol-parameters.override.yml"
