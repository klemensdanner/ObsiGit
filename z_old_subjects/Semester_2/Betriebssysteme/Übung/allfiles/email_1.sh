#!/bin/sh

if [ $# -eq 0 ]
then
	echo "Wrong number of arguments"
	exit 1
fi

if [ ! -f $1 ] # proofs if $1 (the first argument) is a file
then
	echo "$1 is not a file"
	exit 1
fi


#while read line
#do
#	echo $line
#done < $1


rm stud_email.txt 2> /dev/null # lenkt errorausgabe um in ein file

while read mat name # es wird immer eine line gelesen.
		    # mat ist das erste Wort, der rest kommt in name
do
	email="S${mat}@students.fh-hagenberg.at"
	echo "$mat $email $name" >> stud_email.txt # > ist Ausgabenumleitung - legt neues file an und überschreibt Inhalt. >> appendet.
done < $1

cat stud_email.txt












