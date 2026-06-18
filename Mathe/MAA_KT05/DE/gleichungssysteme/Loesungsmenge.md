# Losungsmenge eines linearen Systems

> **Voraussetzungen:** [[Lineare-Gleichungssysteme]], [[Gauss-Elimination]], [[Lineare-Mannigfaltigkeit]]

Jedes lineare System $Ax = b$ hat genau einen von drei moglichen Ausgangen. Die [[Gauss-Elimination|Gauss-Elimination]] offenbart wahrend der Vorwartselimination, welcher Fall vorliegt.

## Die drei Falle

### Fall 1: Keine Losung ($\emptyset$)

**Woran erkennbar:** Wahrend der Elimination erscheint in der erweiterten Matrix eine Zeile der Form:

$$(0 \; 0 \; \ldots \; 0 \mid c) \quad \text{mit } c \neq 0$$

Dies ubersetzt sich in die Gleichung $0 = c$, was unmoglich ist.

> [!example]
> Aus [[Gauss-Elimination-Beispiele#Beispiel 2|UE_10.5]]: die Elimination ergab $(0\;0\;0 \mid 1)$ $\rightarrow$ $0 = 1$ $\rightarrow$ keine Losung.

Geometrische Interpretation: die Gleichungen widersprechen einander (z. B. parallele Ebenen, die sich nicht alle in einem gemeinsamen Punkt schneiden).

### Fall 2: Genau eine Losung (eindeutige Losung)

**Woran erkennbar:** Jede Spalte von $A$ hat ein Pivot. Es gibt keine freien Variablen. Die Elimination fuhrt zu einer oberen Dreiecksform mit Nicht-Null-Eintragen auf der gesamten Diagonalen (bei einem quadratischen System).

> [!example]
> Aus [[Gauss-Elimination#Durchgerechnetes Beispiel|UE_10.3]]: Pivots in Spalten 1, 2, 3 $\rightarrow$ eindeutige Losung $x = (-1.5,\;3,\;0.5)^T$

Geometrische Interpretation: $n$ Hyperebenen schneiden sich in genau einem Punkt.

### Fall 3: Unendlich viele Losungen

**Woran erkennbar:** Keine Widerspruchszeile, aber weniger Pivots als Variablen. Variablen ohne Pivot heißen **frei** (free variables) -- sie konnen beliebige Werte annehmen, und die anderen Variablen werden durch sie ausgedruckt.

Die Losung ist eine [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]]: $x = v_0 + \alpha_1 v_1 + \cdots + \alpha_k v_k$, wobei $k$ = Anzahl der freien Variablen = (Anzahl der Variablen) $-$ (Anzahl der Pivots).

> [!example]
> Aus [[Gauss-Elimination-Beispiele#Beispiel 1|UE_10.4]]: 2 Pivots bei 3 Variablen $\rightarrow$ 1 freie Variable $\rightarrow$ Losung ist eine Gerade im $\mathbb{R}^3$.

## Bestimmung des Losungstyps: Entscheidungsablauf

```
Elimination abgeschlossen
        |
        +-- Widerspruchszeile? ---- JA ---> KEINE LOSUNG
        |
        NEIN
        |
        +-- Variablen = Pivots? --- JA ---> EINDEUTIGE LOSUNG
        |
        NEIN
        |
        +--> UNENDLICH VIELE LOSUNGEN
             (lineare Mannigfaltigkeit der Dimension: Variablen - Pivots)
```

## Gleichheit zweier Losungsdarstellungen

> [!warning] Prufungsrelevant -- UE_11.3

Angenommen, du hast $Ax = b$ gelost und $v_0 + U$ erhalten, aber die Musterlosung gibt $w_0 + W$ an. Wie prufst du, ob beide Darstellungen dieselbe Menge beschreiben?

**Zwei Darstellungen beschreiben dieselbe [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]], wenn:**

1. **Gleicher Richtungsraum:** $U = W$. Uberprufe, ob jeder Basisvektor von $U$ in $W$ liegt und umgekehrt. Da beide aus der Gauss-Elimination stammen, haben $U$ und $W$ ublicherweise dieselbe Dimension -- es genugt zu prufen, dass jeder $u_i \in U$ als Linearkombination der $w_j \in W$ darstellbar ist.

2. **Differenz der Verschiebungen im Raum:** $v_0 - w_0 \in U$. Die Differenz zwischen den beiden ,,partikularen Losungen" muss im Richtungsraum liegen. Anders ausgedruckt: es gibt Koeffizienten $\alpha_i$, sodass $v_0 = w_0 + \sum \alpha_i w_i$.

> [!tip] Praktische Prufung
> Stelle $v_0 = w_0 + \alpha_1 w_1 + \cdots + \alpha_k w_k$ auf und lose nach $\alpha_1, \ldots, \alpha_k$. Existiert eine Losung und sind beide Spannen gleich, sind die beiden Mannigfaltigkeiten identisch.

## Warum Losungsvektoren aus der Gauss-Elimination linear unabhangig sind

> [!warning] Prufungsrelevant -- UE_11.4

Wenn die Gauss-Elimination eine Losung der Form $v_0 + \alpha_1 v_1 + \cdots + \alpha_k v_k$ liefert, dann ist die Menge $\{v_1, \ldots, v_k\}$ **stets linear unabhangig** (linearly independent).

**Warum:** Jeder $v_i$ gehort zu genau einer freien Variable. In $v_i$ wird diese freie Variable auf $1$ gesetzt, alle *ubrigen* freien Variablen auf $0$. Das bedeutet:
- $v_i$ hat eine $1$ an der Stelle, die ,,seiner" freien Variable entspricht
- Alle anderen $v_j$ ($j \neq i$) haben an derselben Stelle eine $0$

Keine Linearkombination der ubrigen $v_j$ kann jemals $v_i$ reproduzieren, da sie alle $0$ haben, wo $v_i$ eine $1$ hat. Dies ist eine direkte strukturelle Garantie des Algorithmus -- keine zusatzliche Prufung notig.

> [!example] Aus UE_10.4
> Losung: $v_0 + t \cdot v_1$ mit $v_1 = (2, 8, 1)^T$, wobei $x_3$ die freie Variable war.
> $v_1$ hat eine $1$ an Position 3 (der Position von $x_3$). Ein einzelner Nicht-Null-Vektor ist stets linear unabhangig.

> **Nachste Schritte:** [[Homogen-vs-Inhomogen]] -- die tiefere Struktur hinter Losungsmengen | [[Kern-vs-Loesungsmenge]] -- wie der Kern alles zusammenhalt

> [!info] English: [[../../EN/systems-of-equations/Solution-Set]]

---

*Zuletzt uberpruft: 2026-06-09*
