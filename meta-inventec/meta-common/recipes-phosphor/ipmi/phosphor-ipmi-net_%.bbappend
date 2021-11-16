FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Fix-session-handle-not-change-issue.patch \
            file://0002-inventec-common-Implement-LAN-Config-Primary-RMCP-Po.patch \
            file://0003-Add-session-state-checking-before-execution.patch \
            file://0004-IPMI-Session-RMCP-RMCPplus.patch \
            file://0005-Implement-generate-SIK-by-bmckey.patch \
            "
