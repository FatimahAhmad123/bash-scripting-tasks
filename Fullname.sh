#!/bin/bash  
 
#Step 1
FILE="temp.csv"          

#step 2
input_file="formattedtemp.csv"
cp "$FILE" "$input_file"

#full name
input_fileT="Tempinput.csv"



#printing all full Names
awk -F '[,]' '{print $1","$2","$3","$4","$1" "$2}' < ./temp.csv > "$input_file"
sed 1i"First Name,Last Name,Email,Formatted Phone no,Full Name,Email Domain" $input_file > $input_fileT
awk 'NR!=2' $input_fileT > $input_file

# Extract the email domains and create a temporary file
awk -F ',' '{split($3, emailParts, "@"); print $0 "," emailParts[2]}' "$input_file" > "$input_file.tmp"

# Replace the header with "Email,Email Domain"
sed -i '1s/.*/First Name,Last Name,Email,Formatted Phone no,Full Name,Email Domain/' "$input_file.tmp"

# Rename the temporary file to the final output file
mv "$input_file.tmp" "$input_file"
