- spezifischere CSS regeln greifen stärker
- relative Größenangaben
	- %: Den Platz den er hat innerhalb eines Blocks, wird prozentual aufgeteilt
	- em: relativ zur schriftgröße des Vaterelements
	- rm: relatv zur schriftgröße vom browser#
	- vh: viewport height in prozent
	- vw: viewpoint width in prozent


## Specificity
Punktesystem:
id: 2 Punkte
Klasse: 1 Punkt
Tag: 1 Punkt

## Selektoren
- \#id
- \.class
- tag


CSS Box model anschauen content-box vs. border-box

nav ul li ---- alles was diese schachtelung hat wird selektiert; allerdings können dazwischen z.b. auch noch andere tags sein

nav>ul>li, dann müssen sie hintereinander kommen, glaub ich


"Pseudoklassen" werden mit einem Doppelpunkt angegeben; z.B. a:hover