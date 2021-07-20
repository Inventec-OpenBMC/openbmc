FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append_transformers-nuv = " file://0028-MCTP-Daemon-D-Bus-interface-definition.patch"
SRC_URI_append_transformers-nuv = " file://0001-Software-Add-MCU-VersionPurpose.patch"
