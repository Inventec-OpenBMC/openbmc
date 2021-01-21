FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRCREV = "c7e956275ffeff2b3e8ea9cad90bdccec61b4945"


DEPENDS += "inv-gpiolib"


SRC_URI += "file://0001-Sensor-to-support-IPMI-sensorInfo-selLogging.patch \
            file://0002-Subject-PATCH-Sensor-Patch-to-support-sensor-number-.patch \
            file://0003-Subject-PATCH-Sensor-Patch-to-support-sensor-number-.patch \
            file://0004-Subject-PATCH-Sensor-Patch-to-support-sensor-number-.patch \
            file://0005-Subject-PATCH-Sensor-PSU-Patch-to-support-IpmiInfo-f.patch \
            file://0006-Sensor-Event-Support-GPIO-sensor-monitor-to-trigger.patch \
            file://0007-Subject-Patch-dbus-sensors-Fan-Support-I2C-fan-senso.patch \
            file://0008-Subject-PATCH-Sensor-Support-I2C-adc-sensor-adt7462.patch \
            file://0009-Subject-Patch-Sensor-Add-NM-and-BIOS-event-DBUS-inte.patch \
            file://0010-Subject-Patch-Sensor-Add-WATCHDOG-sensor-DBUS-interf.patch \
            file://0011-inventec-HwmonTemp-Add-tmp468-support-and-Label-sear.patch \
            file://0012-Add-support-for-inventec-virtual-driver.patch \
            file://0013-Fix-index-for-fan0-and-pwm0.patch \
            "


EXTRA_OECMAKE += "-DDISABLE_MCUTEMP=ON -DDISABLE_INTRUSION=ON -DDISABLE_EXIT_AIR=ON"

SYSTEMD_SERVICE_${PN}_remove += " xyz.openbmc_project.exitairsensor.service"
SYSTEMD_SERVICE_${PN}_remove += " xyz.openbmc_project.intrusionsensor.service"
SYSTEMD_SERVICE_${PN}_remove += " xyz.openbmc_project.mcutempsensor.service"

SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.gpiosensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.nmeventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.bioseventsensor.service"
SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.wdtsensor.service"

