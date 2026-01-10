# 1) Einnahmen / Ausgaben

#### Lösungsidee

Variablen werden deklariert. Mittels Schleife werden solange Werte eingelesen, bis der eingelesene Wert gleich 0 ist. Alle Werte werden in der Schleife überprüft ob sie größer als 0 sind oder nicht und dann zu den jeweiligen Variablen addiert. Anschließend werden die Werte der Variablen ausgegeben.
#### a) Ablaufdiagramm

![[Pasted image 20251012194549.png|500]]

<div class="page-break" style="page-break-before: always;"></div>

#### b) Pseudocode

```c
value := 1
totalpos := 0
totalneg:= 0

while value ≠ 0 do
	read(↑value)
	
	if value > 0 then
		totalpos = totalpos + value
	else
		totalneg = totalneg + value
	end if
end while

write(↓"Einnahmen: ", totalpos)
write(↓"Ausgaben: ", totalneg)
write(↓"Gesamt: ", (totalpos+totalneg)) //totalneg bereits negativ
```

<div class="page-break" style="page-break-before: always;"></div>

# 2) Mittlerer Wert

#### Lösungsidee

3 Variablen werden initialisiert. Anschließend werden drei Werte eingelesen und den Variablen zugeordnet. Durch if-Abfragen und Vergleichen der Werte der Variablen wird der mittlere Wert ermittelt und gleich ausgegeben.

#### a) Ablaufdiagramm
![[Pasted image 20251013202744.png|500]]

<div class="page-break" style="page-break-before: always;"></div>


#### b) Pseudocode
```c
a := 0
b := 0
c := 0

read(↑a, b, c)

//1) dry test point

if (b<=a<=c) or (c<=a<=b) then
	//2) dry test point
	write(a)
else
	if (a<=b<=c) or (c<=b<=a) then
		//3) dry test point
		write(b)
	else
		write(c)
	end if
end if
```

#### c) Schreibtischtest

Beispiel der Eingabe: 3, 7, 5    // geänderte Reihenfolge für spannenden Schreibtischtest

| Stelle |  a  |  b  |  c  | (b<=a<=c) or (c<=a<=b) | (a<=b<=c) or (c<=b<=a) | output |
| :----: | :-: | :-: | :-: | :--------------------: | :--------------------: | :----: |
|   1    |  3  |  7  |  5  |         false          |         false          |   -    |
|   2    |  3  |  7  |  5  |         false          |         false          |   -    |
|   3    |  3  |  7  |  5  |         false          |         false          | --> 5  |

<div class="page-break" style="page-break-before: always;"></div>



# 2) Mittelwert - Angabe anders verstanden

#### Lösungsidee:

Variablen werden deklariert. Mittels for-Schleife werden drei Zahlen eingelesen nacheinander aufaddiert. Durch Division mit der Zahl 3 wird das Mittel berechnet. Das Mittel wird ausgegeben.

#### a) Ablaufdiagramm

![[Pasted image 20251012194722.png|400]]
<div class="page-break" style="page-break-before: always;"></div>

#### b) Pseudocode
```c
//Mittelwert von 3 Zahlen

//Initialisierung
input := 0
sum := 0
mean := 0

for i := 1 to 3 do
	read(↑input)
	sum = sum + input
end for

mean = sum/3
write(↓mean)
```


#### c) Schreibtischtest, Input 5, 3, 7

| Stelle | input | sum |  mean   |
| :----: | :---: | :-: | :-----: |
|   1    |   5   |  0  |    0    |
|   2    |   5   |  5  |    0    |
|   1    |   3   |  5  |    0    |
|   2    |   3   |  8  |    0    |
|   1    |   7   |  8  |    0    |
|   2    |   7   | 15  |    0    |
|   3    |   7   | 15  | **5**** |
<div class="page-break" style="page-break-before: always;"></div>

# 3) Diskussion: Darstellungsformen

In den Aufgaben 1 und 2 wurden ein Ablaufdiagramm und Pseudocode verwendet. Des Weiteren wurde ein Schreibtischtest zum Testen eines Algorithmus verwendet. 

#### Ablaufdiagramm
Ein Ablaufdiagramm wird als sehr leicht leserlich und verständlich beschrieben. Diese Meinung teile ich grundsätzlich, jedoch bedarf es auch bei dieser Darstellungsform an einer gewissen Gewöhnung. Ich kann mir vorstellen, dass ein Ablaufdiagramm ein wertvolles Tool für die Planung einfacher bis mittelschwerer Algorithmen sein kann, wenn man sich an die Notation gewöhnt.
Für Personen ohne Programmiererfahrung ist es vermutlich einfacher zu verstehen als Pseudocode. Es ist also das Mittel der Wahl, wenn die Logik eines Algorithmus solchen Menschen nähergebracht werden soll.

#### Pseudocode
Da ich schon etwas Programmiererfahrung sammeln konnte, allerdings noch kein Ablaufdiagramm verwendet habe, war die Darstellung als Pseudocode für mich intuitiver. Pseudocode ist leicht anpassbar und leicht in jedem Texteditor zu erstellen, was möglicherweise einen dynamischeren Workflow ermöglicht.
Pseudocode ist außerdem näher zu Code einer Programmiersprache, wodurch die Umwandlung in der Regel schneller gelingt.


