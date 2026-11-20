> [!PDF|note] [[f-intro-hwp.pdf#page=6&selection=21,27,21,30&color=note|f-intro-hwp, p.6]]
> > MMU
> 
> Keine MMU heißt - kein virtual memory, somit kann nur ein Prozess laufen


## Vergleich zur "normalen" Softwareentwicklung
- läuft im "kernel space"
-

> [!PDF|important] [[f-memory.pdf#page=10&selection=19,0,19,5&color=important|f-memory, p.10]]
> > GPIOs
> 
> General Perpose Input Output

GPIOs sind am Anfang by default für input konfiguriert

> [!PDF|note] [[f-memory.pdf#page=12&selection=18,0,18,18&color=note|f-memory, p.12]]
> > Alternate Function
> 
> Logik ist in Hardware implementiert, sodass auf einem Pin gleichzeitig mehrere Signale gleichzeitig gesendet werden können, d.h. eine Logik damit Gesendete INformationen nicht kollidieren


> [!PDF|note] [[f-memory.pdf#page=12&selection=22,0,23,11&color=note|f-memory, p.12]]
> > Analog (f¨ur DAC/ADC)
> 
> ist implementiert auf Hardware bei manchen Pins (DAC / ADC)


> [!PDF|note] [[f-memory.pdf#page=12&selection=30,0,30,29&color=note|f-memory, p.12]]
> > Pull-Up/Pull-Down Widerstand 
> 
> ?

-- okay das mit pull up und pull down  ist nicht so genau gemeint, einfach wissen dass es sie gibt und dass man den richtigen schalter verwenden muss!

> [!PDF|note] [[f-memory.pdf#page=23&selection=105,1,109,17&color=note|f-memory, p.23]]
> > ( GPIO_TypeDef *) (0 x42020800UL ) 
> 
> das ist ein cast von der Adresse auf einen GPIO_TypeDef Pointer


> [!PDF|note] [[f-memory.pdf#page=21&selection=8,10,8,15&color=note|f-memory, p.21]]
> > GPIOC
> 
> der Button hängt an port C, Pin 13


> [!PDF|note] [[f-memory.pdf#page=25&selection=14,0,22,3&color=note|f-memory, p.25]]
> > REG |= (1 << 5) 
> 
> im Register steht vll schon was drin, man kann also nicht den wert überschreiben
> deshalb verodert man bitweise, dadurch steht an pos 5 ein 1


> [!PDF|note] [[f-memory.pdf#page=25&selection=39,0,47,3&color=note|f-memory, p.25]]
> > REG &= ~(1 << 5) 
> 
> 1<<5 hat einen 1 an pos 5, sonst 0. durch die tilde wird das negiert.
> dadurch nur 1, 0 an pos 5. durch verunden bleibt jeder wert gleich, außer an pos 5, dort ist der Wert auf jeden Fall 0


> [!PDF|note] [[f-memory.pdf#page=25&selection=65,0,75,4&color=note|f-memory, p.25]]
> > if ( REG & (1 << 5) )
> 
> wenn in Reg an pos 5 der wert 1 ist, dann wird die verundung genau dort 1 haben.
> Damit ist der Gesamtausdruck auf jeden Fall > 0 und wird von if somit als true gewertet

