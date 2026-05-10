
#### Speicherlayout

### keine Abstraktion der RAM Adressen



### Lösungen dafür: Adressräume + dynamic Relocation
Base Registier
Limit Register


### Swapping
Funktion:
Probleme:


### malloc
Was ist wenn ein Prozess mehr Speicher braucht und memory allocaten will?
Datensegment kann also wachsen und schrumpfen
Wenn der also wächst und über ihm kein Platz mehr ist --> umsiedeln
--> schlecht für Performance
Daher kann man Lücken zwischen den Prozessen lassen. (diese Lücken werden für den vorherigen Prozess reserviert)
Wenn dieser Speicher wieder ausgeht --> umkopieren auf freien Platz, swappen und warten bis Speicher frei ist oder out of memory exception

Dieses Managen muss vom Betriebssystem gemacht werden.

Wie weiß man aber wo wie viel Speicher frei ist?
Wieviel Speicher freigehalten werden sollte (zwischen Prozessen)

Strategien: Bitmaps und linked Lists


### Bitmaps



### Linked Lists
