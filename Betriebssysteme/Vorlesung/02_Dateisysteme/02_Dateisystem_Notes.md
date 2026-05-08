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


1. UEFI lokalisiert Boot Gerät, liest die GPT und bestimmt die EFI Partition (ESP)

































