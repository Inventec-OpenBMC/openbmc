FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

DEPENDS += " phosphor-dbus-interfaces"

# To enable debug msg
# Note:
#   If eable this setting, the app 'bmcweb' will be larger than default one
#   and needs more time to compile it. It should be disabled, if do a formal relese build

#EXTRA_OEMESON_remove = "--buildtype=minsize"
#EXTRA_OEMESON += " --buildtype=debug -Dbmcweb-logging=enabled"

EXTRA_OEMESON += "-Dhttp-body-limit=512 -Dinsecure-tftp-update=enabled"

#SRC_URI_append += " file://0001-Modify-firmware-update-mechanism.patch \
#"
SRC_URI_append += " file://0003-Add-redfish-managers-serialInterfaces.patch \
                    file://0002-enable-managers-logging-dump-journal.patch \
                    file://0001-Delete-event-log.patch \
                    file://0002-Empty-base-dn-error.patch \
"
