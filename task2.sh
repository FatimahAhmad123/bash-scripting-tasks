#!/bin/bash

search_directory="/home/nabeel/Desktop/mydirectory"

keyword="Fatimah"

output_file="output.txt"
> "$output_file"


#for file in "$search_directory"/*.txt; do
    # if [ -f "$file" ]; then #checks if directory, regular file or text file and not a directory
        grep -nHri "$keyword" "$search_directory"/*.txt >>"$output_file"
    #fi
#done

cat "$output_file"

echo "Results are stored in $output_file."

