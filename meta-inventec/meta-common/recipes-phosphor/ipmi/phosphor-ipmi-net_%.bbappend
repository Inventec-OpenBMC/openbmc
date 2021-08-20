FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Fix-session-handle-not-change-issue.patch \
            file://0002-inventec-common-Implement-LAN-Config-Primary-RMCP-Po.patch \
            file://0003-Add-session-state-checking-before-execution.patch \
            file://0004-Support-IPMIv1.5-SessionActivation.patch \
            file://0005-Refactor-IPMIv1.5-SessionActivation.patch \
            file://0006-Support-IPMIv1.5-SessionManagement-netipmid.patch \
            "
