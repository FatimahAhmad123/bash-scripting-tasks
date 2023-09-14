#Step 1
FILE="temp.csv"          

#step 2
input_file="phone.csv"
cp "$FILE" "$input_file"


input_fileT="phonetemp.csv"
warninglog="warninglog.log"

sed -r 's/([0-9]{3}) ([0-9]{3}-[0-9]{4})/(\1)\2/g' $FILE > $input_file
