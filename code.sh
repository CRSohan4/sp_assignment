#!/bin/bash
counter=1
echo "[INFO] Processing file..."

for var in "$@"
do
echo ""
echo "[INFO] Processing file $var"

# remove footnotes (FN:)
pattern="FN:"
sed "/$pattern/d" $var > temp.txt
mv temp.txt $var

while IFS= read -r line;
do
	# Capitalize first word of the sentence.
	if [[ $line != "" ]]; then
		sed "$counter s/$line/${line^}/" $var > temp.txt
		mv temp.txt $var
	fi
	counter=`expr $counter + 1`
done < $var

counters=1
while IFS= read -r line;
do
	if [[ "$line" == "Wh"* || "$line" == "Can"* || "$line" == "Could"* || "$line" == "Will"* || "$line" == "Would"* || "$line" == "How"* ]]; then
		echo "enter"		
		dot_str="."
		question_str="?"

		sed "$counters s/[.]/${question_str}/" $var > temp.txt
		mv temp.txt $var
	fi
	counters=`expr $counters + 1`
done < $var

done
echo ""
echo "[SUCCESS] File Processing Successfully"

