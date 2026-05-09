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
		- es muss nicht eine komplette Tabelle gescannt werden

### Verzeichnisse
Verzeichnisse sind Dateien, welche Namen von anderen Dateien speichert und wo die sind (z.B. Inode Nummern)
Umsetzung:
**Möglichkeit 1**: Dateinamen eine fixe Länge geben (so hat mans früher gemacht). Informationen zu Datei 3 erhält man mit Startadresse + 2*(Namen+Attributlänge)
Vorteil: Einfach zu implementieren
Nachteil: Dateinamen entweder auf ganz kurz beschränkt oder massiv Speicherverschwendung, weil immer gleich viel Speicher für jeden Dateinamen reserviert werden muss.

**Möglichkeit 2**: Am Anfang der Verzeichnisdatei speichert man Attribute der Datei + Blockreferenz auf den Dateinamen. Die Dateinamen selbst werden z.B. am Ende der Verzeichnisdatei gespeichert.



## Linux ext4
- Bootblock: kann Bootloader enthalten
- Superblock: Dateisystemtyp, allgemeine Infos etc.
- Freispeicherverwaltung
- Inhaltsverzeichnis: Liste von Inodes
- Abschluss: Datenblöcke: Verzeichnisse und Dateien

Die Partition wird in Blockgruppen aufgeteilt, die alle gleich aufgebaut sind. Alle haben:
- Superblock mit allgemeinen Infos (nicht umbedingt in jeder Gruppe gespeichert, aber oft)
- Gruppendeskriptor: speichert die Referenz auf die Bitmap für Freispeicherverwaltung und die Inode Tabelle
- Bitmap für die Inodes
- Bitmap für die Datenblöcke
- Inodes
- Datenblöcke
- zusammengehörige Dateien und Verzeichnisse werden am besten in der selben Gruppe gespeichert? wegen HDD.

Dieses Blockdesign macht sinn, damit die Freispeicherverwaltung und Inodetabelle näher an den eigentlichen Dateien ist - so muss der Lesekopf der HDD nicht immer zwischen Anfang der Platte (für die Inodes) und Mitte oder sogar Ende hin und her springen


Im Bereich der Inode list sind die Inodes. Das sind Blöcke, die Informationen zu den Dateien speichern.

ls -ali
1. session im terminal weiß, in welchem inode ich mich befinde.
2. ls liest diese verzeichnisdatei aus, in der alle inodes mit dem zugehörigen Dateinamen stehen
3. für jedes inode liest ls die in den inodes gespeicherten informationen aus

alles wird nebeneinander aufgelistet

```
32 Bit Adresse und Logical Block Size == 1 Kilobyte
maximum file size?
adressAnzahlProBlock = 1KB / 32Bit
adressAnzahl = 12 + (adressAnzahlProBlock) + (adressAnzahlProBlock)^2 +(adressAnzahlProBlock)^3 = 12 + (1024*8 / 32) + (1024*8 / 32)^2 + (1024*8 / 32)^3 = 12 + 256 + 256^2 + 256^3 = 16843020 Adressen gesamt
maxFileSize = adressAnzahl * 1 Kilobyte = 16843020KB = 16,06 GB
```

48 bit und LBS == 4kb
Diese Struktur ist bei ext2 und ext3. Ext4 funktioniert bisschen anders.

## Verzeichnisse in Linux
Verzeichnis ist eine Datei welche directory entries speichert. D.h. Eine Liste von Metadaten, von Dateien.
ein directory entry besteht aus:
- inode nummer der Datei
- Länge des Entries (Damit beim Verzeichnis durchsuchen die Datei übersprungen werden kann)
- Länge des Dateinamens (damti man weiß, wie lange der Dateiname auszulesend ist. Man speichert beides, wenn nämlich nach einer Datei eine Datei gelöscht wird, kann die Länge der vorherigen Datei so gesetzt werden, dass die andere (gelöschte) Datei gleich mit übersprungen wird. damit man beim Lesen des Dateinamen weiß, wo man aufhören muss (damit man nicht den Namen der gelöschten files mitlest), speichert man auch die Dateilänge)
- Typ des Objekts: aus Performancegründen --> damit Apps schnell sehen worum es sich handelt (steht eh im inode auch, aber inodes sind an anderer stelle - sie aufzurufen kann dauern)
- Name des Objekts --> eh kloa denk ich


## Zugriff über Pfadangabe

Annahme: Zugriff auf Pfad: /usr/ast/mbox
Das Root Verzeichnis ist die Inode Nummer 1 (oder eine andere fixe Inode Nummer). In dieser Rootverzeichnisdatei wird nach dem Eintrag "usr" gesucht, gefunden, und es wird zu dieser inode nummer gesprungen (hier nr 6). Dort steht, wo sich die Datei usr befindet. (Nämlich an Block 132).
Man springt zu Block 132. Jetzt ist man in /usr/. Es handelt sich um ein Verzeichnis. Man sucht nach der Verzeichnisdatei "ast" und findet sie. inode nr. 26. Man springt zu inode nr 26 und schaut, wo die blöcke für die Verzeichnisdatei sind. in diesem Fall ist das nur der Block 406. Also geht man zu Block 406 und ist in /usr/ast.
gleiches nochmal für mbox.



## Journaling

Jede Modifikation wird gelogged in einer Logdatei
z.B.:
- Anlegen einer neuen Datei
- löschen einer Datei
- Schreiben in eine Datei etc.

Beispiel beim Löschen:
1. Markieren des Transaktionsbeginns
2. Freigabe der Speicherblöcke in der Bitmap
3. Löschen des Eintrags im darüberliegenden Verzeichnis
4. Freigabe des inodes im inodes Verzeichnis
5. Marikieren des Transaktionsende
check

Wenn irgendwo dazwischen z.B. das System abstürzt, dann wurd eine Transaktion gestartet aber nicht beendet. Das Journal wird einfach verworfen und es ist nichts passiert.

Wenn nach dem Transaktionsende das System abstürzt aber der Journaling Eintrag noch immer existiert, wird der Eintrag einfach neu abgearbeitet. Wenn die Operation erfolgreich war, wird der journeling Eintrag gelöscht.
- Metadaten-Journeling: Konsitenz der Metadaten und des FS wird garantiert
- Full-Journeling: auch Konsistenz der Nutzdaten wird gewährleistet

Copy-on-write Systeme brauche kein Journaling, weil sie nie Dateien überschreiben. Es werden nur Zeiger angepasst - am Ende wird der Hauptzeiger auf den neuen Baum gehängt - danach sind im system die neuen files. davor sind im system noch immer die alten files. es kann daher nichts verloren gehen.









