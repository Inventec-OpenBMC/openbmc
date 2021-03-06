FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Subject-PATCH-Subject-PATCH-Sensor-Patch-to-support-.patch \
            file://0002-inventec-common-sensors-Patch-to-support-sensor-numb.patch \
            file://0003-inventec-common-Fan-Patch-to-support-sensor-number-e.patch \
            file://0004-Support-I2C-adc-sensor.patch \
            file://0005-Sensor-Add-NM-and-BIOS-event-DBUS-interface-for-IPMI.patch \
            file://0006-Sensor-Add-WATCHDOG-sensor-DBUS-interface.patch \
            file://0007-Add-tmp468-support-and-Label-search-for-extra-threso.patch \
            file://0008-Add-support-for-inventec-virtual-driver.patch \
            file://0009-Create-EventSensor-to-setup-event-only-sensor-on-dbu.patch \
            file://0010-Add-totalThresholdNumber-when-HwmonTempSensor-create.patch \
            file://0011-Skip-sub-sensor-if-sensorInfo-not-config.patch \
            file://0012-inventec-common-ExitAirTemp-Patch-to-support-sensor-.patch \
            file://0013-inventec-common-AverageSensor-averagesensor-initial-.patch \
            file://0014-inventec-common-InvCfmSensor-Initial-Inventec-CFM-se.patch \
            file://0015-Bug-573-SW-Common-Accumulate-sensor-initial-commit.patch \
            file://0016-modify-the-psu-sensors-reading-method.patch \
            file://0017-add-the-iio_hwmon-sensor-initial-and-service.patch \
            file://0018-add-TsodSensor-support.patch \
            "

PACKAGECONFIG_append =" \	
            nmeventsensor \
            bioseventsensor \
            wdtsensor \
            eventsensor \
            averagesensor \
            invcfmsensor \
            accumulatesensor \
            iiohwmonsensor \
            tsodsensor \
            "

PACKAGECONFIG_remove ="mcutempsensor intrusionsensor"

PACKAGECONFIG[nmeventsensor] = "-Dnm=enabled, -Dnm=disabled"
PACKAGECONFIG[bioseventsensor] = "-Dbios=enabled, -Dbios=disabled"
PACKAGECONFIG[wdtsensor] = "-Dwdt=enabled, -Dwdt=disabled"
PACKAGECONFIG[eventsensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[averagesensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[invcfmsensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[accumulatesensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[iiohwmonsensor] = "-Devent=enabled, -Devent=disabled"
PACKAGECONFIG[tsodsensor] = "-Devent=enabled, -Devent=disabled"

SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.nmeventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.bioseventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.wdtsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.eventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.averagesensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.invcfmsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.accumulatesensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.iiohwmonsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.tsodsensor.service"
