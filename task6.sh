#!/bin/bash

# Step 1: Check if the CSV file exists and is readable
FILE="temp.csv"

if [ ! -f "$FILE" ] || [ ! -r "$FILE" ]; then
    echo "Error: CSV file '$FILE' does not exist or is not readable."
    exit 1
fi

# Creating a temporary file for formatted.csv
input_file="formatted.csv"

input_file_temp="Temp_input.csv"

# Printing full Names
awk -F '[,]' '{print $1","$2","$3","$4","$1" "$2}' ./temp.csv > "$input_file"

# Email Domains
awk -F ',' '{split($3, emailParts, "@"); print $0 "," emailParts[2]}' "$input_file" > "$input_file_temp" #emailParts[2] contains part of email after @
sed -i '1s/.*/First Name,Last Name,Email,Formatted Phone no,Full Name,Email Domain/' "$input_file_temp"

# Copying the temporary file to the final output file
cp "$input_file_temp" "$input_file"

#sorting
( sed 1q; sort -k 1,1n ) < $input_file > $input_file_temp # 1q for reading after 1st line, extracting header
# -k specifies range of columns to sort, in our case column 1
cp "$input_file_temp" "$input_file"


sed -r 's/([0-9]{3}) ([0-9]{3}-[0-9]{4})/(\1)\2/' $input_file_temp > $input_file # -r for extended regex,
sed -i 1d $input_file_temp # deletes first line (header)

#non matching entries in warninglog
warninglog="warninglog.log"
sed -En '/([0-9]{3}) ([0-9]{3}-[0-9]{4})/!p' $input_file_temp > $warninglog 


# Counting lines in the CSV file
total_rows=0
while read -r line; do
total_rows=$((total_rows + 1))
done < "$FILE"
echo "Total Rows in Input File: $total_rows"

# Toatal Formatted Phone nos
formatted_phone_nos=$(sed -nE '/\([0-9]{3}\)[0-9]{3}-[0-9]{4}/p' "$input_file" | wc -l)
echo "Total Formatted Phone Numbers: $formatted_phone_nos"

# Total non formatted phone nos
non_formatted_phone_nos=$(sed -En '/([0-9]{3}) ([0-9]{3}-[0-9]{4})/!p' "$input_file_temp" | wc -l) # -n for not prining output
echo "Total Non-Formatted Phone Numbers: $non_formatted_phone_nos"


# most common email
awk 'BEGIN{ 
FS=","
count=0
}
{
email_dom[$6]++ 
if (email_dom[$6]>count)
{
	count=email_dom[$6]
	email_domains=$6
}
}
END{
print email_domains
}' $input_file
