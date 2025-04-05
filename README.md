# AVR Miner

This repository provides instructions for setting up and running the AVR_Miner.py script in the background with automatic restarts if it crashes. It also includes guidance on how to view logs while the script is running.

## Table of Contents

- Prerequisites
- Running the Script
  - Method 1: Using a Shell Script
  - Method 2: Using systemd (Linux)
- Viewing Logs
  - If Using a Shell Script
  - If Using systemd
- Additional Tips

## Prerequisites

- Python 3.x installed on your system.
- Basic knowledge of using the terminal or command line.
- (Optional) systemd for managing services on Linux.

## Running the Script

### Method 1: Using a Shell Script

1. Create a Shell Script: Create a new shell script file, for example, run_avr_miner.sh.

   nano run_avr_miner.sh

2. Add the Following Code: This script will run your Python file in a loop, restarting it if it crashes.

   #!/bin/bash

   while true; do
       python3 /path/to/AVR_Miner.py
       echo "AVR_Miner.py crashed with exit code $?. Restarting..." >&2
       sleep 1  # Optional: wait for 1 second before restarting
   done

   Make sure to replace /path/to/AVR_Miner.py with the actual path to your Python script.

3. Make the Script Executable:

   chmod +x run_avr_miner.sh

4. Run the Script in the Background:

   You can use nohup to run the script in the background and redirect output to a file:

   nohup ./run_avr_miner.sh > avr_miner.log 2>&1 &

### Method 2: Using systemd (Linux)

If you're on a Linux system, you can create a systemd service to manage your script.

1. Create a Service File:

   sudo nano /etc/systemd/system/avr_miner.service

2. Add the Following Configuration:

   [Unit]
   Description=AVR Miner Service
   After=network.target

   [Service]
   ExecStart=/usr/bin/python3 /path/to/AVR_Miner.py
   Restart=always
   User=your_username
   WorkingDirectory=/path/to/working_directory
   StandardOutput=file:/path/to/avr_miner.log
   StandardError=file:/path/to/avr_miner_error.log

   [Install]
   WantedBy=multi-user.target

   Make sure to replace /path/to/AVR_Miner.py, your_username, and the log file paths with the appropriate values.

3. Reload the systemd Daemon:

   sudo systemctl daemon-reload

4. Start the Service:

   sudo systemctl start avr_miner.service

5. Enable the Service to Start on Boot:

   sudo systemctl enable avr_miner.service

6. Check the Status:

   You can check the status of your service with:

   sudo systemctl status avr_miner.service

## Viewing Logs

### If Using a Shell Script

If you used the shell script method and redirected output to a log file (e.g., avr_miner.log), you can view the log file in real-time using the tail command:

1. Open a Terminal.
2. Use the tail Command:

   tail -f avr_miner.log

### If Using systemd

If you set up a systemd service, you can view the logs using the journalctl command:

1. Open a Terminal.
2. Use the journalctl Command:

   To view the logs for your specific service, use:

   sudo journalctl -u avr_miner.service -f

## Additional Tips

- Filtering Logs: If you want to filter logs by time or other criteria, journalctl provides various options. For example, you can view logs from the last hour:

   sudo journalctl -u avr_miner.service --since "1 hour ago"

- Log Rotation: If your script generates a lot of output, consider implementing log rotation to manage log file sizes. This can be done using tools like logrotate.

- Viewing Previous Logs: If you want to view previous logs (not just the latest), you can simply run:

   sudo journalctl -u avr_miner.service
