#!/bin/bash
log_file="/home/nabeel/Desktop/samplelog.log"

count=0

while true; do # infinite loop

    # Checking if new lines added
    current_count=$(wc -l < "$log_file")


    if [ "$current_count" -gt "$count" ]; then

        new_lines=$((current_count - count))
        tail -n "$new_lines" "$log_file" | while read line || [ -n "$line" ]; do # checks if line is not empty
            if [[ $line == *error* ]]; then
               echo "Detected 'error' in line: $line"
            elif [[ $line == *warning* ]]; then
               echo "Detected 'warning' in line: $line"
            fi
            done
            # Update the line count
            count="$current_count"
    fi
done
