FILESEXTRAPATHS_prepend_transformers-nuv := "${THISDIR}/${PN}:"


# Enable CPU Log and Raw PECI support
#EXTRA_OEMESON_append_transformers-nuv = " -Dredfish-cpu-log=enabled"
#EXTRA_OEMESON_append_transformers-nuv = " -Dredfish-raw-peci=enabled"

# Enable Redfish BMC Journal support
EXTRA_OEMESON_append_transformers-nuv = " -Dredfish-bmc-journal=enabled"

# Enable DBUS log service
# EXTRA_OEMESON_append_transformers-nuv = " -Dredfish-dbus-log=enabled"

# Enable TFTP
EXTRA_OEMESON_append_transformers-nuv = " -Dinsecure-tftp-update=enabled"

# Increase body limit for BIOS FW
EXTRA_OEMESON_append_transformers-nuv = " -Dhttp-body-limit=35"

# enable debug
# EXTRA_OEMESON_append_transformers-nuv = " -Dbmcweb-logging=enabled"
