# Speichermedien
## HDDs
- Speicherung auf dünnen Magnetscheiben, die übereinander liegen
- Ein einzelner Kreissektor auf einer Scheibe wird Sektor (512 Bytes) genannt
- Sektoren können mit Sektoradressen referenziert werden

![[Pasted image 20260507170609.png|250]]

Über einen beweglichen Lese- und Schreibekopf wird auf die Daten zugegriffen.
Mehrere Sektoren werden auf Blöcke / Cluster (unter Windows) zusammengefasst.
Dadurch werden die Bewegungen des Lesekopfes reduziert (weil größere Dateien nebeneinander gespeichert werden)

## SSD

- hat einen Controller und einen Cache
- NAND-Flash Zellen
- Diese NAND Zellen werden zu Pages gruppiert (4KB)
- Pages werden zu Blöcken gruppiert (512KB)
- Blöcke werden zu Planes gruppiert (1 Plane = 1024 Blocks = 512 MB)
- 4 Planes sind 1 Die (2gb speicher)
- 2 Dies sind ein Flash Package

Das Beschreiben läuft auf Page und Blockebene. 
Es können einzelne Pages geschrieben werden, aber nur ganze Blöcke gelöscht
--> Lösung ist Umkopieren innerhalb des Blockes, wenn Dateien bearbeitet werden (können nicht einfach überschrieben werden)

Dead pages können gecleared werden. - in neuen Block kopieren und alten Block clearen


Wear Levelling
- NAND Zellen haben begrenzte Lebensdauer
- Neue Dateien werden in die am wenigsten beanspruchten Blöcke geschrieben
- Tabelle wird für Zuordnung verwendet (äußere Blockadressen, mit denen das Betriebssystem ansteuert zu echten physischen Speicheradressen)
- d.h. Betriebssystem bekommt nichts davon mit


# Dateisysteme - logische Sicht

Aufgaben: managen der Daten und des Zugriffs, Berechtigungen, gleichzeitiger Zugriff, Strukturierung der Daten durch Dateien und Verzeichnisse

### Dateien
bestehen aus:
- Dateiattribute (Datum, Dateiname, Dateigröße, Zugriffsrechte, Flags)
- Nutzdaten: bytestrom (Struktur fürs Dateisystem egal - für Anwendungen relevant)
- Zugriff ist sequenziell oder beliebig
#### Dateitypen
- regular files
- Verzeichnis
- Zeichendatei (Kommunikation über USB)
- Blockdateien (spezielles Device file für blockorientierte Geräte, z.B. Festplatten. Geräte die man nicht wegen einem einzigen byte anspricht. Man cashed vorher im RAM und speichert dann in die Blockdatei, welche das dann auf die Festplatte speichert)

Es gibt auch Verzeichnisse zur Gruppierung von Dateien - Baustruktur entsteht, weil Verzeichnisse auch Unterverzeichnisse haben können.

## Partitionierung und Booten eines Computers
Partitionen: Einteilung einer Harddisk in Bereiche hintereinanderliegenden Sektoren
Man braucht auf jeden Fall Partitionen, wenn man booten will.
In einer Tabelle wird gespeichert, wo die Partitionen anfangen. Bei MBR ist der diese erste Mini-Partition so klein dass nur 4 Werte gespeichert werden können -- daher kann es nur 4 primäre; echte Partitionen geben.
Workaround: Einer der Werte wird verwendet um auf eine weitere kleine Parition (erweiterte Partition) zu zeigen, welche die Adressen weiterer logischer Laufwerke speichert (davon kann man nicht booten)

Bei GPT ist diese erste kleine Partition größer - es können 128 primäre Partitionen existieren, man braucht also keine erweiterten Partitionen mehr, weil 128 genug sind.

Boot-Prozess:
- Mainboard angeschaltet --> Boot-ROM wird ausgeführt
- Boot-ROM hat kleine Input/Output software, stellt services für Betriebssystem bereit
- es lädt eine Partitionstabelle (BIOS, oder UEFI (modern)) um die Partitionen bzw. die Boot-Partition zu finden

Wegen Rückwärtskompartiblität ist an Sektor 0 immer MBR
Sektor 1 bis x ist GPT. ein UEFI weiß das und sucht ab Sektor 1.
Auf Sektor 1 ist ein UEFI Header, der auf die Partitionenstabelle zeigt und weitere Informationen hat. (z.B. über Backuppartitionstabellen oder Ähnlichem)


1. UEFI lokalisiert Boot Gerät, liest die GPT und bestimmt die EFI Partition (ESP) wo der Bootloader liegt
2. Bootloader startet - und lädt entweder gleich das Sytem oder einen anderen Bootloader (z.B. kann der Win bootloader gestartet werden)
3. Das OS fragt beim UEFI nach Informationen über die Hardware, Treiber werden geladen, evtl. wird GUI gestartet


