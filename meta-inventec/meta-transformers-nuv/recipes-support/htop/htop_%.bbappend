FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append = "file://0001-Correctly-detect-failure-to-initialize-boottime.patch"
