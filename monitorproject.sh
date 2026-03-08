#!/bin/bash

DATE=$(date)

CPU=$(top -bn1 | grep "Cpu" | awk '{print $2 + $4}')
MEMORY=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
DISK=$(df / | awk 'END {print $5}' | sed 's/%//')

echo "-----------------------------"
echo "System Monitoring Report"
echo "Date: $DATE"
echo "CPU Usage: $CPU%"
echo "Memory Usage: $MEMORY%"
echo "Disk Usage: $DISK%"
echo "-----------------------------"

if (( $(echo "$CPU > 80" | bc -l) )); then
echo "⚠️ High CPU Usage!"
fi

if (( $(echo "$MEMORY > 80" | bc -l) )); then
echo "⚠️ High Memory Usage!"
fi

if [ $DISK -gt 80 ]; then
echo "⚠️ High Disk Usage!"
fi
