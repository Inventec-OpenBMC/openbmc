FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

DEPENDS += "inv-gpiolib"


SRC_URI += "file://0001-Subject-PATCH-Subject-PATCH-Sensor-Patch-to-support-.patch \
            file://0002-Subject-PATCH-Sensor-Patch-to-support-sensor-number-.patch \
            file://0003-Subject-PATCH-Sensor-Event-Support-GPIO-sensor-monit.patch \
            file://0004-Subject-Patch-dbus-sensors-Fan-Support-I2C-fan-senso.patch \
            file://0005-Subject-PATCH-Sensor-Support-I2C-adc-sensor-adt7462.patch \
            file://0006-Subject-Patch-Sensor-Add-NM-and-BIOS-event-DBUS-inte.patch \
            file://0007-Subject-Patch-Sensor-Add-WATCHDOG-sensor-DBUS-interf.patch \
            file://0008-Add-tmp468-support-and-Label-search-for-extra-threso.patch \
            file://0009-Add-support-for-inventec-virtual-driver.patch \
            file://0010-Create-EventSensor-to-setup-event-only-sensor-on-dbu.patch \
            file://0011-Add-totalThresholdNumber-when-HwmonTempSensor-create.patch \
            file://0012-Skip-sub-sensor-if-sensorInfo-not-config.patch \
            file://0013-inventec-common-ExitAirTemp-Patch-to-support-sensor-.patch \
            file://0014-inventec-common-AverageSensor-averagesensor-initial-.patch \
            file://0015-inventec-common-InvCfmSensor-Initial-Inventec-CFM-se.patch \
            "

PACKAGECONFIG_append =" \
            gpiosensor \
            nmeventsensor \
            bioseventsensor \
            wdtsensor \
            eventsensor \
            averagesensor \
            invcfmsensor \
            "
PACKAGECONFIG_remove ="mcutempsensor intrusionsensor"

PACKAGECONFIG[gpiosensor] = "-Dgpio=enabled, -Dgpio=disabled"
PACKAGECONFIG[nmeventsensor] = "-Dnm=enabled, -Dnm=disabled"
PACKAGECONFIG[bioseventsensor] = "-Dbios=enabled, -Dbios=disabled"
PACKAGECONFIG[wdtsensor] = "-Dwdt=enabled, -Dwdt=disabled"
PACKAGECONFIG[eventsensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[averagesensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[invcfmsensor] = "-Devent=enabled, -Devent=disabled"

SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.gpiosensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.nmeventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.bioseventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.wdtsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.eventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.averagesensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.invcfmsensor.service"

