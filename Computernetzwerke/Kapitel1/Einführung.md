Use Cases von Computernetzwerken
 - Zugriff auf entfernte Datenbanken
 - Kommunikation zwischen Applikationen
 - oft ist Kommunikation zwischen Endsystemen nicht direkt, sondern über Router, Server etc.
 - Komponenten: Endsysteme, aktive Netzwerksysteme, Netzwerkumsetzer (Netzwerkkarten etc.)

## Übertragungskanäle
- Verbindungen werden über Kanäle herstellt
	-  drahtgebunden (Kupfer, Glasfaster)
	- drahtlos (elektromagnetische Wellen benötigen kein Medium, theoretisch auch im Vakum)
- Kanäle haben Qualitätseigenschaften (QoS-Kriterien)
	- Fehlerrate (z.B. bei digitaler Kommunikation: BER; Bit Error Rate)
	- Bandbreite (wie viel Information kann pro Zeiteinheit übertragen werden)
	- Ausbreitungsgeschwindigkeit und Distanz (wie lange dauert die Übertragung von Informationen) - Unterscheidung zur Bandbreite!
		- Geschwindigkeiten sind relativ gesetzt - elektromagn. Wellen  - Lichtgeschwindigkeit, Kupferkabel ist speed auch relativ konstant - bei schlechten Kabel steigt eher die bit error rate
## Übertragungsrichtung
- Simplex: Kommunikation nur in eine Richtung (Radio)
- Halfduplex: Kommunikation abwechselnd in beide Richtungen möglich (z.B. Walkie Talkie)
	- zur einer Zeit ist immer nur eine Richtung möglich
	- mit einem Kanal kann immer nur eine Richtung übertragen werden
- Duplex: beide richtungen gleichzeitig - zwei Kanäle

Ein Kanal ist i.d.R eine "Übertragungseinheit", z.B. ein Frequenzbereich oder ein Kupferkabel. Dabei geht ein Kanal immer nur in eine Richtung. Wenn in einem Kanal beide Richtungen oder unterschiedliche Informationen übertragen werden müssen, gibt es Workarounds - z.B. Zeitaufteilung (erste zehntel Sekunde ist Anwendung 1, dann Anwendung 2 etc.)

## Kommunikationsteilnehmer

--> logische Konzepte
- 1:1 Kommunikation
- 1:n Kommunikation (Fernsehen - Receiver stellt einfach Frequenz ein und empfängt)
- n:n Kommunikation
	- viele senden, viele horchen

Folien: Netzwerke, Routing, etc.
Man will Netzwerke unterteilen, wenn sie größer werden (Sicherheit und Praktikabilität)

# Kommunikation

### Kommunikationsschema
- 3-Schichten Modell (Information, Nachricht, Signal)
- 2-stufige Codierung / Decodierung

**Semantik**: vorab geteiltes Wissen; wie werden Datenströme interpretiert - Protokoll
Protokoll ist eine Vorschrift für Codierung und Decodierung
**Syntax**: in welchen Bitmustern wird das übertragen (also wenn es bereits codiert ist), was ist eine gültige Nachricht: z.B. im 1. Byte steht eine Information welche Nachricht übertragen wird etc. legt fest, welche Bitmuster wohlgeformt sind
**Signalebene**: wie wird dieses Bitmuster übertragen (meistens analog; also die technische Realisierung)

preshared knowledge: Protokoll bzw. in der Analogie eine Sprache

Analgoie: normales Sprechen:
**Informationsebene**: Bedeutung des Gesprochenen, Inhalt
**Nachrichtenebene**: Codierung: Formulierung der Gedanken in Worte, Decodierung: Empfänger versteht die Worte als sinnvolle Sätze
**Signalebene**: über Schall wird die Syntax übertragen


### 1.2. Kommunikation
- Signalebene: Fehler bei Übertragung selber; Bitfehler
	- schelcht wenn bei einem Bitfehler eine andere gültige Nachricht rauskommt, weil man dann den Fehler nicht erkennt
- Nachrichtenebene; Fehler bei Signalcodierung (z.B. kyrillisch C klingt wie das S in unserer Schrift)
und Weiteres in den Folien

#### Protokolle
- preshared knlowledge
- spezifizieren das Format und die Bedeutung der Nachrichten
- legen Regeln für den Datenaustausch fest
- Maßnahmen für Fehler- und Ausnahmesituationen (z.B. bei Fehlererkennung wird eine neue Sendung requested, oder forward error correction durch Redundanz in den Bitmustern)

#### Schema für Maschinenkommunikation
Quelle (z.B. Sensor) - (ADC / Digitalkonverter) - Quellcodierung (Redundanz hinzufügen oder komprimieren) - Protokoll Funktionen - Kanalcodierung - Modulation (technische Vorbereitung für die Übertragung) - **Kanal** - Demodulation - Kanal Dekodierung - Funktionen  - Quell Decodierung - DAC (Digital-Analogconverter) - Senke (z. B. Anwendung oder auch Hardware (Lampe oder sowas))
Jedes Endgerät hat ein Netzgerät - es kann bei der Übertragung auch mehrere Netzgeräte geben


### Architekturmodelle
Anforderungen an ein Computernetz
- Zuverlässigekeit
- Fairness: Netzressourcen sollen fair aufgeteilt werden
- Effizienz: Übertragen von Daten soll die Ressourcen gut nutzen
- Performanz: Latenzen so kurz und konstant wie möglich
- Sicherheit: Datenübertragung soll nicht abgehört oder manipuliert werden

