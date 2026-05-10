
#### Speicherlayout

### keine Abstraktion der RAM Adressen



### Lösungen dafür: Adressräume + dynamic Relocation
Base Registier (Startadresse)
Limit Register (Programmlänge)
Viel Rechenaufwand, aufwendig

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
Jedes bit ist einer Allocation Unit (Adressierbare Speichereinheit) zugeordnet
0 -- frei
1 -- belegt

Je Kleiner die Allocation unit, desto größer wird die Bitmap (eh klar, man muss mehr AUs referenzieren)


![[Pasted image 20260510165924.png|400]]

### Linked Lists

2 verschiedene Knotentypen (Process, Hole)
Die Knoten speichern Folgendes:
- Typ
	- P - Process: Prozess belegt hier
	- H - Hole: Block aus freiem Speicher
- Startadresse
- Länge des Blocks

Länge der Liste hängt von der Anzahl der Prozesse und der freien Blöcke ab.

Neuen Prozess in den Speicher laden:
- first fit: erster freier Block mit ausreichend Größe wird ausgewählt
- best fit: Durchlaufen der Liste und verwenden des kleinsten freien und ausreichenden Platzes

first fit: schneller, größere Lücken
best fit: langsamer, kleinere Lücken
### Virtual Memory
Jeder Prozess bekommt einen eigenen virtuellen Adressraum. Die Gesamtheit der virtuellen Adressen kann die Anzahl der physischen Adressen übersteigen - manche Adressen werden also ausgelagert auf die SSD/HDD.

Programme referenzieren immer virtuelle Adressen (vom Compiler so generiert).
Die MMU (Memory Management Unit als Teil der CPU) mappt virtuelle auf physische Adressen. Sie stellt fest, ob sich das adressierte Page Frame im Hauptspeicher befindet oder nicht. Wenn nicht, wird ein Page Fault (interrupt) ausgelöst.
Paging:
- Laden von benötigten Pages von der Festplatte in den Arbeitsspeicher
- Laden vom Arbeitsspeicher auch die Festplatte, wenn Page Frame nicht benötigt wird
- Aufgabe des OS



------ yesss siehe hier:
Page frame ist einfach ein z.B. 4KB Speicherblock, der sich optimalerweise im RAM befinden kann. Eine virtuelle vom compiler generierte Adresse beinhaltet eine Page Number (virtuell) und einen offset, welcher die Lage der genauen Speicheradresse innerhalb des Pageframes angibt.
Die Pagetable hat für die meisten virtuellen Page Number die passende physische Page frame number (außer dieses page ist nicht im RAM, dann wird ein page fault interrupt ausgelöst und das OS kopiert den page frame in den RAM, updatet die page table und kehrt zum Aufruf zurück. - jetzt gibts auch dafür die richtige page frame number. AND btw dieser Vorgang und auch das Auslagern eines Pages aus dem RAM in die SSD/HDD nennt sich Paging)
Die page number wird einfach mit der page frame number ausgetauscht, der offset bleibt gleich und fertig ist die physische Adresse im RAM

In der Tabelle wird mehr gespeichert als die Page Frame Number:
- Present/Absent Bit (0 - nicht gemappt - page Fault!, 1 -- gemappt, es kann zugegriffen werden)
- Protection: Lese- oder Schreibzugriffe erlaubt
- Modified: wenn bereits eine Kopie auf der SSD sich befindet, die nicht modified wurde, kann man das page frame freigeben, weil sich die gültige Version eh auf der SSD befindet.
- Referenced: was referenziert ist, wird evtl. bald benötigt - eher nicht freigeben
Wichtig: Keine Informationen zum Speicherort auf der Festplatte.

## Multilevel Page Tables
Page Tables die alle Page Frame numbers speichern werden sehr lang werden, obwohl meistens nur ein kleiner Teil davon genutzt wird.
Daher verwendet man ein Multilevel System. Dabei wird die adresse logisch unterteilt. bei 32 Bit z.B. erste 10 Bit sind für Layer 1, zweite 10 Bit sind Index in der zweiten Tabelle, letzten 12 Bits sind der Offset.

## Ersetzungsstrategien

### NRU - Not Recently Used
Ein page frame heißt **referenziert**, wenn: in letzter Zeit auf das frame zugegriffen wird. periodisch wird das refereced bit wieder auf 0 gesetzt.
Ein page frame heißt **modified**, wenn: das frame vor dem Austauschen mit einem anderen Frame auf die Festplatte gesichert werden muss. Es ist gesetzt, wenn das frame noch keine Kopie auf der Festplatte hat, oder wenn es im RAM verändert wurde.

Auf der Suche nach einem austauschbaren frame wird das OS so vorgehen und frames in Klassen einteilen:
- Klasse 0: nicht referenziert, nicht modifiziert
- Klasse 1: nicht referenziert, modifiziert
- Klasse 2: referenziert, nicht modifiziert
- Klasse 3: referenziert, modifiziert

Es wird die niedrigen Klassen zuerst wählen und austauschen.