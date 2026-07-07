#!/bin/bash

while read skigebiet # einmal read aufrufen liest immer genau eine zeile
do
	read orte
	read lifte
	read preis
	read leerzeile

	orte_short=`echo $orte | cut -d':' -f2`
	anz_lifte=`echo $lifte | cut -d':' -f2`
	preis_short=`echo $preis | cut -d':' -f2`

	echo "${skigebiet}; ${anz_lifte}; ${preis_short}" >> schigebiet_2
	echo "$orte_short" >> schigebiet_2



done < schi_gebiet
