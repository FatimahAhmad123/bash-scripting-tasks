FILE="temp.csv"          

#step 2
input_file="email.csv"
cp "$FILE" "$input_file"
input_fileT="emailTemp.csv"

warninglog="warninglog.log"
sed -r 's/([0-9]{3}) ([0-9]{3}-[0-9]{4})/(\1)\2/g' $FILE > $input_file
sed '/[0-9]\{10\}/!d;/[0-9]\{9\}/d' $input_file > $warninglog
# Extract the email domains and create a temporary file
awk -F ',' '{split($3, emailParts, "@"); print $0 "," emailParts[2]}' "$FILE" > "$input_file.tmp"

# Replace the header with "Email,Email Domain"
sed -i '1s/.*/First Name,Last Name,Email,Formatted Phone no,Full Name,Email Domain/' "$input_file.tmp"

# Rename the temporary file to the final output file
mv "$input_file.tmp" "$input_file"
