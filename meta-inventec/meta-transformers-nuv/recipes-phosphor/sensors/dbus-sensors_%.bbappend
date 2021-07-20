FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"

SRC_URI_append_transformers-nuv = " \
    file://0003-Avoid-power-state-always-ADC-cannot-trigger-alarm.patch \
    file://0004-wait-mapper-for-avoid-failed-to-find-log.patch \
    "
