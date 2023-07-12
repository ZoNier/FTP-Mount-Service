#!/bin/bash

# Set variables
MOUNT_POINT="/path/to/mount/"
FTP_SERVER="127.0.0.1"
FTP_PORT="21"
FTP_USER="FTP-USER"
FTP_PASS="FTP-PASS"
SAVE_FILES=false  # Set to true or false to enable or disable saving files to disk
DESTINATION_DIR="/path/to/save/files"  # Path to the directory where files will be saved

# Mount FTP server with curlftpfs
curlftpfs -o "user=${FTP_USER}:${FTP_PASS},allow_other,default_permissions,uid=1000,gid=1000,noauto_cache" "${FTP_SERVER}:${FTP_PORT}" "${MOUNT_POINT}"

# Save files to disk if specified
if [[ "${SAVE_FILES}" == true ]]; then
    rsync -av "${MOUNT_POINT}/" "${DESTINATION_DIR}/"
    if [[ $? -eq 0 ]]; then
        echo "Files saved successfully."
    else
        echo "Failed to save files."
    fi
fi

# Unmount FTP server if SAVE_FILES is true
if [[ "${SAVE_FILES}" == true ]]; then
    umount "${MOUNT_POINT}"
fi

exit 0
