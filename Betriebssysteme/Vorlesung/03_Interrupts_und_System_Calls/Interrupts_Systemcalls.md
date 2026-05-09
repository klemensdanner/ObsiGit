Ein Interrupt ist das Aufzeigen eines Ereignisses einer HW Komponente
Vorteil: Polling (periodisches Abfragen) soll verhindert werden (braucht viel CPU Leistung bei vielen Geräten)
Das Hardwaregerät kann einen Interrupt Request schicken - darauf kann die CPU mit einem interrupt acknolage reagieren, dann schickt die HW Komponente Nutzdaten an die CPU. Ein Interrupt Handler (in der Software) reagiert auf diese Daten

Auch SW kann einen Interrupt auslösen. Sowas nennt man System Call.
Wenn das passiert, wird in den Kernel Mode gewechselt, die Aufgabe wird ausgeführt und dann zum Prozess zurückgekehrt.

### Ablauf Interrupt
Ein Programmable Interrupt Controller (PIC) fungiert als Multiplexer. Wenn ein Interrupt anliegt, setzt er ein Bit am Ausgang. Die CPU überprüft nach jeder Instruktion dieses Bit. Ist es gesetzt, sichert es den Zustand des aktuellen Prozesses (instruction pointer etc.) und gibt dem PIC ein acknolage, dass die CPU bereit ist. Der PIC sendet dann die Nummer des Interrupts. Diese ist einem interrupt handler zugeordnet, der dann aufgerufen wird.
Nach dem Beenden des Interrupt handlers, wird der vorherige Prozess fortgesetzt.

### Interrupt Handler
Werden von OS/Treibern bereitgestellt.






CPU verwendet eine interrupt descriptor table (IDT), die wird am Anfang in den RAM geladen.
Sie macht das Mapping von Interrupt Code to Interrupt Handler.
Während die wichtigsten Hardwaredaten ausgelesen wird, sind Interrupts blockiert. (zeitkritische Daten, sollen nicht unterbrochen werden) --> weitere Verarbeitung dieser Daten ist wieder weniger zeitkritisch --> z.B. Weiterleitung der Daten an obere Schichten (z.B. Dateisystem), da sind interrupts wieder aktiviert.