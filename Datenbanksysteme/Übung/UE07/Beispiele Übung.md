```
fichte = sigma Name='Fichte' (Studenten)
vorlesungen = fichte join hoeren join Vorlesungen
professoren = vorlesungen join gelesenVon=PersNr (Professoren)
pi Professoren.Name (professoren)

-- 1. Schritt: Im Schema, den Tabellen schauen
-- Abbilden über Joins mit Zwischentabellen
-- Projezieren auf das was man braucht
```


```
-- welcher prof min. 2 vorlesungen
-- abbilden mit verbund mit sich selbst
p1 = rho p1 (Professoren)
p2 = rho p2 (Professoren)
p1 join p1.PersNr=p2.PersNr p2 
```


```
-- welcher prof min. 2 vorlesungen
-- abbilden mit verbund mit sich selbst
v1 = rho v1 (Vorlesungen)
v2 = rho v2 (Vorlesungen)
join v1 v1.gelesen-- welche Studenten hören keine Vorlesungen

-- Studenten anti join hoeren -- die, die sich nicht verbinden lassen

s = pi MatrNr (Studenten)
h = pi MatrNr (hoeren)
fauleSaecke = s - h
Studenten join fauleSaeckeVon=v2.GelesenVon (v2)
```


```
-- sigma Name='Popper' (Professoren)
-- pi Raum (Professoren)
-- pi Rang (Professoren)

-- Studenten join hoeren join Vorlesungen -- Natürlicher Verbund

-- Vorlesungen join gelesenVon=PersNr Professoren
-- Vorlesungen full outer join gelesenVon=PersNr Professoren -- wenn ein Professor keine vorlesung liest oder zu einer Vorlesung kein Professor existiert, wir das td angezeigt, in der jeweils anderen Spalte steht dann Null



-- pi Raum (sigma Name='Popper' (Professoren)) -- zuerst die Selektion, sonst ist kann man die Zeile nicht mehr auswählen, weil es keinen Professornamen gibt

-- popper = sigma Name='Popper' (Professoren) -- quasi variable erstellen
-- pi Raum (popper)
```


```
-- welcher prof min. 2 vorlesungen
-- abbilden mit verbund mit sich selbst
v1 = rho v1 (Vorlesungen)
v2 = rho v2 (Vorlesungen)
v1 join v1.gelesenVon=v2.GelesenVon (v2)

```


```
fichte = sigma Name='Fichte' (Studenten)
vorlesungen = fichte join hoeren join Vorlesungen
professoren = vorlesungen join gelesenVon=PersNr (Professoren)
pi Professoren.Name (professoren)

-- 1. Schritt: Im Schema, den Tabellen schauen
-- Abbilden über Joins mit Zwischentabellen
-- Projezieren auf das was man braucht
```


```
-- welche Studenten hören keine Vorlesungen

-- Studenten anti join hoeren -- die, die sich nicht verbinden lassen

s = pi MatrNr (Studenten)
h = pi MatrNr (hoeren)
fauleSaecke = s - h
Studenten join fauleSaecke
```
