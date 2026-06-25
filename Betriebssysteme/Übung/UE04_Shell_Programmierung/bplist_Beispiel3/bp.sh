#!/bin/sh

if [ ! -f bplist ]
then
	echo "bplist is not a file or doesnt exist"
	exit 1
fi

SAVEIFS=$IFS

IFS=";"

while read institution personen
do
	IFS="," # for-schleife kann über variablen, listen, etc iterieren
	for name in $personen # $ braucht man für den Zugriff auf die Variable
	do
		echo "$name"
		VorName=`echo $name | cut -d " " -f1`
		NachName=`echo $name | cut -d " " -f2`
		echo "$NachName $Vorname" >> leute
	done
	IFS=";"

done < bplist

IFS=$SAVEIFS
# irgendwie gibt es nur den Nachnamen aus
