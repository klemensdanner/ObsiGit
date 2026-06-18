# Lineare Gleichungssysteme

> **Voraussetzungen:** [[Vektor]], [[Matrix]]

Ein **lineares Gleichungssystem** (linear system of equations) ist eine Menge linearer Gleichungen, die alle gleichzeitig erfullt sein mussen. ,,Linear" bedeutet, dass jede Gleichung nur Ausdrucke wie $3x_1$, $-x_2$ enthalt -- keine $x^2$, kein $\sin(x)$, keine Produkte $x_1 x_2$.

## Von Gleichungen zur Matrixform

Betrachten wir das folgende System:

$$\begin{aligned}
2x_1 + x_2 + 2x_3 &= 1 \\
-x_1 + x_3 &= 2 \\
2x_1 + 10x_2 &= 3
\end{aligned}$$

In der **Matrixform** (matrix form) $Ax = b$ wird dies wesentlich ubersichtlicher:

$$\underbrace{\begin{pmatrix} 2 & 1 & 2 \\ -1 & 0 & 1 \\ 2 & 10 & 0 \end{pmatrix}}_{A} \underbrace{\begin{pmatrix} x_1 \\ x_2 \\ x_3 \end{pmatrix}}_{x} = \underbrace{\begin{pmatrix} 1 \\ 2 \\ 3 \end{pmatrix}}_{b}$$

> [!tip] Die Matrixform lesen
> - $A$ ist die **Koeffizientenmatrix** (coefficient matrix) -- eine Zeile pro Gleichung, eine Spalte pro Variable
> - $x$ ist der **Losungsvektor** (solution vector) -- das, was wir berechnen wollen
> - $b$ ist die **rechte Seite** (right-hand side) -- die Konstanten
> - Jede Zeile von $A$, skalar multipliziert mit $x$, ergibt den zugehorigen Eintrag in $b$

## Geometrische Bedeutung

Jede Gleichung definiert eine ,,Flache" (Gerade im $\mathbb{R}^2$, Ebene im $\mathbb{R}^3$, Hyperebene daruber hinaus). Die Losung ist der Schnittpunkt all dieser Flachen:

| Im $\mathbb{R}^2$ (zwei Variablen) | Im $\mathbb{R}^3$ (drei Variablen) |
|---|---|
| Zwei Geraden | Drei Ebenen |
| Schnittpunkt = Punkt (eindeutige Losung) | Schnittpunkt = Punkt (eindeutige Losung) |
| Parallele Geraden (keine Losung) | Ebenen ohne gemeinsamen Schnitt |
| Dieselbe Gerade (unendlich viele) | Ebenen mit gemeinsamer Gerade (unendlich viele) |

## Drei mogliche Ausgange

Jedes lineare System fallt in genau einen dieser drei Falle:

| Fall | Wann tritt er auf? | Losungsform |
|------|-------------------|-------------|
| **Keine Losung** | Widerspruch: z. B. eine Zeile wird zu $0 = 5$ | $\emptyset$ (leere Menge) |
| **Genau eine Losung** | Vollstandiger [[Rang]], jede Variable hat ein Pivot | Ein einzelner Vektor $x^*$ |
| **Unendlich viele Losungen** | Weniger Pivots als Variablen $\rightarrow$ freie Variablen | Eine [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]] |

> [!warning] Prufungsrelevant
> Du bestimmst, in welchem Fall du dich befindest, **wahrend** der [[Gauss-Elimination|Gauss-Elimination]], nicht vorher. Der Eliminationsprozess selbst offenbart den Fall.

## Nicht-quadratische Systeme

Ein lineares System muss nicht quadratisch sein. Die Koeffizientenmatrix $A$ kann beliebig viele Zeilen ($m$) und Spalten ($n$) haben:

| Fall | Beschreibung |
|------|-------------|
| $m = n$ | Quadratisches System -- gleich viele Gleichungen wie Variablen |
| $m > n$ | Uberbestimmt -- mehr Gleichungen als Variablen (oft keine Losung) |
| $m < n$ | Unterbestimmt -- weniger Gleichungen als Variablen (oft unendlich viele Losungen) |

Die Gauss-Elimination funktioniert fur alle drei Falle gleichermaßen.

## Die erweiterte Matrix

Zum Losen arbeiten wir mit der **erweiterten Matrix** (augmented matrix) $[A \mid b]$, die $b$ rechts an $A$ anhangt:

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ -1 & 0 & 1 & 2 \\ 2 & 10 & 0 & 3 \end{array}\right)$$

Der senkrechte Strich ist eine visuelle Erinnerung: die rechteste Spalte ist besonders (es ist $b$, nicht die Koeffizienten).

## Losungsstrategie

1. Schreibe die erweiterte Matrix $[A \mid b]$ auf
2. Wende die [[Gauss-Elimination|Gauss-Elimination]] an, um die [[Obere-Dreiecksform|obere Dreiecksform]] zu erreichen
3. Lose durch Ruckwartssubstitution von unten nach oben
4. Bestimme den Typ der [[Loesungsmenge|Losungsmenge]]

> [!example] Kurzer Vorgeschmack -- siehe [[Gauss-Elimination]] fur die vollstandige Durchfuhrung
> Das obige System (aus UE_10.3) reduziert sich zu:
> $$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ 0 & 0.5 & 2 & 2.5 \\ 0 & 0 & -16 & -8 \end{array}\right)$$
>
> Ruckwartssubstitution: $x_3 = 0.5$, $x_2 = 3$, $x_1 = -1.5$

> **Nachste Schritte:** [[Gauss-Elimination]] -- der Algorithmus | [[Loesungsmenge]] -- die drei Ausgangstypen im Detail

> [!info] English: [[../../EN/systems-of-equations/Linear-Systems]]

---

*Zuletzt uberpruft: 2026-06-09*
