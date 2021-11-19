FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append += " file://0001-Modified-sel-file-location-path-and-add-RecordID-pro.patch \
                    file://0002-PATCH-Add-SIGHUP-handler-to-check-clear_sel-to-resta.patch \
                    file://0003-Fix-IPMI-logging-service-fail-to-start-issue.patch \
                    file://0004-Bug-651-SW-Common-SEL-SEL-entry-number-repeat-when-i.patch \
                  "

# Enable threshold monitoring to log event
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON"
EXTRA_OECMAKE += "-DREDFISH_LOG_MONITOR_PULSE_EVENTS=ON"
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_ALARM_EVENTS=ON"
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_WATCHDOG_EVENTS=ON"

