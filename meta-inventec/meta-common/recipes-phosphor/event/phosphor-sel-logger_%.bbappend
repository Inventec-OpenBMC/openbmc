FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append += " file://0001-Modified-sel-file-location-path-and-add-RecordID-pro.patch \
                    file://0002-PATCH-Add-SIGHUP-handler-to-check-clear_sel-to-resta.patch \
                  "

# Enable threshold monitoring to log event
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON"
