> Die Aufbauorganisation beschreibt die Strukturen eines Systems.

Im Folgenden betrachten wir vor allem das soziale System, die Organisation. Wir unterscheiden zwischen **allgemeinen Organisationsformen** und **softwareentwicklungsspezifischen Organisationsformen**.

## Allgemeinen Organisationsformen

### Reine Projektorganisation
In allgemeinen Organisationsbereichen wird die reine Projektorganisation für (sehr) kleine Projekte eingesetzt, die von besonderer Schwierigkeit sind.

Dafür wird ein Projektleiter ausgewählt, der der Unternehmensführung direkt unterstellt ist. Er ist zuständig für die Durchführung des Projektes.

Mitarbeiter werden neu eingestellt oder aus der Organisation aus anderen Abteilungen für die Dauer des Projektes herausgelöst.

**Vorteile**:
- eindeutige Aufgabenzuordnung
- volle Konzentration auf Projekt
- Identifikation mit der Aufgabe
- rasche Entscheidungen
- flexible Reaktion

**Nachteile**:
- Schwächung der Abteilungen
- Abstellung der am leichtesten entbehrlichen Mitarbeiter („Mr. Bean-Effekt“)
- Konflikte mit angestammten Abteilungen
- unterschiedliche Auslastungen der Mitarbeiter in den einzelnen Phasen (es gibt nur ein Projekt)

> [!note]
> Die reine Projektorganisation ist geeignet für schwierige, kleine Projekte.



## Einfluss-Projektorganisation

> geeignet für gut strukturierte Aufgaben, die den Mitarbeitern bekannt sind, also eher nicht für SE geeignet.

- Mitarbeiter bleiben in den Abteilungen
- Mitarbeiter sind nicht "unter" dem Projektleiter, sondern unter ihrem normalen Chef

**Vorteile**:
- Abteilungsorganisation unverändert
- Sicherheitsgefühl für Mitarbeiter
**Nachteile**:
- mangelnde Autorität des Projektleiters
- Arbeiten am Projekt nur, “wenn Zeit ist”
- Konflikte werden verzögert (weil sie nicht immer direkt mit dem Projektleiter gelöst werden können)

## Matrix-Projektorganisation 

> geeignet für zeitunkritische Projekte, aber aufgrund längerer Entscheidungsphasen eher ungeeignet für Softwareprojekte

Es gibt einen Personal- und einen Fachvorsitzenden. --> also doppelter Vorgesetzter.

**Vorteile**:
- selbstständiger Projektleiter
- Mitarbeiter bleiben in Abteilung
- Expertenwissen leicht einbaubar
- gezielter Einsatz von Spezialwissen und besonderen Erfahrungen
**Nachteile**:
- Verunsicherung bei Vorgesetzten
- Verunsicherung bei Mitarbeitern
- man „sitzt zwischen zwei Stühlen“
- Kompetenzkonflikte
- Möglichkeit, Vorgesetzte auszuspielen


## Probleme dieser allgemeinen Organisationsformen
- hierarchische (langsame) Kommunikationswege beeintrachtigen Qualität, Quantität und Schnelligkeit des Informationsflusses.
- Problemstau bei Führungskräften
- gegenseitige Abhängigkeit von Stellen
- schlechte Koordination einzelner Bereiche
- unrealistische Planung (man kann Bugs nicht fixen bevor man sie findet)


# Softwareentwicklungsspezifische Organisationsformen
... ergeben sich durch die besonderen Anforderungen in der SE.

