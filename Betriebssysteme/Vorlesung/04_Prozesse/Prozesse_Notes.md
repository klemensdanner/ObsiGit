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
- hat die Aufgabe erledigt und beendet freilwillig (exit 0)
- beendet freiwillig aufgrund eines Fehlers
- schwerwiegender Fehler beendet das Programm unfreiwillig
- anderer Prozess beendet den Prozess (kill())
### Prozesszustände
Welche Prozesszustände gibt es?
- rechnend
- rechenbereit
- blockiert (z.B. wartet auf userinput
### Prozesstabelle
Was ist ein PCB und was wird darin gespeichert?
Einträge der Prozesstabelle nennt man Process Control Blocks. Diese speichern den kompletten aktuellen Stand einer Prozessausführung - d.h.:
- Register der CPU
- CPU Flags
- Stackpointer
- instruction pointer
- Prozesszustand
- Programmstatuswort (Zustand Userspace oder Kernelspace?)
- ProcessID

Diese Tabelle ist wichtig für Context Switches, d.h. wenn zwischen den Prozessen gewechselt wird. Der Programmstand muss dabei zwischengespeichert werden, damit an genau dieser Stelle weitergerechnet werden kann.

### Threads
Was ist ein Thread und was sind die Unterschiede zu einem Prozess und wo liegen die Vor- und Nachteile?

Ein Thread ist ein Ausführungspfad innerhalb eines Prozesses. Es können mehrere Prozesse 

THREADS NOCH MAL ANSCHAUN


### IPC - Inter Process Communication
- Informationsweitergabe
- Synchronisation (Warten auf anderen Prozess / Thread)
- Abhängigkeiten: Gemeinsame Abarbeitung eines Programms von mehreren Prozessen - Reihenfolge muss stimmen



### Scheduling

Was ist das?
Welche Ziele hat ein Scheduler?
Was ist Preemtive Scheduling?
