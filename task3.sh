#!/bin/bash

host_name=$(hostname)
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")


# Getting System info
cpu_usage=$(top -bn 1 | grep "Cpu(s)" |awk '{ print $2}')
memory_usage=$(free |grep Mem | awk '{print $3/$2 * 100.0}') #used by total * 100 gives %
disk_usage=$(df -h / | awk 'NR==2 {print $5}') #-h for human readable, '/' for root
network_info=$(ifconfig)


report_file="system_usage_report.txt"
> $report_file

# Writing system info to the report file
echo "System Usage Report for $host_name - $current_datetime" >> "$report_file" #> overwrites and >> appends
echo "CPU Usage: $cpu_usage" >> "$report_file"
echo "Memory Usage: $memory_usage" >> "$report_file"
echo "Disk Usage: $disk_usage" >> "$report_file"
echo "Network Information:" >> "$report_file"
echo "$network_info" >> "$report_file"


# Displaying the report on the terminal
cat "$report_file"

echo "System usage report saved to: $report_file"
