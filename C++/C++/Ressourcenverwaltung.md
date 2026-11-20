RAII: Ressourcen an die objekt lifetime binden
ressourcenmangmant wird idealerweise komplett abgegeben - wenn man nur einfache Datentypen verwendet, kann der compiler selber copy constructor usw machen (rule of zero)

ownership muss klar sein (zeiger vs referenz übergeben)

std:move() macht etwas movabel - xvalue
wenn das interface nur einen rvalue nimmt ist das okay, ein xvalue is-a rvalue

> [!PDF|note] [[11-C++-Ressourcenverwaltung.pdf#page=16&selection=46,0,50,6&color=note|11-C++-Ressourcenverwaltung, p.15]]
> > if (this != &r)
> 
> sont würde man sich selbst löschen und dann gäbs nichts mehr zum zuweisen

> [!PDF|note] [[11-C++-Ressourcenverwaltung.pdf#page=17&selection=106,1,109,17&color=note|11-C++-Ressourcenverwaltung, p.16]]
> > → Copy & Swap Idiom
> 
> aber dann erstell ich ja wieder eine kopie

### Smart pointer





























