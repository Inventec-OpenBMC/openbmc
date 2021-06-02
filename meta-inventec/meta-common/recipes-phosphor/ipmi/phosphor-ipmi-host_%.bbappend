EXTRA_OECONF_append = " --disable-i2c-whitelist-check"
EXTRA_OECONF_append = " --disable-ipmi-whitelist"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-sensorhandler-fix-get-threshold-error.patch \
                   file://0002-sensorhandler-Implement-SetSensorThreshold-command.patch \
                   file://0003-sensorhandler-Implement-GetSensorReadingFactors-comm.patch \
                   file://0004-Implement-Fru-write-function.patch \
                   file://0005-Modify-ipmiStorageWriteFruData-for-fru-write-command.patch \
                   file://0006-Save-the-pre-timeout-interrupt-in-dbus-property.patch \
                   file://0007-inventec-app-watchdog-Store-Don-t-log-flag-to-dbus.patch \
                   file://0008-Compose-Aux-Firmware-Rev-Info-in-Get-Device-Id-comma.patch \
                   file://0009-Fix-Can-t-Set-FRU-data-by-raw-command-but-successful.patch \
                   file://0010-Implement-LAN-Config-IPv6-Static-Hop-Limit.patch \
                   file://0011-Implement-LAN-Config-Community-String.patch \
                   file://0012-inventec-common-Implement-LAN-Config-Primary-RMCP-Po.patch \
                   file://0013-inventec-common-DCMI-Power-Implement-DCMI-get-power-.patch \
                   file://0014-Implement-LAN-Config-Destination-Addresses.patch \
                   file://0015-inventec-common-DCMI-Enhance-set-get-power-limit.patch \
                   file://0016-Implement-LAN-Config-VLAN-Priority.patch \
                   file://0017-Fix-resource-not-released-after-update-config.patch \
                   file://0018-Bug-354-Transformers-OpenBMC-IPMI-Get-Enhanced-Syste.patch \
"



do_install_append_inventec(){
  install -d ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}
