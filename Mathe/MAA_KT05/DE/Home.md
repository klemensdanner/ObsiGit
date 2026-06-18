# Mathematik fur Software Engineering -- Wissensbasis

Willkommen! Dies ist eine ausfuhrliche Referenz fur die Themen der linearen Algebra, die im MAA-Kurs an der FH Hagenberg behandelt werden.

## Was dich hier erwartet

Diese Wissensbasis deckt drei miteinander verbundene Themen aus der linearen Algebra ab, aufbauend auf den Ubungsblattern UE_10 und UE_11 sowie dem Lehrbuch (Dreiseitl, *Mathematik fur Software Engineering*, Kapitel 5.2-5.5):

- **[[Lineare-Gleichungssysteme|Lineare Gleichungssysteme]]** -- Losen von $Ax = b$ mit der Gauss-Elimination
- **[[Matrix-Inverse|Matrixinversion]]** -- Berechnen von $A^{-1}$ und Verstehen, wann sie existiert
- **[[Kern|Kern]]** -- Die Menge der Vektoren, die eine lineare Funktion auf Null abbildet

## Ich mochte...

| Aufgabe | Gehe zu |
|---------|---------|
| ...ein lineares System $Ax = b$ losen | [[Lineare-Gleichungssysteme]] $\to$ [[Gauss-Elimination]] |
| ...eine Matrix invertieren | [[Matrix-Inverse]] $\to$ [[Gauss-Jordan]] |
| ...einen Kern berechnen | [[Kern]] $\to$ [[Kern-Berechnen]] |
| ...prufen, ob eine Matrix invertierbar ist | [[Regulaere-Matrix]] |
| ...eine Determinante berechnen | [[Determinante]] |
| ...die Losungsstruktur verstehen | [[Loesungsmenge]] $\to$ [[Kern-vs-Loesungsmenge]] |
| ...eine Definition schnell nachschlagen | Suche oder Graph-Ansicht nutzen -- jeder Begriff ist verlinkt |

## Lernpfade

Je nach Ziel wahle einen dieser Pfade:

### Pfad A: Konzept-orientiert (Theorie verstehen)

```
Vektor -> Matrix -> Lineare-Funktion -> Linearkombination
                                         |
                                   Lineare-Gleichungssysteme -> Gauss-Elimination
                                         |
                                   Kern -> Kern-und-Bild
                                         |
                                   Matrix-Inverse -> Regulaere-Matrix
```

Beginne bei [[Vektor]] und folge den Links. Jede Datei fuhrt ihre Voraussetzungen oben und die nachsten Schritte unten auf.

### Pfad B: Rechen-orientiert (Ubungsblatter losen)

```
Gauss-Elimination -> Gauss-Elimination-Beispiele
        |
Obere-Dreiecksform -> Loesungsmenge
        |
Kern-Berechnen -> Kern-vs-Loesungsmenge
        |
Gauss-Jordan -> Determinante
```

Beginne bei [[Gauss-Elimination]] -- du lernst den Kernalgorithmus zuerst und holst die Theorie bei Bedarf uber Ruckverweise nach.

## Themenubersicht

| Thema | Hauptseite | Inhalt |
|-------|------------|--------|
| **Gleichungssysteme** | [[Lineare-Gleichungssysteme]] | $Ax = b$, Gauss-Elimination, Losungstypen, homogen vs. inhomogen |
| **Matrixinversion** | [[Matrix-Inverse]] | $A^{-1}$, Gauss-Jordan, regulare/singulare Matrizen, Determinanten |
| **Kern** | [[Kern]] | $\operatorname{Kern}(f)$, Kern berechnen, Rangsatz, Kern und Losungsmengen |

## Wie du diese Wissensbasis nutzt

- **Fahre** uber einen Link, um eine Vorschau des Dateiinhalts zu sehen
- **Folge** den Links, um tiefer in ein Konzept einzutauchen
- **Ruckverweise** (in der rechten Seitenleiste von Obsidian) zeigen dir, welche Dateien auf die aktuelle verweisen
- **Graph-Ansicht** visualisiert, wie alle Konzepte zusammenhangen -- die drei Themenhubs bilden Speichen um den Voraussetzungskern
- **`> [!warning]`-Hinweise** markieren Inhalte, die besonders prufungsrelevant sind

> [!tip] Profi-Tipp
> Der grosste Teil des Inhalts steckt hinter den Links -- die Hauptseiten sind bewusst knapp gehalten. Vorschau zum Uberfliegen, Klick zum Eintauchen.

---

> [!info] English: [[../EN/Home]]

*Zuletzt aktualisiert: 2026-06-09*
