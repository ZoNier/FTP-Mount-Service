# FTP Mount Service
This service automates the process of mounting an FTP server using `curlftpfs` and optionally saving files to disk using `rsync`. It can be used to mount an FTP server and perform additional actions as needed.

## Prerequisites
- Linux-based operating system with systemd
- `curlftpfs` and `rsync` packages installed

## Installation
1. Clone this repository or download the `ftp-mount.sh` script.
   ```bash
   git clone https://github.com/ZoNier/ftp-mount-service.git
   ```
2. Copy the `ftp-mount.sh` script to the desired location (e.g., `/opt/`).
   ```bash
   cp ftp-mount.sh /opt/
   ```
3. Customize the script by modifying the variables in the `ftp-mount.sh` file according to your FTP server settings and desired options.
   - `MOUNT_POINT`: The directory where the FTP server will be mounted.
   - `FTP_SERVER`: The IP address or hostname of the FTP server.
   - `FTP_PORT`: The port number of the FTP server.
   - `FTP_USER`: The FTP username.
   - `FTP_PASS`: The FTP password.
   - `SAVE_FILES`: Set to `true` or `false` to enable or disable saving files to disk.
   - `DESTINATION_DIR`: The path to the directory where files will be saved (applicable only if `SAVE_FILES` is set to `true`).
4. Copy the `ftp-mount.service` file to the systemd service directory.
   ```bash
   sudo cp ftp-mount.service /etc/systemd/system/
   ```
5. Reload the systemd daemon.
   ```bash
   sudo systemctl daemon-reload
   ```
6. Start the FTP Mount Service.
   ```bash
   sudo systemctl start ftp-mount.service
   ```
7. (Optional) Enable automatic startup of the FTP Mount Service on system boot.
   ```bash
   sudo systemctl enable ftp-mount.service
   ```

## Usage
The FTP Mount Service will automatically mount the FTP server specified in the `ftp-mount.sh` script and perform additional actions according to the configuration.
By default, the service will attempt to mount the FTP server and wait for the mount process to complete. If the mount is successful, it will print a success message and proceed to the next steps.
If the `SAVE_FILES` variable is set to `true`, the service will save files from the mounted FTP server to the specified `DESTINATION_DIR` using `rsync`.
If the `SAVE_FILES` variable is set to `false`, the service will skip the file-saving step and directly unmount the FTP server.
You can monitor the service logs using the following command:
```bash
sudo journalctl -u ftp-mount.service
```

## License
This project is licensed under the [GNU General Public License](LICENSE).
