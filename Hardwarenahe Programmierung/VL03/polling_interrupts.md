> [!PDF|yellow] [[f-polling-interrupts.pdf#page=4&selection=10,0,10,7&color=yellow|f-polling-interrupts, p.4]]
> > Polling
> 
> Nachteil: Kostet perforamcne, vorteil: easy zu implementieren

Interrupts: Unterbegriff ist ein Interrupt

> [!PDF|yellow] [[f-polling-interrupts.pdf#page=7&selection=67,0,73,15&color=yellow|f-polling-interrupts, p.7]]
> > uint32_t button_pressed = button_get () ;
> 
> Nachteile bei Polling hier:
> - Je nachdem ob der Button gedrückt wird dauert ein schleifendurchlauf länger
> - Man kann es verpassen, dass der button gedrückt wurde (zwischen den Abfragen, es wird nur all x Zeiteinheiten (je nachdem wie lang der Code braucht) geprüft, dazwischen nicht)

> [!PDF|yellow] [[f-polling-interrupts.pdf#page=9&selection=9,0,9,4&color=yellow|f-polling-interrupts, p.9]]
> > NVIC
> 
> Stack aus interrupt handlers - der Interrupt handler kann von einem anderen interrupt unterbrochen werden - wenn der wichtiger ist wird der zuerst ausgeführt und dann erst der andere fertig gestellt

> [!PDF|yellow] [[f-polling-interrupts.pdf#page=10&selection=12,1,12,10&color=yellow|f-polling-interrupts, p.10]]
> > Interrupt
> 
> Dort wird je nach interrupt direkt die richtige Funktion gefunden und danach wird diese ausgeführt


> [!PDF|yellow] [[f-polling-interrupts.pdf#page=15&selection=43,0,43,12&color=yellow|f-polling-interrupts, p.15]]
> > SCB - > VTOR
> 
> Vector table offset register

> [!PDF|yellow] [[f-polling-interrupts.pdf#page=16&selection=17,2,17,6&color=yellow|f-polling-interrupts, p.16]]
> > word
> 
> word ist ein default datentyp, z.B.  ein 64Bit datentyp bei einer 64Bit cpu



> [!PDF|yellow] [[f-polling-interrupts.pdf#page=27&selection=30,19,31,1&color=yellow|f-polling-interrupts, p.27]]
> >  ,
> 
> 0 ist falsch

> [!PDF|yellow] [[f-polling-interrupts.pdf#page=27&selection=9,0,9,8&color=yellow|f-polling-interrupts, p.27]]
> > volatile
> 
> Wert soll nicht gecached werden sondern immer aus dem Speicher neu gelesen

