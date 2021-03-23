FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-Add-property-EepromPath-and-EepromService-under-xyz..patch \
    file://0002-Add-the-pre-timeout-interrupt-defined-in-IPMI-spec.patch \
    file://0003-Add-PreInterruptFlag-properity-in-DBUS.patch \
    file://0004-inventec-state-watchdog-Store-Don-t-log-flag-to-dbus.patch \
    file://0005-inventec-common-Add-RequestedPowerIntervalMs-propert.patch \
    file://0006-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
"
