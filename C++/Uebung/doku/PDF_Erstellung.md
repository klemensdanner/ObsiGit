# PDF für Übung 3 erneut erstellen

## Wiederhergestelltes Skript

[`uebung3_pdf_build.py`](uebung3_pdf_build.py) wurde aus den ursprünglichen Schreibvorgängen im lokalen Sitzungsprotokoll wiederhergestellt. Die erste Fassung und alle fünf späteren Änderungsschritte wurden in ihrer ursprünglichen Reihenfolge angewendet. Der Python-Code wurde dabei nicht neu entworfen oder verallgemeinert.

Das Skript liegt nun dauerhaft in diesem Projektordner. Es sollte zusammen mit der Markdown-Datei in Git aufgenommen oder anderweitig gesichert werden.

## Aufruf

Aus diesem Ordner:

```bash
python3 uebung3_pdf_build.py
```

Das Skript liest `Übung_3_optimized.md` und schreibt `output/pdf/Übung_3_optimized.pdf`. Eine bereits vorhandene PDF an dieser Stelle wird ersetzt. Die Markdown-Datei bleibt unverändert.

## Voraussetzungen

- Python 3
- Python-Pakete `reportlab`, `markdown-it-py` und `pygments`
- Die im Skript referenzierten Schriftdateien für Lato, Fira Code und DejaVu Sans

Der ursprüngliche Projektpfad ist in `ROOT` fest eingetragen. Nach dem Verschieben des Projekts muss dieser Pfad angepasst werden. Auch die Schriftdateien verwenden absolute Linux-Pfade.

## Wofür lässt sich das Skript wiederverwenden?

**Für aktualisierte Fassungen derselben Übung:** Text und Code in der Markdown-Datei können geändert und die PDF anschließend neu erzeugt werden. Inhaltsverzeichnis, Lesezeichen und Seitenzahlen werden beim Erstellen neu berechnet. Nach größeren Änderungen sollten die Seitenumbrüche kontrolliert werden.

**Als Grundlage für andere Lernskripte:** Typografie, Codeformatierung, Tabellen und Merkkästen können übernommen werden. Der aktuelle Stand ist jedoch auf dieses Dokument zugeschnitten:

- Eingabe- und Ausgabedatei sind fest vorgegeben.
- Titelblatt, Kopfzeilen, Lernziel und die Angabe „13 Kapitel“ sind fest eingetragen.
- Kapitelüberschriften müssen dem verwendeten nummerierten Schema folgen; einzelne Kapitel erhalten besondere Seitenumbrüche.
- Die beiden mathematischen Formeln werden speziell für diese Übung gezeichnet. Andere Formeln werden nicht allgemein aus LaTeX umgesetzt und erfordern eine Anpassung.
- Einige Einleitungstexte und der Lösungsteil werden anhand bestimmter Textstellen erkannt.

Vor der Verwendung für andere Dokumente müssten diese Annahmen entfernt oder konfigurierbar gemacht werden. Für beliebige Markdown-Dateien ist das Skript derzeit kein allgemeiner Konverter.

## Kontrolle nach dem Erstellen

Die PDF im PDF-Betrachter öffnen und insbesondere Tabellen, lange Codeblöcke, Formeln und Seitenübergänge prüfen. Das Skript erstellt das Layout; die visuelle Prüfung und die C++-Tests sind separate Schritte.

Für eine Seitenvorschau kann zusätzlich das Poppler-Werkzeug `pdftoppm` verwendet werden:

```bash
mkdir -p /tmp/uebung3-preview
pdftoppm -scale-to 1200 -png output/pdf/Übung_3_optimized.pdf /tmp/uebung3-preview/seite
```

Die erzeugten Vorschaubilder liegen nur temporär unter `/tmp`. Die wichtigen Projektdateien bleiben in diesem Ordner.
