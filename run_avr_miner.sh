#!/bin/bash

while true; do
    python3 /path/to/AVR_Miner.py
    echo "AVR_Miner.py crashed with exit code $?. Restarting..." >&2
    sleep 1  # Optional: wait for 1 second before restarting
done