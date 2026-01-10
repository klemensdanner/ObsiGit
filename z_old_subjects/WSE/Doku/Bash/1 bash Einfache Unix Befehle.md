Ein Command lässt sich abbrechen mit Strg + C

~ signalisiert das Homeverzeichnis

```bash
klemens@Klemens:~$ mkdir UEBUNG1/DIR1/DIR11/DIR111
mkdir: cannot create directory ‘UEBUNG1/DIR1/DIR11/DIR111’: No such file or directory
```
Lösung:
```
mkdir UEBUNG1/DIR1/DIR11/DIR111 -p
```
-p make parent directory if non existent


Ein Verzeichnis lässt sich "überwachen" mit: alle 0,2 Sekunden ausgeführt
```
klemens@Klemens:~$ watch -n.2 'Command'
```


Mit diesem Befehl werden 3 files erstellt.
```
klemens@Klemens:~$ touch ./UEBUNG1/DIR1/DIR12/file{3,4,5}
```

bei -R rekursiv


Kopieren:
cp: Kopiert die files "file4" und "file5"
```
klemens@Klemens:~/UEBUNG1/DIR2$ cp ~/UEBUNG1/DIR1/DIR12/file{4,5} .
```

Bei cp von Verzeichnissen braucht man -r
rm löscht Verzeichnisse nur mit -r, ansonsten nur Dateien, egal ob leer oder nicht
rmdir löscht standardmäßíg nur leere Verzeichnisse

Bei cp in ein Verzeichnis, wo die zu kopierende Datei bereits existiert, würde die Datei überschrieben werden. Bei cp -i, wird nachgefragt