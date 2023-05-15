# FTP Mount Service

This is the README file for the `ftp-mount.service` script.

## Description

The `ftp-mount.service` script is a systemd service unit that mounts an FTP server using `curlftpfs`. It allows you to access files on the FTP server as if they were stored locally. Additionally, it provides the option to save files from the mounted FTP server to a specified destination directory on your system.

## Prerequisites

Before using this script, make sure you have the following prerequisites:

- Systemd (for managing services)
- Bash (for running the script)
- `curlftpfs` (for mounting the FTP server)
- `rsync` (optional - for saving files to disk)

## Installation

To install and configure the `ftp-mount.service` script, follow these steps:

1. Clone the repository or download the `ftp-mount.service` and `ftp-mount.sh` files to a directory of your choice (e.g., `/opt/ftp-mount`).
2. Open the `ftp-mount.service` file and modify the `Description` and other parameters if needed.
3. Open the `ftp-mount.sh` file and set the appropriate values for the variables at the beginning of the script:

    - `MOUNT_POINT`: The local directory where the FTP server will be mounted.
    - `FTP_SERVER`: The IP address or hostname of the FTP server.
    - `FTP_PORT`: The port number of the FTP server.
    - `FTP_USER`: The FTP username.
    - `FTP_PASS`: The FTP password.
    - `SAVE_FILES`: Set to `true` or `false` to enable or disable saving files to disk.
    - `DESTINATION_DIR`: The directory where files will be saved if `SAVE_FILES` is set to `true`.

4. Save the changes.

## Usage

To use the `ftp-mount.service` script, follow these steps:

1. Make sure the `ftp-mount.service` and `ftp-mount.sh` files are in the same directory (e.g., `/opt/ftp-mount`).
2. Open a terminal and navigate to the directory where the files are located.
3. Run the following command to start the FTP mount service:

   ```bash
   sudo systemctl start ftp-mount
   ```

   This will mount the FTP server using the specified parameters in the `ftp-mount.sh` script.

4. Wait for the mount process to complete. The script will periodically check if the mount is successful. If it fails, an error message will be displayed.

5. If the `SAVE_FILES` variable is set to `true`, the script will save files from the mounted FTP server to the specified `DESTINATION_DIR`. This can be useful for backing up or synchronizing files between the FTP server and your local system. If the save operation is successful, a success message will be displayed. If it fails, an error message will be displayed.

6. To unmount the FTP server, run the following command:

   ```bash
   sudo systemctl stop ftp-mount
   ```

   This will unmount the FTP server and clean up the mount point.

## Configuration

You can customize the behavior of the ftp-mount.service script by modifying the following parameters in the ftp-mount.sh script:

- `MOUNT_POINT`: The local directory where the FTP server will be mounted. Set this variable to the desired mount point path on your system.
- `FTP_SERVER`: The IP address or hostname of the FTP server. Replace the default value with the IP address or hostname of your FTP server.
- `FTP_PORT`: The port number of the FTP server. Modify this variable if your FTP server uses a different port. The default value is set to 20021.
- `FTP_USER`: The FTP username. Replace the default value with the username required to access your FTP server.
- `FTP_PASS`: The FTP password. Set this variable to the password associated with the FTP username specified in the FTP_USER variable.
- `SAVE_FILES`: Set this variable to true or false to enable or disable saving files to disk. If set to true, files will be saved from the mounted FTP server to the directory specified in the - - - - `DESTINATION_DIR` variable. If set to false, files will not be saved locally. The default value is true.
- `DESTINATION_DIR`: The directory where files will be saved if the SAVE_FILES variable is set to true. Set this variable to the desired destination directory path on your system.

After modifying the variables, save the changes to the ftp-mount.sh script before running the ftp-mount.service script.
