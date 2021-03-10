FILESEXTRAPATHS_append := ":${THISDIR}/${PN}"

SRC_URI += "file://0001-Subject-Watchgog-SEL-Support-IPMI-Watchgog-event-and.patch \
            file://0002-inventec-Store-Don-t-log-flag-to-dbus.patch \
            "

# Remove the override to keep service running after DC cycle
SYSTEMD_OVERRIDE_${PN}_remove = "poweron.conf:phosphor-watchdog@poweron.service.d/poweron.conf"
SYSTEMD_SERVICE_${PN} = "phosphor-watchdog.service"
