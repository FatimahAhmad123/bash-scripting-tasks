#!/bin/bash  
 
#Step 1
FILE="temp.csv"          

if [ ! -f "$FILE" ] || [ ! -r "$FILE" ]; then #-f for checking if file exists, -r for if is readable
    echo "Error: CSV file '$FILE' does not exist or is not readable."
    exit 1
fi
#step 2
input_file="formatted.csv"
cp "$FILE" "$input_file"

#full name
Var1="Full Name"
echo $Var1 >>formatted.csv
awk -F '[,]' '{print $1","$2","$3","$4","$1" "$2}' < ./temp.csv > "$input_file"
# temp_csv="temporary.csv"
# sort $temp_csv > $input_file
# cp "$temp_csv" "$input_file"

# total_rows=0
# invalid_phone_rows=0

# # Create a separate file for logging warnings
# warnings_file="warnings.log"
# > "$warnings_file"

# # Counting lines in the CSV file
# while IFS=$'\t' read -r first_name last_name email phone_number; do
# total_rows=$((total_rows + 1))
# done < "$FILE"

# echo "Total Rows in Input File: $total_rows"
# 324 321-2324 #\d{3}\s\d{3}-\d{4}