Kommunikation findet mündlich und schriftlich statt. Alles Wichtige soll jedoch schriftlich festgehalten werden, bei externer (mit dem Kunden) sowie interner Kommunikation (innerhalb des Unternehmens).

**Trends**:
- Kundeneinbindung steigt (agiles Vorgehen)
	- mehr Kundenkontakt erfordert saubere Dokumentation der Kommunikation - Transparenz
- räumliche Distanz der Mitarbeiter steigt 
	- sauber definierter Daten- und Dokumentaustausch ist wichtig
- Komplexität von Werkzeugen und Ergebnissen steigt
- Entwicklungszeit sinkt

# Kundeneinbindung

> [!note]
> Stakeholder: alle Beteiligten und Betroffenen eines Projekts

z.B.:
- Auftraggeber / Kunde(n)
- Auftragnehmer (Eigentümer) 
- Anwender
- Entwickler, Projektleiter
- Sub-Auftragnehmer
- Zulieferer
- Investoren
- Fördergeber

Beispiel: Wer sind #Stakeholder Ihres Studiums?
- Praktikumsgeber
- Land (OÖ)
- Familie
- Lehrende
- Projektpartner
- FH-Bedienstete
- Haustiere (FH-Katze)
- z.B. auch Wirtschaftskammer (Zukunft gut qualifizierte Leute)

## Value-Based Software Engineering (VBSE)

> Es geht darum, gemeinsam mit dem Auftraggeber ein Produkt zu erarbeiten, welches ihm wirklich einen Mehrwert bringt.

Anstatt nur Anforderungen einzuholen und diese stumpf umzusetzen, arbeitet man mit dem Kunden zusammen, um ein für ihn bestes Produkt zu designen.
So kann es ablaufen:
1. Wünsche
	1. Grundsätzliche Idee (z.B. Die Bestellung in meinem Online-Shop dauert zu lange)
2. Erfordernisse
	1. Man analysiert genau, worauf es ankommt (z.B. Das Langsamste ist vom Warenkorb zum Bezahlen - dort muss man ansetzen)
3. Anforderungen
	1. genauer Bauplan für die Entwickler, wie der Prozess beschleunigt werden kann
4. (Produkt-)Wert
	1. Dadurch entsteht mehr Produktwert für den Kunden, weil Softwarespezialisten die Anforderungen besser kennen, als z.B. ein Supermarkt. Durch die Zusammenarbeit entsteht also normalerweise ein besseres Produkt.

Dabei ist wichtig:
- ein kompetenter und entscheidungsbefugter Auftraggeber
- gute Werkzeugunterstützung der Anforderungsanalyse (traceability, Nachverfolgbarkeit)
	- Anforderungen ändern sich, sie müssen priorisiert werden und nachvollziehbar sein

## Besprechungen

**Interne Projektbesprechungen**: unmittelbare Fortschrittskontrolle
**Externe Projektbesprechungen**: Informationsaustausch mit Auftraggeber

**Organisation der externen Besprechung:**
- interne Vorbesprechung
- externe Besprechung
- interne Nachbesprechung


**Aufgaben des Besprechungsleiters:**
- Gesprächsgliederung gemäß Tagesordnung
- Moderatorfunktion
- Gespräch vorhersehen – Auswege und Alternativen anbieten

> Für jede Besprechung ist die Beginn- und Endzeit vorher bekannt zu geben.


## Reviews
> formale Überprüfungen von Zwischenergebnissen oder Ergebnissen

- werden in Gruppen durchgeführt
- breit einsetzbar
- Informationsaustausch wird gefördert
- auch anwendbar auf halb fertige Produkte
- überprüft wird z.B. ob der Fortschritt den Anforderungen aus der Anforderungsanalyse gerecht wird

Bei Reviews ist der Erfolg stark von der Akzeptanz bei den Gruppenmitgliedern abhängig!

Es gibt verschiedene Ansichte, wie man ein Team für Refiews zusammenstellen kann.