- zeitliche Begrenztheit
- hohe Flexibilität
- projektübergreifende Planung![[SPE 105 AUO v.25.1.pdf#page=12&rect=31,104,907,518|SPE 105 AUO v.25.1, p.12]]
> [!note]
Gruppe führt (bei kleinen/mittleren Projekten) zu bester Leistung!


### Hierarchische Teamorganisation
> eher früher, heute eher ungeeignet

- lange Hierarchie
Für alle Phasen gab es verantwortliche Leiter, die Projektleitern überlegen sind, die je nach Unternehmensgröße nochmal Gruppenleitern überlegen sind.
- entspricht anderen Industriezweigen
- Aber: dadurch ist der Hauptleiter weit weg von der eigentlichen Programmierung und kann deshalb seine Planungsarbeiten nur schwer umsetzen
- langsame, indirekte Kommunikation


### Chefprogrammierer-Team

> Man versucht, die Nachteile hierarchischer Organisationsmodelle zu vermeiden.

Das erreicht man, in dem man durch
- Verzicht auf einen Projektleiter, der nicht an der Systementwicklung selbst beteiligt ist
- den Einsatz von sehr guten Spezialisten
- die Beschrankung der Teamgröße.

> Dabei arbeitet der Projektleiter also aktiv mit.

Das Team besteht aus:
- Chefprogrammierer
- Projektassistent
	- engster technische Mitarbeiter des Chefprogrammierers
- Projektsekretär
	- Aufgabe, den Chefprogrammierer und auch alle anderen Programmierer von Verwaltungsaufgaben zu entlasten. 
- mehrere Spezialisten (2-6)
	- Anzahl wird vom Chefprogrammierer festgelegt

**Vorteile**:
- Chefprogrammierer direkt eingebunden
- gute Kommunikation
- Berichtswesen institutionalisiert
- kleine Teams sind produktiver als große Teams
**Nachteile**:
- nur kleine Teams möglich
- Personalanforderungen kaum erfüllbar
- undankbare Aufgabe des Projektsekretärs und kein Ersatz eingeplant

> Trotz der Nachteile ist eine kleinere Gruppe produktiver als ein "Programmierheer"


## Moderne Projektgruppe

Folgende **Anforderungen** führen jedoch vom Chef-Programmierer Team weg:
- Ein Softwareingenieur muss alle Schritte des Entwicklungsprozesses beherrschen.
- Mitarbeiter müssen Kollegen vertreten können.
- Ein Projektleiter, der gleichzeitig ein guter Implementierer ist, existiert kaum (bzw. ist für die Implementierung zu teuer).
- Die Rolle des Projektsekretärs („Chefdokumentierers“) ist undankbar und risikoreich.

> -> Entwicklung hin zur Modernen Projektgruppe

In einer Projektgruppe gibt es einen Projektleiter und mehrere Gruppenmitglieder, welche eine Rolle zugewiesen bekommen. Sie haben auch ein Grundverständnis der anderen Rollen.

### Einbindung in die Organisation
- als projektorientierte Teilorganisation („agile Teams“)
	- d.h. Eine Abteilung übernimmt das Projekt
	- der Abteilungsleiter bestimmt einen Projektleiter, der ihm unterstellt ist, und das Projekt mit seinen Kollegen leitet
	- Wenn mehrere Abteilungen einbezogen werden, kann z.B. die Abteilung mit dem größten Anteil die Leitung übernehmen

### Rollen in modernen Projektgruppen (agilen Teams)

![[SPE 105 AUO v.25.1.pdf#page=19&rect=29,141,844,537|SPE 105 AUO v.25.1, p.19]]

**Projektleiter**: „organisatorische Projektleiterin“, prozessbezogene Projektleiterin
**Produktverantwortlicher**: "inhaltliche Projektleiterin", produktbezogene Projektleiterin, Pilotanwenderin

RM: Ressourcenmanagment
PR: Projektrealisierung

![[SPE 105 AUO v.25.1.pdf#page=20&rect=24,52,866,530|SPE 105 AUO v.25.1, p.20]]

### Aufgabenverteilung Agile Teams
- **ProjektleiterIn**: überwacht Ablauf versteht, steuert und dokumentiert Prozess teilt Aufgaben zu bewahrt Produktsicht (≠ Entwickler !) 
- **Produktverantwortlicher**: treibt dadurch Entwicklung voran (Anforderungsauswahl!) erstellt Testfälle
- **Entwickler** (2 - 7): schätzen und wählen Aufgaben,
  entwickeln (primär Designen-Implementieren-Testen), übernehmen andere Aufgaben (z.B. Systemadministratorin, Weiterbildungskoordinatorin)
  teilzeitlich (Gruppenorganisation ist vorgehensspezifisch, es kommt also aufs Team an.)

### Gruppendynamische Prozesse, Kommunikation
![[SPE 105 AUO v.25.1.pdf#page=22&rect=21,163,918,511|SPE 105 AUO v.25.1, p.22]]
- funktioniert also nur gut, wenn sich jeder einbringt

### Mitarbeitermotivation
![[SPE 105 AUO v.25.1.pdf#page=23&rect=26,52,941,518|SPE 105 AUO v.25.1, p.23]]

### Produktivität
> Leistungen sind sehr verschieden und Personenabhängig - Mittelwerte sind also nicht besonders aussagekräftig
> Entwicklungsdauer ist also schlecht planbar

Die Bearbeitungszeit eines Projekts lässt sich aufteilen in:
- produktive Arbeit (Nutzleistung)
- Kommunikation (Bindleistung)

Wenn mehr Arbeiter an einem Projekt teilnehmen sollen, dann wird sich die Bindleistung erhöhen - es wird also mehr Zeit für Kommunikation aufgewendet.
![[SPE 105 AUO v.25.1.pdf#page=26&rect=30,124,904,518|SPE 105 AUO v.25.1, p.26]]

![[SPE 105 AUO v.25.1.pdf#page=27&rect=30,31,934,512|SPE 105 AUO v.25.1, p.27]]

### Interdisziplinäre Zusammenarbeit

Moderne Projektentwicklungsgruppen bestehen oft aus Personen mit verschiedensten Fertigkeiten (heterogene Projektgruppen).
**Probleme**:
- fehlende gegenseitige Ein- und Wertschätzung der Arbeit
- bei Überlappungen Konflikte
- viele verschiedene Methoden und Werkzeuge
**Wichtig**:
- Konflikte rasch lösen!
- Schulung, Weiterbildung anbieten!
- Geordnete Änderungspolitik der Entwicklungsumgebung(en) beachten!


### Hauptorganisationsmängel bei Softwareprojekten
**Hauptmängel**:
- Fehlen von Planung, Organisation, Standards
- Inkompetenz der Projektführung
- Fehlen aktueller Dokumentation
- Mangel an Fortschritts- und Qualitätskontrolle
- Mangel an Kostenkontrolle
**Verbesserung**:
- Verbesserung der Abläufe (Prozesse) -> Kapitel Ablauforganisation
- Verbesserung von Information und Kommunikation im Team -> Kapitel Informationsaustausch
- Verbesserung der Qualität -> Kapitel Qualitätssicherung