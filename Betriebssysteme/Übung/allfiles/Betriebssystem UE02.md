```
  grep -Ec "\+0\.[0-9]{2}" abfahrt.txt

mehr als 1 sec Abstand auf den Sieger
  grep -Ec "\+[^0]\.[0-9]{2}" abfahrt.txt 


Wieviele sind disqualifiziert?
grep -Ec "DNF$" abfahrt.txt

Wieviele sind qualifiziert?
grep -Evc "DNF$" abfahrt.txt

Österreicher oder Italien?
grep -E "\s(A|I)\s" abfahrt.txt


Auf welchen Plätzen waren Teilnehmer zeitgleich (Zeit und Platzierung)
cut -f1 -d' ' abfahrt.txt | uniq -c | sort -nr | head -2

```



# sed


