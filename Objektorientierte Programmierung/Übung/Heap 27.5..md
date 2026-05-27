- kompletter Binärbaum

umgesetzt als Array, man fängt bei 1 an

l.kind: 2 \* i
r.kind: 2\* i + 1

Elternknoten in beiden Fällen: i / 2 (Ganzzahldivision)


## Einschub: PRNG (Pseudo Random Number Generator)

Qualitätsmerkmale:
- sind Verteilungseigenschaften erfüllt
- was ist die Periodenlänge? Es gibt eine begrenzte Anzahl an inneren Zuständen --> dadurch gibt es immer eine Periodenlänge, ab der sich die Sequenz wiederholt
- z.B. innerer Zustand hat 48 Bit -- es gibt 2^48 innere Zustände, also gibt es auch nur so viele unterschiedliche Zufallswerte