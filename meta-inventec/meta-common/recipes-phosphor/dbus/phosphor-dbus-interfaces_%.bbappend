FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-Add-property-EepromPath-and-EepromService-under-xyz..patch \
    file://0002-Add-the-pre-timeout-interrupt-defined-in-IPMI-spec.patch \
    file://0003-Add-PreInterruptFlag-properity-in-DBUS.patch \
    file://0004-inventec-state-watchdog-Store-Don-t-log-flag-to-dbus.patch \
    file://0005-inventec-common-Add-RequestedPowerIntervalMs-propert.patch \
    file://0006-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
    file://0007-inventec-common-Modify-power-capability-for-DCMI.patch \
    file://0008-Implement-LAN-Config-VLAN-Priority.patch \
    file://0009-Add-IPv4-IPv6-addressing-enable-mode-support.patch \
    file://0010-Add-MACAddress-property-in-Client-interface.patch \
    file://0011-Add-and-modify-new-interface-related-to-system-boot-.patch \
    file://0012-Support-IPMIv1.5-SessionManagement-dbusyaml.patch \
    file://0013-Add-new-interface-related-to-bmc-global-enables-sett.patch \
    file://0014-Add-LastEvent-PowerControlReturnCode.patch \
"
