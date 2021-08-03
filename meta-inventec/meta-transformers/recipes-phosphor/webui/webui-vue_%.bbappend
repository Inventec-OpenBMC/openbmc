FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Modify-Fans-path-for-Transformers-platform.patch \
                   file://0002-No-powerSupplies-data-shown-in-WebUI.patch \
"

