Ein Prozess ist eine Instanz eines Programms in einer gewissen vom Betriebssystem bereitgestellten Umgebung.
Ein Prozess besteht aus
- Process ID
- instruction pointer
- Register / Variablen

OS führt Prozesse pseudoparallel aus.
Prozesse entstehen beim Starten des OS, oder werden durch den Benutzer gestartet (durch Starten einer App), oder von einem anderen Prozess erzeugt.

### Prozesserzeugung
Prozesse können mit einem Systemcall erzeugt werden, z.B. fork() bei Linux.
fork() hat einen Rückgabewert
- der ist 0, wenn man sich im child Prozess befindet
- PID des Child processes, wenn man im Elternprozess ist.
- execve ersetzt den aktuellen Prozess durch einen anderen
- dadurch kann man Prozesse (auch andere Programme) erzeugen


### Prozessbeendigung
Wie kann ein Prozess beendet werden?


### Prozesszustände
Welche Prozesszustände gibt es?


### Prozesstabelle
Was ist ein PCB und was wird darin gespeichert?