# Dateisysteme aus OS-Sicht

Die Partition ist so zu verwalten, dass die Positionierungszeit der Leseköpfe minimal ist - also muss eine Datei auf einer Festplatte möglichst an einer Stelle durchgehend gespeichert sein.
Eine SSD / HDD hat einen Controller mit einer Zuordnungsadresse, wo virtuelle Adressen an logische Adressen (welche fürs OS bereitgestellt werden) gemappt sind.
Im OS kann durch das FS eine Block size gewählt werden - es werden also die Adressen nochmal zu Blöcken zusammengefasst.


Ein OS stellt Systemcalls zum Handieren mit Dateien bereit. (z.B. create, delete, read, write für files und so ähnlich auch für directories etc.)

Auch Verwaltungsaufgaben können getriggert werden (nicht umbedingt durch Systemcalls, eher durch Flags (bei komprimierung), oder durch eigene userspace programme zum Formatieren von Partitionen (verwenden dann wirte() befehle zum draufschreiben auf die Platte)):
- Formatieren: Erzeugen eines leeren Dateisystems
- Backup-Funktionen
- Komprimierung / verschlüsselung


Eine Partition ist aus OS Sicht ein Array von fortlaufenden Logical Block Adresses (LBA).
Das FS muss seine eigenen verwaltungsinfos speichern (z.B. ganz am Anfang).
Eine Datei ist eine Folge von Blöcken, die nicht umbedingt nacheinander kommen müssen.

#### Adressierung
LBA: heutzutage Standard, auch bei HDDs.
Vorteil: kein Wissen erforderlich, wie die Festplatte technisch funktioniert: Übersetzung macht der Festplattencontroller.
LBA-Adressen haben 48 Bit.

VFS-Layer stellt Abstraktionsebene für die logische Sicht von Files und Verzeichnissen dar und exportiert über die Systemschnittstelle die Funktionen open, close, read, write.
Die Aufträge werden an die jeweilige Paritionsverwaltung mit dem FS weitergegeben, welche die Aufgabe auf der Platte ausführen. Beim Lesen und Schreiben können files im RAM gecached werden.

![[Pasted image 20260508183658.png|350]]



## Grundsätzliche Funktionsweise

Für jedes Dateisystem muss man speichern:
- Allgemeine Infos zum Dateisystem
	- welches FS
	- Wo beginnt das Inhaltsverzeichnis
	- freie Positionen im Inhaltsverzeichnis
- Inhaltsverzeichnis
- Freispeicherverwaltung, Bad Block list
- Datenbereich


#### Freispeicherverwaltung
- Bitmaps (Array mit 0 oder 1, für jeden block)
	- 0 ist frei
	- 1 ist belegt
- verkettete Liste - zeigt auf einen freien Speicherblock, darin werden wieder freie Speicheradressen gespeichert. Wenn Der Block benötigt wird, müssen die Adressen wegkopiert werden.


#### Inhaltsverzeichnis für Dateien/Verzeichnisse
- Dateien können aus mehreren Blöcken bestehen
- irgendwie muss das verwaltet werden
- Ideen:
	- Kontinuierliche Speicherung: nur sequentiell speichern
		- NACHTEIL: Was wenn die Datei wächst? Umkopieren?
	- Kontinuierliche Speicherung mit Extents
		- Daten werden grundsätzlich sequenziell gespeichert
		- Wenn das nicht möglich ist (z.B. wegen Fragmentierung), wird im Inhaltsverzeichnis ein zweiter Eintrag zur selben Datei erstellt (Extent)
		- gespeichert wird Filename, Startblock, Länge
	- Verkettete Speicherung
		- In jedem Block wird die Referenz auf den nächsten Block mitgespeichert
		- z.b. bei 512 Bytes Blockgröße könnten 4Bytes für die Adresse des nächsten Nodes draufgehen
		- somit muss im Inhaltsverzeichnis immer nur Name und Startblock gespeichert werden
		- +Einfach zu implementieren - schlechter random access - Minute 40 in nem Video muss die ganze Liste iterieren
		- ![[Dateisysteme_VL2.pdf#page=40&rect=105,32,457,219|Dateisysteme_VL2, p.40|300]]
		- Kann in eine File Allocation Table ausgelagert werden (FAT) -- schneller, Minute 40 direkt gefunden, weil die Tabelle im Ram liegt
	- indizierte Speicherung
		- gespeichert wird zu einer Datei immer ein Block mit allen Blöcken der Datei
		- So einen Referenzspeicherblock nennt man Inode bzw. Indexblock