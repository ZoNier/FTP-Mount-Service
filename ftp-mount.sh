#!/bin/bash

# Set variables
MOUNT_POINT="/path/to/mount/"
FTP_SERVER="127.0.0.1"
FTP_PORT="21"
FTP_USER="FTP-USER"
FTP_PASS="FTP-PASS"
SAVE_FILES=false  # Set to true or false to enable or disable saving files to disk
DESTINATION_DIR="/path/to/save/files"  # Path to the directory where files will be saved

# Check if mount point exists and is not already mounted
if [[ ! -d "${MOUNT_POINT}" ]] || mountpoint -q "${MOUNT_POINT}"; then
    echo "FTP mount point is already mounted or does not exist."
    exit 1
fi

# Check if FTP server is reachable
if ! nc -z "${FTP_SERVER}" "${FTP_PORT}" > /dev/null 2>&1; then
    echo "FTP server is not reachable."
    exit 1
fi

# Mount FTP server with curlftpfs
if ! curlftpfs -o "user=${FTP_USER}:${FTP_PASS},allow_other,default_permissions,uid=1000,gid=1000,noauto_cache" "${FTP_SERVER}:${FTP_PORT}" "${MOUNT_POINT}"; then
    echo "Failed to mount FTP server."
    exit 1
fi

# Update systemd mount unit
if ! systemctl is-active --quiet ftp-mount; then
    echo "FTP mount unit is not active, activating..."
    systemctl start ftp-mount
fi

# Wait for mount to complete
for ((i=1; i<=10; i++)); do
    if mountpoint -q "${MOUNT_POINT}"; then
        echo "FTP mount completed successfully."
        break
    fi
    echo "FTP mount is still in progress, waiting..."
    sleep 5
done

if ! mountpoint -q "${MOUNT_POINT}"; then
    echo "FTP mount timed out."
    exit 1
fi

# Save files to disk if specified
if [[ "${SAVE_FILES}" == true ]]; then
    echo "Saving files from ${MOUNT_POINT} to ${DESTINATION_DIR}..."
    rsync -av "${MOUNT_POINT}/" "${DESTINATION_DIR}/"
    if [[ $? -eq 0 ]]; then
        echo "Files saved successfully."
    else
        echo "Failed to save files."
    fi
fi

# Unmount FTP server if SAVE_FILES is true
if [[ "${SAVE_FILES}" == true ]]; then
    if umount "${MOUNT_POINT}"; then
        echo "FTP server unmounted successfully."
    else
        echo "Failed to unmount FTP server."
        exit 1
    fi
fi

exit 0
