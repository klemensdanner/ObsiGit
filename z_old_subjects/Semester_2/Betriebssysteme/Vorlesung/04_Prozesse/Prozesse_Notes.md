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



### Context Switch - Beispiel eines Interrupts:
- CPU sieht das gesetzte Bit am PIC
- Aktueller PCB (process control block) wird gesichert, d.h.:
	- instruction pointer sichern
	- Register sichern
	- Modus (rechnend, rechenbereit, blockiert)
	- Stackpointer
- CPU acknolaged an den PIC dass sie bereit ist, dieser schickt die Interrupt Nummer
- CPU schaut in der Interrupt Descriptor Table nach der Adresse des richtigen Interrupt Handlers (z.B. ein Treiber für eine Maus), und führt diesen aus.
- Dieser Interrupt Handler blockiert für einen Moment andere interrupts, damit die Aufgabe sicher ausgeführt wird.
- Wenn die Aufgabe abgeschlossen ist, wird der Scheduler aufgerufen, der entscheidet, welcher Prozess als nächstes drankommt.
- PCB des ausgewählten Prozesses wird in die CPU kopiert und der Prozess wird fortgeführt

### Scheduling

Was ist das?
Welche Ziele hat ein Scheduler?

Was ist Preemtive Scheduling vs. non-preemtive Scheduling?
Auf welcher Basis kann man entscheiden, welcher Scheduling Algo für das eigene System gut ist?


### Scheduling Algorithmen
#### First come, first served (FIFO)
- non preemptive (Programme müssen die CPU freigeben)

Funktion:
Nachteil:

#### Round Robin
Funktion:
Vorteil:
Nachteil:


#### Prioritäts-Scheduling
Konzept:
Statisch:
Dynamisch:
Beispiel für dynamisch:



#### Multilevel Feedback Queues (MLFQ)
Warum MLFQ?
Unterschied zu Priority Scheduling?
- es wird zusätzlich noch die zeit erhöht, die ein niedrig priorisierter prozess hat
- d.h. er hat dann höhere zeit kommt aber seltener dran
Vorteile zu Priority Scheduling

Die Hoffnung ist, niedrigpriore Prozesse in einem Stück abzuarbeiten und die Response Time der hochprioren Prozesse zu erhalten, da sie weiterhin oft drankommen.


### Completely Fair Scheduler (CFS)



	

#### EEVDF




















