FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

DEPENDS += " phosphor-dbus-interfaces"

# To enable debug msg
# Note:
#   If eable this setting, the app 'bmcweb' will be larger than default one
#   and needs more time to compile it. It should be disabled, if do a formal relese build

#EXTRA_OEMESON_remove = "--buildtype=minsize"
#EXTRA_OEMESON += " --buildtype=debug -Dbmcweb-logging=enabled"

EXTRA_OEMESON += "-Dhttp-body-limit=512 -Dinsecure-tftp-update=enabled"
# Enable Redfish BMC Journal support
EXTRA_OEMESON += "-Dredfish-bmc-journal=enabled"

# Enable CPU Log and Raw PECI support
#EXTRA_OEMESON += "-Dredfish-cpu-log=enabled"
#EXTRA_OEMESON += "-Dredfish-raw-peci=enabled"


# Enable DBUS log service
# EXTRA_OEMESON_append_transformers-nuv = " -Dredfish-dbus-log=enabled"

#SRC_URI_append += " file://0001-Modify-firmware-update-mechanism.patch \
#"
SRC_URI_append =  " file://0001-Empty-base-dn-error.patch \
                    file://0002-Redfish-managers-logging-entries-information-is-not-.patch \
                    file://0003-Fix-ldap-localRole-invalid-privilege-causing-interna.patch \
                    file://0004-Fix-invalid-ldap-server-uri-causing-internal-server-.patch \
                    file://0005-Ip-fix.patch \
                    file://0006-Bug-389.patch \
                    file://0007-Add-redfish-managers-serialInterfaces_updated.patch \
                    file://0008-delete-event-log.patch \
                    file://0009-gateway-ip-fix.patch \
                    file://0010-Bug404-No-PowerSupplies-data-in-redfish-v1-Chassis.patch \
                    file://0011-Boot-flag.patch \
                    file://0012-Redfish-add-power-matrics-support.patch \
                    file://0013-Add-system-airflow-sensor-support.patch \
"
