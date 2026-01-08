# Linux Cheat Sheet (Kurz & Klar)

## Allgemein
- `cal` – Kalender
- `hostname` – Rechnername
- `id` – UID/GID
- `ps` – laufende Prozesse
- `uname -a` – Systeminfo
- `tty` – aktuelles Terminal
- `who` – eingeloggte User
- `whoami` – aktueller User
- `man <cmd>` – Manual
- `less <file>` – Datei paginieren
- `which <cmd>` – Pfad zum Programm
- `bc` – Rechner

## Dateien & Verzeichnisse
- `ls -a` – inkl. versteckte
- `ls -l` – Longlist
- `ls -d */` – nur Verzeichnisse
- `ls -R` – rekursiv
- `mkdir -p` – Unterordner automatisch
- `rmdir` – leeres Verzeichnis löschen
- `rm -r` – rekursiv löschen

## Wildcards / Globs
- `*` – beliebige Zeichenfolge
- `?` – genau ein Zeichen
- `a[abc]` – aa, ab, ac
- `a[!abc]` – alles außer a,b,c
- `\` – escapen
- **Brace expansion:** `mkdir x/{a,b,c}` → xa, xb, xc

## mv / cp
- `mv f1 f2 dir/` – beide in dir
- `mv f1 dir/new` – umbenennen
- `cp f1 f2` – kopieren & umbenennen
- `cp -R dir1 dir2` – rekursiv

## Text & Streams
### cut
- `-d` delimiter
- `-f` Felder
- `-c` Zeichen
- `cut -f2,3 file | cut -c1-3`

### tr
- `tr a-z A-Z` – ersetzen
- `tr -d "x"` – löschen
- `tr -s " "` – mehrere Spaces → 1

### sort
- `-n` numerisch
- `-r` reverse
- `-t <char>` delimiter
- `-k2` sortieren nach Spalte 2
- Bereiche: `-k2,3`

### uniq
- doppelte Zeilen zusammenfassen
- `uniq -c` – zählen
*(wirkt nur auf benachbarte Zeilen → oft vorher sort)*

### head / tail
- `head -n5` – erste 5
- `tail -n5` – letzte 5

### wc
- `-l` Zeilen
- `-w` Wörter
- `-c` Bytes
- `-L` längste Zeile

## sed (Basics)
- `sed 's/a/b/'` – erste Ersetzung pro Zeile
- `sed 's/a/b/g'` – global
- `sed -n '5p'` – Zeile 5 ausgeben
- `sed '1,3d'` – Zeilen 1–3 löschen
- `sed -i 's/x/y/g' file` – in-place edit
