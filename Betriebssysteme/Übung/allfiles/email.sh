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

# dos2unixen
which dos2unix 2> /dev/null
if [ $? -ne 0 ]
then
	echo "Installing dos2unix, please enter password"
	sudo apt update
	sudo apt install -y dos2unix
fi




while read mat nachname vorname rest # es wird immer eine line gelesen.
do
	email="S${mat}@students.fh-hagenberg.at"
	email_alias="$vorname.$nachname@students.fh-hagenberg.at"
	echo "$mat $email $email_alias $nachname $vorname $rest" >> stud_email.txt # > ist Ausgabenumleitung - legt neues file an und überschreibt Inhalt. >> appendet.
done < $1

cat stud_email.txt












