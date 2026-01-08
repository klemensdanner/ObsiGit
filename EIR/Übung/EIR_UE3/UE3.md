## Hammingabstand

- Anzahl unterschiedlicher Bits





128 Zeichen in ASCII, davon gibts 95 druckbare, der Rest sind Steuerzeichen wie delete und Pfeiltaste etc.


### Aufgaben

3.1.b)
Hexacode in der Tabelle auf Wikipedia ablesen




UTF-8 Tabelle wikipedia


3.1c) anschauen





Algorithmen zur Erstellung eines GrayCodes
Methoden: Spiegelung und Erweiterung
```
graycode



          0 0 0
          0 0 1
    0 0   0 1 1
0   0 1   0 1 0
------------------------------- Spiegelachse
1   1 1   1 1 0
    1 0   1 1 1
		  1 0 1
		  1 0 0
		  
usw.: Immer spiegeln und nach links mit 0 und 1 erweitern, Vorgang beliebig oft wiederholen. Der Gray-Code ist stetig - d.h. der Hammingabstand ist immer 1, auch im Kreis (letzter und erster Wert)
```



#### f) Verändern Sie die ASCII-Codes der Ziffern 0 .. 9 auf 2 Arten, sodass Einfachfehler bei der Übertragung erkannt werden können.

even paraty, off paraty bit

Zusatzbit, um Übertragungsfehler zu erkennen.

Bei Even parity wird eine gerade Anzahl an 1 erziehtl, bei off paraty ungerade

Wenn nach einer Übertragung plötzlich eine ungerade Anzahl ankommt, obwohl even parity verwendet wurde weiß man, dass die Übertragung fehlerhaft war



#### g) Berechnen Sie den Hammingabstand der ASCII-Codierungen von "der" und "den".


de ist bei beiden gleich. Nur r bzw. n muss verglichen werden

``

```
r 1110010

n 1101110

Hemmingabstand ist 3, weil an 3 Stellen was unterschiedliches steht.
```



![[Pasted image 20251102215533.png]]
j)

```
U+007A
Unicode Binär: 0000 0000 0111 1010

UTF-8 - Tabelle nachschauen und Bit verteilen

```


```

ü   U+00FC    in UniBinär:  0000 0000 1111 1100
in UTF-8 Binär:
1. Überlegen, wieviele Byte benötigt werden und dann mit den Vorstellen von der Tabelle auf wiki auffüllen


dann in hex umwandeln für utf8hex


```



## Hamming Code

Hamming(7,4) -- 4 Datenbits, 3 Paritybits
```









```








- [x] #eir UE3.3 / 3.5 a) d) 📅 2025-11-09 ⏫ [[EIR1_UE3_2025.pdf]] ✅ 2025-11-10



![[Pasted image 20251103155533.png]]
