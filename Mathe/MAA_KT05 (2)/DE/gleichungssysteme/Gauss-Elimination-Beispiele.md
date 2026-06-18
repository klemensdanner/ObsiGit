# Gauss-Elimination -- Beispiele

> **Voraussetzungen:** [[Gauss-Elimination]]

Zwei weitere vollstandig durchgerechnete Beispiele mit Kommentar. Sie erganzen das Hauptbeispiel in [[Gauss-Elimination]].

---

## Beispiel 1: Unendlich viele Lösungen (UE_10.4)

> Lose $\begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 2 \\ 1 & -1 & 6 \end{pmatrix} x = \begin{pmatrix} -1 \\ 4 \\ 6 \end{pmatrix}$

**Erweiterte Matrix:**

$$\left(\begin{array}{ccc|c} 1 & 0 & -2 & -1 \\ 3 & -1 & 2 & 4 \\ 1 & -1 & 6 & 6 \end{array}\right)$$

**Vorwartselimination:**

*Spalte 1 -- Pivot ist $1$ in Zeile 1:*
- $Z_2 \leftarrow Z_2 - 3Z_1$: eliminiert die $3$
- $Z_3 \leftarrow Z_3 - Z_1$: eliminiert die $1$

$$\left(\begin{array}{ccc|c} 1 & 0 & -2 & -1 \\ 0 & -1 & 8 & 7 \\ 0 & -1 & 8 & 7 \end{array}\right)$$

*Spalte 2 -- Pivot ist $-1$ in Zeile 2:*
- $Z_3 \leftarrow Z_3 - Z_2$: eliminiert die $-1$ darunter

$$\left(\begin{array}{ccc|c} 1 & 0 & -2 & -1 \\ 0 & -1 & 8 & 7 \\ 0 & 0 & 0 & 0 \end{array}\right)$$

**Analyse:** Eine Nullzeile ist aufgetaucht -- die dritte Gleichung war redundant (sie entspricht Zeile 1 plus Zeile 2). Es gibt jedoch keinen Widerspruch. Zwei Pivots, drei Variablen $\rightarrow$ **unendlich viele Losungen**, eine freie Variable.

> [!tip] Unterschied zu UE_10.3
> UE_10.3 hatte 3 Pivots $\rightarrow$ eindeutige Losung. Hier haben wir 2 Pivots bei 3 Variablen $\rightarrow$ ein Freiheitsgrad ($x_3$ ist frei).

**Parametrisierung** (parameterization) -- setze $x_3 = t$ (freier Parameter), dann:

Aus Zeile 2: $-x_2 + 8t = 7$ $\rightarrow$ $x_2 = 8t - 7$

Aus Zeile 1: $x_1 - 2t = -1$ $\rightarrow$ $x_1 = 2t - 1$

**Losung:** $x = \begin{pmatrix} -1 \\ -7 \\ 0 \end{pmatrix} + t \begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix}$, fur beliebiges $t \in \mathbb{R}$

Dies ist eine [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]] -- eine Gerade im $\mathbb{R}^3$ (1-dimensional, da ein freier Parameter).

---

## Beispiel 2: Keine Losung (UE_10.5)

> Lose $\begin{pmatrix} 2 & 1 & 0 \\ -1 & 0 & 1 \\ 1 & 1 & 1 \end{pmatrix} x = \begin{pmatrix} 1 \\ 2 \\ 4 \end{pmatrix}$

**Erweiterte Matrix:**

$$\left(\begin{array}{ccc|c} 2 & 1 & 0 & 1 \\ -1 & 0 & 1 & 2 \\ 1 & 1 & 1 & 4 \end{array}\right)$$

**Vorwartselimination:**

*Spalte 1 -- Pivot ist $2$ in Zeile 1:*
- $Z_2 \leftarrow Z_2 + 0.5Z_1$
- $Z_3 \leftarrow Z_3 - 0.5Z_1$

$$\left(\begin{array}{ccc|c} 2 & 1 & 0 & 1 \\ 0 & 0.5 & 1 & 2.5 \\ 0 & 0.5 & 1 & 3.5 \end{array}\right)$$

*Spalte 2 -- Pivot ist $0.5$ in Zeile 2:*
- $Z_3 \leftarrow Z_3 - Z_2$

$$\left(\begin{array}{ccc|c} 2 & 1 & 0 & 1 \\ 0 & 0.5 & 1 & 2.5 \\ 0 & 0 & 0 & 1 \end{array}\right)$$

**Analyse:** Die dritte Zeile lautet $0x_1 + 0x_2 + 0x_3 = 1$ -- also $0 = 1$, ein Widerspruch.

**$\rightarrow$ Keine Losung.** Das System ist inkonsistent. (Geometrisch: die drei Ebenen haben keinen gemeinsamen Punkt.)

> [!tip] Das entscheidende Merkmal
> Eine Widerspruchszeile $(0\;0\;\ldots\;0 \mid c)$ mit $c \neq 0$ in der erweiterten Matrix bedeutet immer **keine Losung**. Dies ist der einzige Weg, Inkonsistenz nachzuweisen.

## Zusammenfassung: Drei Systeme, drei Ausgange

| Ubung | Matrix | Ergebnis | Typ |
|-------|--------|----------|-----|
| UE_10.3 | $\begin{pmatrix} 2&1&2\\-1&0&1\\2&10&0 \end{pmatrix}$ | Eindeutig: $x \approx (-1.5,\;3,\;0.5)$ | [[Loesungsmenge\|Genau eine]] |
| UE_10.4 | $\begin{pmatrix} 1&0&-2\\3&-1&2\\1&-1&6 \end{pmatrix}$ | $x = (-1,-7,0)^T + t(2,8,1)^T$ | [[Loesungsmenge\|Unendlich viele]] |
| UE_10.5 | $\begin{pmatrix} 2&1&0\\-1&0&1\\1&1&1 \end{pmatrix}$ | Widerspruchszeile $\rightarrow$ $\emptyset$ | [[Loesungsmenge\|Keine Losung]] |

> **Nachste Schritte:** [[Loesungsmenge]] -- die drei Ausgangstypen systematisch verstehen | [[Obere-Dreiecksform]] -- Systeme losen, die bereits in Dreiecksform vorliegen

> [!info] English: [[../../EN/systems-of-equations/Gaussian-Elimination-Examples]]

---

*Zuletzt uberpruft: 2026-06-09*
