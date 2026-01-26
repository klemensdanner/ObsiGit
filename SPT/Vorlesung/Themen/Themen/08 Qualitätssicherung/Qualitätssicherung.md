In dieser LVA keine Normen auswendig lernen, aber nachschauen lernen

> [!note]
> Jeder Prozessschritt ist für die Qualität eines Produkts verantwortlich!

# Qualität Begriff

> [!note]
> Qualität bedeutet die Erfüllung der Anforderungen


- **optimale Qualität**:
	- optimales Verhältnis zwischen Fehlerkosten und qualitätsbezogenen Kosten
	- ![[SPE 108 QUA v.25.1 Stud.pdf#page=7&rect=25,42,866,520|SPE 108 QUA v.25.1 Stud, p.7]]
- **Qualität kostet Geld.**
	- Projektbezogene Kosten
		- im SE ein großer Teil das Testen
				- in einer Kranfirma: Einhaltung der Normen für einen spezifischen Kran, um ihn sicher und wettbewerbsfähig zu halten - projektbezogen
		- Qualitätsplanung, Personal für Qualitätsmanagement
	- Unternehmensbezogene Kosten
		- in der Kranfirma: Einhaltung allgemeiner Normen wie z.B. Stahlqualität. Stahl wird für jeden Kran verwendet, nicht nur für einen spezifischen
		- Allgemein: Einführung eines Qualitätsmanagmentsystems
		- Weiterbildung im QM-Bereich
- **Fehlerkosten**
	- Projektbezogen
		- Fehlersuche
		- Fehlentwicklungen (falsch verstandene Anforderungen)
		- Fehllieferungen
		- Folgekosten durch Fehler im Einsatz
			- z.B. Geschichte mit meinem neuen Server
	- unternehmensbezogen
		- Verlust von Aufträgen oder Image
		- niedriger Preis bei geringer Qualität, trotzdem Fehlerkosten
- **Fehler - Mangel - Schaden: Unterscheidung**
	- Ein Fehler ist laut Norm die Nichterfüllung einer Anforderung, noch unabhängig von den Folgen
	- z.B. falsche Fliesenfarbe im Raum vor der MBI / SE-Administration (wenn der Auftrag war, dass alle Fliesenfarben gleich sein müssen)
		- daraus kann ein **Mangel** entstehen: das ist, wenn eine Anforderung nicht erfüllt wird, der den tatsächlichen Gebrauch beeinträchtigt
	- Schaden: kann aus Fehlern / einem Mangel entstehen
		- meist wirtschaftlich, aber auch Ruf, Gesundheit etc.; Fehler mit Folgen
		- wirtschaftlich direkt messbar (Vermögensschaden)
		- z.B. wenn Sicherheitsbestimmungen nicht erfüllt wurden und was passiert - dann gibts nen großen Schaden

> [!note]
> Qualitätsmanagement: Fehler vermeiden, nicht nur auf Mangel oder Schaden reagieren!


## Qualität - Merkmale

Qualitätsmerkmale sind Anforderungen, welche die Qualität betreffen - also z.B. der Roboter muss den Lauf innerhalb von 20 Sekunden abfahren.

> [!note]
> Die Qualität einer Software und deren Erstellung wird durch die Erfüllung von Qualitätsmerkmalen definiert.
> 
> Ziel: Qualität transparent und messbar machen (--> Schritt zu Qualitätsmanagement & Qualitätsentwicklung


![[SPE 108 QUA v.25.1 Stud.pdf#page=14&rect=30,261,706,521|SPE 108 QUA v.25.1 Stud, p.14]]

- **Qualitätsstandards** wird durch den Erfüllungsgrad von Qualitätsmerkmalen definiert.
- diese Mermale sind teilweise durch Gesetze und Normen festgelegt und teilweise selbst definiert bzw. in Zusammenarbeit mit dem Auftraggeber
	- Beispiel: Lebensmittelhandel
		- gesetzlich: Reinheitsvorgaben, Hygienemerkmale müssen alle erfüllen
		- eigene Merkmale können z.B. Regionalität sein (Merkmale, die die gesetzlichen Regelungen übertreffen)
	- auch in Zusammenarbeit mit Auftraggeber wenn ein spezialisiertes Produkt entwickelt wird


![[SPE 108 QUA v.25.1 Stud.pdf#page=18&rect=33,54,930,519|SPE 108 QUA v.25.1 Stud, p.18]]
![[SPE 108 QUA v.25.1 Stud.pdf#page=19&rect=33,45,901,512|SPE 108 QUA v.25.1 Stud, p.19]]

- Merkmale der **Qualität im Einsatz**
	- Effektivität
	- Effizienz
	- Kontextvollständigkeit
	- Risikofreiheit (Minderung von Qualitäts und Sicherheitsrisiken)
	- ![[SPE 108 QUA v.25.1 Stud.pdf#page=21&rect=27,57,678,520|SPE 108 QUA v.25.1 Stud, p.21|450]]

- Merkmale schließen sich teilweise einander aus - Priorisierung der Qualitätsmerkmale
	- Bsp: Ein besonders sicheres Softwaresysem kann evtl. langsamer oder weniger einfach zu bedienen sein
	- siehe S.22 Folien
	- ![[Pasted image 20251127092011.png|350]]
- Es muss also in einem Projekt definiert werden, welche Qualitätsmerkmale **priorisiert** werden
- Das heißt: Merkmale zuerst definieren und dann beschreiben und priorisieren --> "Qualitätsgesteuerter Softwareentwicklungsprozess"
	- ![[Pasted image 20251127092136.png|400]]
		- "Am wichtigsten... in kürzester Zeit" - Priorität
		- Zeit - Maß
		- Sekunden - Maßeinheit
		- Stoppuhr - Messvorgang
		- max. 30 Sekunden - Schwellenwert

![[Pasted image 20251127092418.png|400]]


## Qualitätssicherung

### Ziel
- Sicherung der Einhaltung der Qualitätsmerkmale von Anfang an
- Qualität bleibt im Lauf eines Projekt bei akzeptablen Kosten maximal gleich --> möglichst früh beginnen mit Qualitätssicherung
- wenn man das nicht macht, dann kann das danach nur mehr teuer durch Umschreiben, Umgestaltung gemacht werden

### Qualitätssicherung Aufgaben

- **Qualitätsplanung**
	- Festlegen der Qualitätsmerkmale
	- laufendes Adaptieren
- **Qualitätsprüfung**
	- Prüfen der Projektgrundlagen (Bausteine, zugekaufte Komponenten)
	- laufendes Prüfen der Zwischenergebnisse
- **Qualitätslenkung** (= Anwendung von Maßnahmen zur Qualitätssicherung)
	- Organisatorische Maßnahmen zur Qualitätssicherung (während des gesamten Entwicklungsprozesses)
		- Verwenden von Normen
		- Erstellen von Richtlinien
		- Institutionalisieren der Qualitätssicherung (wirklich einbringen, als Einrichtung)
		- Weiterbilden der Entwickler
		- Verwenden von Vorgehensmodellen
	- Konstruktive Maßnahmen zur Qualitätssicherung (während der Erstellung von (Zwischen-)Produkten)
		- konsequent Doku schreiben
		- Einsetzen von Werkzeugen (z.B. Doxygen?)
		- Verwenden qualitätsgeprüfter Bausteine und Halbfabrikate
		- Methoden anwenden
	- Analytische Maßnahmen zur Qualitätssicherung (Verwendung zur Analyse erstellter (Zwischen-)Produkte)
		- Durchführen statischer und dynamischer Programmanalyse
		- Erstellen/Auswählen geeigneter Testfälle
		- laufendes Testen
		- Protokollieren der Ergebnisse
		- Dokumentieren der Fehlerbehebung


![[SPE 108 QUA v.25.1 Stud.pdf#page=29&rect=22,38,937,522|SPE 108 QUA v.25.1 Stud, p.29]]


### Qualitätssicherung – Techniken

> [!note]
> Techniken der Qualitätssicherung beziehen sich nicht auf das Produkt, sondern (vorrangig) auf den Prozess.
> Einhalten einer Norm oder Verwendung eines Modells/Verfahrens zur Qualitätssicherung heißt nicht automatisch hohe Qualität, sondern nur Offenlegung der Qualität des (Produktions-)Prozesses.

 - Dabei geht es um Vorgehensweisen in der Qualitätssicherung und nicht um die Qualität des Produktes selbst.
 - Wenn also die Anforderungen für die Arbeitsweisen erüllt sind, heißt das noch nicht, dass das Produkt gut ist

### Qualitätssicherung Ergebnisse

***Qualitätshandbuch***:
- Pflicht in gewissen, v.a. sicherheitskritischen Branchen
- ansonsten sehr wichtig für die Transparenz

**schriftliche Dokumentation:**
- des Anwendungsbereichs der Qualitätssicherung (Ausschlüsse begründen)
- der Verfahren zur Qualitätssicherung (Planung, Prüfung und Lenkung)
- des Zusammenspiels der Qualitätssicherungsprozesse in Europa vielfach nach ISO 9000 ff. strukturiert (seit Okt. 2015 auch rein elektronisch erlaubt – ISO 9001:2015)



# Ausblick: Qualitätsmanagement, Qualitätsentwicklung

![[SPE 108 QUA v.25.1 Stud.pdf#page=43&rect=30,31,889,513|SPE 108 QUA v.25.1 Stud, p.43]]Wenn man die Anforderungen also über das Maß hinaus erfüllt, dann ist die Kundenzufriedenheit hoch.
Die Bedeutung von Anforderungen ändern sich aber. - Eine Pferdekutsche erfüllt das gleiche Grobziel wie ein PKW - und beides soll auch schnell sein. Trotzdem muss ein PKW aktuell schneller sein als eine Pferdekutsche

![[SPE 108 QUA v.25.1 Stud.pdf#page=45&rect=28,35,893,518|SPE 108 QUA v.25.1 Stud, p.45]]


# Normen und Richtlinien

### Norm
- durch (über-)staatliche bzw. davon beauftragte Einrichtung erstellt
- in bestimmten Fällen Gesetzescharakter (verpflichtend!)
- Verbindlichkeit oft auch ohne explizite Erwähnung im Projektvertrag

> [!quote]
> „Normen [sind] per se keine rechtsverbindlichen Vorschriften, sondern nur rein technische Empfehlungen. … Sobald sie in Verträgen, Gesetzen oder Verordnungen zitiert werden, gelten sie als verbindlich.“ (help.gv.at)

Beispiel: Eine EU-Norm beendete das Kabelchaos unter den Smartphones.


### Richtlinie
- auch durch Unternehmen(sverbände), Interessensgruppen etc. erstellt
- darf verpflichtenden Normen nicht widersprechen
- Verbindlichkeit nur bei expliziter Erwähnung im Projektvertrag

![[SPE 108 QUA v.25.1 Stud.pdf#page=62&rect=27,49,859,514|SPE 108 QUA v.25.1 Stud, p.62]]![[SPE 108 QUA v.25.1 Stud.pdf#page=63&rect=33,210,853,518|SPE 108 QUA v.25.1 Stud, p.63]]

### Normen und Richtlinien in der Softwareentwicklung
Schwerpunkte sind:
- Benutzerschnittstellen
- Datenbanken
- Schnittstellentechnik
- Anwendungsprogrammierung (APIs)
- Dokumentation
- Services
- System- und Betriebssicherheit (Security, Safety)
- Usability

### Normenauswahl

**Offizielle Vorgehensweise:**
1. internationale Normen
2. Normen von Staatenverbänden (z.B. EU)
3. länderspezifische Normen
4. Richtlinien von internationalen Vereinigungen und Verbänden
5. Kundenrichtlinien
6. unternehmensinterne Richtlinien

Das ist eine Hierarchie von Grob nach fein.
- internationale Norm gefunden - take it - wenn nicht, dann EU-Norm, dann AT-Norm usw.
- eine Norm ist nicht umbedingt Gesetz. Manchmal ist die Einhaltung von Normen aber gesetzlich verpflichtend, dann gilt die
- stärker geht immer - d.h. wenn ich unternehmensintern strengere Richtlinien als Qualitätsmerkmal habe, dann gilt die auch

**"Vorgehensweise“ in der Praxis**
1. unternehmensinterne Richtlinien und Vorschriften
2. Management und Mitarbeitern „verkaufbare“ Vorschriften