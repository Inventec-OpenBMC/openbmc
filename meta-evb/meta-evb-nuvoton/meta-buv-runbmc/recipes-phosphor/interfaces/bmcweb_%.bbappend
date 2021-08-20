FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/${PN}:"


# Enable CPU Log and Raw PECI support
#EXTRA_OEMESON_append_buv-runbmc = " -Dredfish-cpu-log=enabled"
#EXTRA_OEMESON_append_buv-runbmc = " -Dredfish-raw-peci=enabled"

# Enable Redfish BMC Journal support
EXTRA_OEMESON_append_buv-runbmc = " -Dredfish-bmc-journal=enabled"

# Enable DBUS log service
# EXTRA_OEMESON_append_buv-runbmc = " -Dredfish-dbus-log=enabled"

# Enable TFTP
EXTRA_OEMESON_append_buv-runbmc = " -Dinsecure-tftp-update=enabled"

# Increase body limit for BIOS FW
EXTRA_OEMESON_append_buv-runbmc = " -Dhttp-body-limit=35"

# enable debug
# EXTRA_OEMESON_append_buv-runbmc = " -Dbmcweb-logging=enabled"
