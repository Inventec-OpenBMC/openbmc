EXTRA_OECONF_append = " --disable-i2c-whitelist-check"
EXTRA_OECONF_append = " --disable-ipmi-whitelist"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-sensorhandler-fix-get-threshold-error.patch \
                   file://0002-sensorhandler-Implement-SetSensorThreshold-command.patch \
                   file://0003-sensorhandler-Implement-GetSensorReadingFactors-comm.patch \
                   file://0004-Save-the-pre-timeout-interrupt-in-dbus-property.patch \
                   file://0005-inventec-app-watchdog-Store-Don-t-log-flag-to-dbus.patch \
                   file://0006-Compose-Aux-Firmware-Rev-Info-in-Get-Device-Id-comma.patch \
                   file://0007-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
                   file://0008-Implement-LAN-Config-Community-String.patch \
                   file://0009-Implement-LAN-Config-Primary-RMCP-Port.patch \
                   file://0010-Implement-DCMI-get-power-reading.patch \
                   file://0011-Implement-LAN-Config-Destination-Addresses.patch \
                   file://0012-inventec-common-DCMI-Enhance-set-get-power-limit.patch \
                   file://0013-Implement-LAN-Config-VLAN-Priority.patch \
                   file://0014-Bug-354-Transformers-OpenBMC-IPMI-Get-Enhanced-Syste.patch \
                   file://0015-Force-zero-padding-when-setting-password.patch \
                   file://0016-Refine-IPFamilyEnables-command.patch \
                   file://0017-Add-MAC-address-support-for-destination-address.patch \
                   file://0018-Add-IPv6Only-mode-support-in-IPFamilySupport-command.patch \
"



do_install_append_inventec(){
  install -d ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}
