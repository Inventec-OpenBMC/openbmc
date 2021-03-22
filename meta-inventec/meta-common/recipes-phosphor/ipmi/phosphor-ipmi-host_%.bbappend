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
"



do_install_append_inventec(){
  install -d ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}