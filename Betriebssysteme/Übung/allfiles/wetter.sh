#!/bin/sh



if [ $# -ne 2 ]
then
	echo "wrong numbers of arguments"
	exit 1
fi

if [ ! -f $2 ] # $2 ist das zweite Argument
then
	echo "File not found"
	exit 1
fi

R=`grep -Ec "^$1" $2` # grep syntax anschauen
# wenn im R 0 drin steht, dann kommt das Ereignis nicht vor

if [ $R -eq 0 ]
then
	echo "weather event $1 not found"
	exit 1
fi

######### alles gecheckt jawoi

grep -E "^$1" $2 > tmp


###############

echo "$1 gab es an folgenden Orten" > resultate

while read line
do
	bezirk=`echo $line | cut -f2 -d'(' | cut -f1 -d')'`
	ort=`echo $line | sed -E "s/^$1 in //g" | sed -E 's/ \(.+//g'` # die einfachen unterdrücken variablenauswertung, d.h. '$bezirk' ist dann direkt $bezirk

	echo "$ort im bezirk $bezirk " >> resultate

done < tmp













