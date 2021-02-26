FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append += " file://0001-Implement-Get-System-GUID-command-get-from-MB-EEPROM.patch \
                    file://0002-Remove-write-data-check-of-MasterWriteRead.patch \
                    file://0003-Fixed-DCMI-get-power-reading-fail-when-get-exception.patch \
                    file://0004-Patch-DCMI-Get-Power-reading-command.patch \
		    file://0005-Implement-Fru-write-function.patch \
                  "
