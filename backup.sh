#!/bin/bash
DIR="/home/backup/"

take_backup()
{
	echo " "
	for file in ./*.c
	do
		echo " "
		echo "[INFO] Processing file $file ..."
		file_basename=$(basename $file)

		if [ ! -f "$DIR$file_basename" ]; then
			cp $file $DIR
			echo "[INFO] $file_basename file had no previous copy and is now backed-up."
		else
			echo "[INFO] $file_basename file is already present"

			if cmp -s "$file" "$DIR$file_basename"; then
				echo "[INFO] $file_basename file has not changed."
			else
				echo "[INFO] File has some changes which are not backed up. Backing up now..."
				cp -f $file $DIR
				echo "[INFO] $file_basename file has been updated."
			fi
		fi
	done
}

if [ -d "$DIR" ]; then
	echo "[INFO] Backup directory already present."
	take_backup
else
	echo "Directory is not present, would you like to create one? (yes/no)"
	read choice

	if [ $choice == "y" ] || [ $choice == "yes" ] || [ $choice == "Y" ] || [ $choice == "YES" ]; then
		mkdir $DIR
		echo "[INFO] backup directory created successfully."

		echo "[INFO] Backing up .c files."
		take_backup
	elif [ $choice == "n" ] || [ $choice == "no" ] || [ $choice == "N" ] || [ $choice == "NO" ]; then
		echo "[INFO] No directory was created. Exiting the program"
	else
		echo "[ERROR] Invalid response was entered. Exiting the program"
	fi
fi