![[SPE 106 INA v.25.1.pdf#page=10&rect=171,50,812,399|SPE 106 INA v.25.1, p.10]]

## Werkzeuge
> [!note]
> „Werkzeuge sind Programme, die die Herstellung, Prüfung, Wartung und Dokumentation von Programmen vereinfachen, beschleunigen oder in ihrer Qualität verbessern.“ 

**Computer-Aided-Software-Engineering-Systeme (CASE-Systeme)** sind breit einsetzbare Werkzeuge oder eine koordinierte Sammlung von Werkzeugen zur Entwicklung von Softwareprodukten oder -services. Bsp: VS-Code

**Application-Lifecycle-Management-Systeme (ALM-Systeme)** sind Werkzeuge, die neben der Entwicklung von Software auch den Betrieb (Wartung, Pflege) dieser Software unterstützen. ALM-Systeme lösen zunehmend CASE-Systeme ab.


**Softwareentwicklungsumgebungen** sind integrierte Entwicklungssysteme. Sie umfassen:
- Planung („Projektmanagement“)
- Prototyping
- Analyse, Design („Roundtrip-Engineering“)
- Implementierung
- Testfallgenerierung, -durchführung
- Konfigurations- und Versionsverwaltung
- Dokumentation

Empfehlungen für eine sinnvolle Werkzeugnutzung:
- Entwicklungsprozess von Werkzeugen, Modellen und Sprachen trennen
- durchgehend nutzbare Werkzeuge verwenden
- frühzeitig mit der Werkzeugnutzung beginnen („von Anfang an“)
- iterativ-inkrementelles Vorgehen muss unterstützt werden
- Schulungen einplanen
- Releasewechsel geordnet durchführen (nur wenn notwendig)
- Projektfortschritt und Grad der Zielerreichung prüfen

> [!note]
> Werkzeugnutzung ist gerade bei agilem Vorgehen essenziell


# Dokumentation von Softwareprojekten

Umfasst:
- Projektdokumentation („organisatorische Dokumentation“)
	- Wer war dabei, was wurde besprochen, etc.
- und Produktdokumentation („technische Dokumentation“)

### Dokumentationsplanung
**Ziele**:
- einheitliche Dokumentstruktur
- rasche Erstellung neuer Dokumente
- einfache Zusammenführung von Dokumenten
	- dazu braucht man Standards -- font size, font, etc.
- aktuelle Information über Projektstand (Projektkontrolle)
	- Wer arbeitet aktuell an einem Projekt, wieviele Stunden bereits gearbeitet etc
**Aufgabe**:
- Erstellung von Standards, Strukturen und Vorgaben


### Berichtswesenplanung
> Die Berichtswesenplanung legt den Kontrollfluss für Informationen fest, d. h. wer von wem wann welche Informationen erhält).

Folgende Entscheidungen sind für jedes Dokument zu treffen:
- Wann ist es zu erstellen?
- Wer erstellt es?
- Wer empfängt es?
- Wie oft ist ein Update notwendig?
- Sollen Versionen gehalten werden?
- Welches Format ist zu wählen?

##### Essenzielle Dokumente
![[SPE 106 INA v.25.1.pdf#page=19&rect=29,77,828,516|SPE 106 INA v.25.1, p.19]]

![[SPE 106 INA v.25.1.pdf#page=20&rect=32,55,856,518|SPE 106 INA v.25.1, p.20]]

![[SPE 106 INA v.25.1.pdf#page=21&rect=26,38,957,530|SPE 106 INA v.25.1, p.21]]


### Dokumentationsorganisation

Festlegung der zu erstellenden Dokumente
**Für jedes Dokument sind festzulegen:**
- Arten und Standards
- Erstellungs- und Freigabestatus
- Ablage, Archivierung
**Wichtige Prinzipien:**
- mitlaufende Dokumentation sichern
- Redundanz vermeiden
- einheitliche Bezeichnungen verwenden
- systematische Ablage einhalten

#### Dokumentablage
... für sicheres Ablegen und rasches Wiederauffinden von Dokumenten (Werkzeuge verwenden!)

Folgende Entscheidungen sind für jedes Dokument zu treffen:
- Ablageort? (lokal, Intranet, Cloud,…)
- Ablageformat? (Originalformat, strukturiert – XML, PDF/A,…)
- Indexierung für Suche (Beschlagwortung, Volltextzugriff, …)
- Zugriffsschutz?
- Sekundärsicherung? (z.B. extern)
- Wartung der Ablage? (z.B. Transferieren auf neues Medium alle 5 Jahre)
- Ablagedauer? (Entsorgung bzw. sicheres Löschen danach)


# Einschub: Konfigurationsmanagement

Git - etc.

![[SPE 106 INA v.25.1.pdf#page=26&rect=31,45,908,516|SPE 106 INA v.25.1, p.26]]


> [!quote]
> "Konfigurationsmanagement ist derjenige Aufgabenbereich in der Projektentwicklung, der für die Verwaltung und Speicherung aller innerhalb des Projekts anfallenden Zwischen- und Endergebnisse und deren Versionen verantwortlich ist.“ 

Jedes Softwareprojekt braucht eine Konfigurationsverwaltung.
händisch oder werkzeugunterstützt! -> Werkzeugunterstützung möglichst ab Projektbeginn!

Heutzutage: Git

**Aufgaben**:
- Versionsverwaltung: Versionen von Dokumenten und Code, Zugriffsrechte (Teamprojekte!)
- Konfigurationsverwaltung: Revisionen, Varianten, Releases
- Build-Unterstützung: Continuous Integration, Continuous Release
- Workflow-Unterstützung
- Änderungsmanagement: Anforderungen, Fehler, Erweiterungen
- Auswertungen


### Benennung von Versionen
Varianten textuell (deutsch / engl., ios, Android etc.)

Revisionen werden in der Form MAJOR.MINOR nummeriert:
- MAJOR wird erhöht, wenn sich für den Kunden geplante Anpassungen oder Erweiterungen ergeben.
- MINOR wird erhöht, wenn (kleinere) Korrekturen durchgeführt werden.

![[SPE 106 INA v.25.1.pdf#page=34&rect=28,43,925,516|SPE 106 INA v.25.1, p.34]]


Es braucht einen 
### Konfigurationsmanagement-Verantwortlicher
**Aufgaben**:
- Einrichten/Konfigurieren des KM-Werkzeugs 
- Erstellen eines „Projekts“, „Workspaces“ etc.
- Erstellen und laufendes Aktualisieren des KM-Plans
- Schulen der Mitarbeiter
- Überführen bestehender Daten
- Überwachen der KM-Disziplin
- Anlaufstelle für Probleme mit dem KM-Werkzeug

> [!note]
> -> Je besser ein Konfigurationsmanagement-Werkzeug funktioniert, desto weniger merkt man davon!


# Dokumente der Aufbauorganisation

## Organigramm
> Darstellung von Gesamtstruktur und Stellen (Funktionen) in der Aufbauorg.
> Stellen werden durch Mitarbeiter in bestimmten Rollen besetzt (n:m-Bezug).

![[SPE 106 INA v.25.1.pdf#page=43&rect=34,50,947,513|SPE 106 INA v.25.1, p.43]]

## Stellenbeschreibung
> Beschreibung von Aufgaben, Kompetenzen und Verantwortlichkeiten zur Schaffung klarer Zuständigkeiten

Eine Stellenbeschreibung enthält:
- Stellenbezeichnung
- Aufgaben der Stelle
- notwendige Qualifikationen
- Verweis auf Vorgesetzte(n)
- Regelung der Stellvertretung

> Eine Stellenbeschreibung wird je Stelle erstellt (NICHT je Mitarbeiter/Rolle)! 

Stelle vs. Rolle:
Eine Stelle beinhaltet die Aufgaben.
Rollen sind Projektabhängig und ändern sich.


# Dokumente der Ablauforganisation

Checkliste für Dokumente:
![[SPE 106 INA v.25.1.pdf#page=47&rect=26,39,957,538|SPE 106 INA v.25.1, p.47]]

### Projekthandbuch
> verbindliche Festlegung der Projektorganisation (wie in [[Aufbauorganisation]]

Stellen sind hier nicht dauerhaft gemeint, sondern eher wie Rollen für die Dauer des Projektes.

- Das Projekthandbuch enthält:
- Organigramm, Stellenbeschreibungen
- Stellenzuordnungen
- Projektleitung, Führungsgrundsätze
- Sitzungskonzept
- Dokumentationsvorgaben, -standards
- Vorgehensmethode(n), Werkzeuge
- Vorgaben für Projektplanung (Arten, Umfang, Häufigkeiten)
- Festlegungen zur Qualitätssicherung


### Projekttagebuch
> entwicklerinterne, chronologische Aufzeichnung aller Projekttätigkeiten

Ein Eintrag enthält:
- Datum, (Uhrzeit)
- Beteiligte, (Ressourcen)
- Aktivität
- Aufwand

> [!note]
> Das Projekttagebuch wird von allen Projektmitarbeitern gemeinsam geführt und ist laufend (täglich) zu aktualisieren

### Projektfortschrittsbericht

- Terminbericht zum Zweck des Soll-Ist-Vergleichs 
- ergeht von Projektleiter AN an Projektleiter vom Auftraggeber oder Projektträger
- ist regelmäßig zu erstellen (z.B. alle 4 Wochen) sowie im Anlassfall (z.B. Revision)

### Arbeitsbericht (Tätigkeitsbericht)
- Dokumentation einer abgeschlossenen Aufgabe
- von den involvierten Mitarbeitern gemeinsam zu erstellen

Beispiel: Abschlussbericht eines (Teil-)Projekts


### Projektbibliothek
- Verzeichnis aller zum Projekt gehörigen Dokumente
- meist elektronisch geführt
- Dokumentstatus ist laufend zu aktualisieren