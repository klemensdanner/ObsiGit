# Homogene vs. inhomogene Systeme

> **Voraussetzungen:** [[Lineare-Gleichungssysteme]], [[Loesungsmenge]], [[Kern]]

Ein lineares System $Ax = b$ fallt je nach rechter Seite $b$ in eine von zwei Familien.

## Definitionen

| Typ | Form | Eigenschaft |
|-----|------|-------------|
| **Homogenes System** (homogeneous system) | $Ax = 0$ | Rechte Seite ist der Nullvektor |
| **Inhomogenes System** (inhomogeneous system) | $Ax = b$ mit $b \neq 0$ | Rechte Seite ist ungleich Null |

## Homogene Systeme ($Ax = 0$)

Jedes homogene System hat mindestens eine garantierte Losung: $x = 0$, die **triviale Losung** (trivial solution). Die Frage ist nur, ob es daruber hinaus *weitere* Losungen gibt.

Die Losungsmenge von $Ax = 0$ ist exakt der [[Kern|Kern]] (kernel) von $A$:

$$\{x \mid Ax = 0\} = \operatorname{Kern}(A)$$

Anders als allgemeine Losungsmengen ist $\operatorname{Kern}(A)$ stets ein **Unterraum** (subspace) -- nicht nur eine Mannigfaltigkeit: er enthalt $0$ und ist abgeschlossen unter Addition und skalarer Multiplikation -- wenn $x$ und $y$ Losungen sind, dann ist auch $\alpha x + \beta y$ eine Losung.

> [!example]
> Fur die Matrix aus [[Gauss-Elimination-Beispiele#Beispiel 1|UE_10.4]]:
> $$A = \begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 2 \\ 1 & -1 & 6 \end{pmatrix}$$
>
> $Ax = 0$ ergibt: $x = t \begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix} = \operatorname{Kern}(A)$ -- eine Gerade durch den Ursprung.

## Inhomogene Systeme ($Ax = b$, $b \neq 0$)

Die Losungsmenge ist **kein** Unterraum (sie enthalt im Allgemeinen nicht $0$). Stattdessen ist sie eine [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]]: eine verschobene Version des Kerns.

## Die fundamentale Struktur

> [!warning] Prufungsrelevant

Die allgemeine Losung eines inhomogenen Systems ist:

$$\boxed{\text{Alle Losungen von } Ax = b \;=\; x_p + \operatorname{Kern}(A)}$$

wobei $x_p$ eine beliebige **partikulare Losung** (particular solution) ist -- ein einzelner Vektor, der $Ax_p = b$ erfullt.

> [!tip] Warum das funktioniert
> Wenn $x$ eine beliebige Losung von $Ax = b$ ist, dann gilt $A(x - x_p) = Ax - Ax_p = b - b = 0$.
>
> Also ist $(x - x_p) \in \operatorname{Kern}(A)$. Das bedeutet $x = x_p + v$ fur ein $v \in \operatorname{Kern}(A)$.
>
> Umgekehrt: fur jedes $v \in \operatorname{Kern}(A)$ gilt $A(x_p + v) = Ax_p + Av = b + 0 = b$.

## Dimensionsbeziehung

Die Dimension des Losungsraums hangt direkt mit dem [[Rang|Rang]] (rank) der Matrix $A$ zusammen:

$$\dim(\operatorname{Kern}(A)) = n - \operatorname{rang}(A)$$

wobei $n$ die Anzahl der Spalten (Variablen) ist.

- Fur ein homogenes System: Die Losungsmenge $\operatorname{Kern}(A)$ hat genau diese Dimension.
- Fur ein inhomogenes System: Die Losungsmenge $x_p + \operatorname{Kern}(A)$ hat **dieselbe Dimension** wie $\operatorname{Kern}(A)$ -- die Verschiebung $x_p$ andert nichts an der Dimension.

> [!example]
> Bei der Matrix $A = \begin{pmatrix} 2 & 1 \\ 4 & 2 \end{pmatrix}$ ist $\operatorname{rang}(A) = 1$ und $n = 2$, also $\dim(\operatorname{Kern}(A)) = 2 - 1 = 1$ -- eine Gerade.

## Besonderheiten der Losungsstruktur

Ein homogenes System hat entweder:
- **Nur die triviale Losung** $x = 0$, wenn $\operatorname{Kern}(A) = \{0\}$, also wenn die Spalten von $A$ linear unabhangig sind ($\operatorname{rang}(A) = n$).
- **Unendlich viele Losungen**, wenn $\operatorname{Kern}(A)$ mehr als nur den Nullvektor enthalt ($\operatorname{rang}(A) < n$).

Ein inhomogenes System kann dagegen in **allen drei Fallen** landen: keine Losung, genau eine oder unendlich viele.

> [!tip] Merkregel
> Die Unterscheidung homogen/inhomogen betrifft nur die rechte Seite $b$. Die Struktur der Koeffizientenmatrix $A$ (insbesondere ihr Rang) bestimmt, ob und wie viele Losungen existieren.

## Beispiel im Vergleich

Betrachte $A = \begin{pmatrix} 2 & 1 \\ 4 & 2 \end{pmatrix}$ (Rang 1).

| | $Ax = 0$ (homogen) | $Ax = \begin{pmatrix}3\\6\end{pmatrix}$ (inhomogen) |
|---|---|---|
| **Zeilenreduktion** | $\begin{pmatrix}2&1\\0&0\end{pmatrix}x = 0$ | $\begin{pmatrix}2&1&3\\0&0&0\end{pmatrix}$ |
| **Ergebnis** | $2x_1 + x_2 = 0$ | $2x_1 + x_2 = 3$ |
| **Menge** | $x_2 = -2x_1$ $\rightarrow$ $x = t\begin{pmatrix}1\\-2\end{pmatrix}$ | $x_2 = 3 - 2x_1$ $\rightarrow$ $x = \begin{pmatrix}0\\3\end{pmatrix} + t\begin{pmatrix}1\\-2\end{pmatrix}$ |
| **Geometrie** | Gerade durch den Ursprung | Dieselbe Gerade, vom Ursprung weg verschoben |
| **Typ** | Unterraum ([[Kern]]) | [[Lineare-Mannigfaltigkeit|Lineare Mannigfaltigkeit]] |

Beachte die Struktur: $\text{Inhomogene Losung} = \underbrace{\begin{pmatrix}0\\3\end{pmatrix}}_{x_p} + \underbrace{t\begin{pmatrix}1\\-2\end{pmatrix}}_{\operatorname{Kern}(A)}$

> **Nachste Schritte:** [[Kern-vs-Loesungsmenge]] -- die vereinheitlichte Sicht auf Kern und Losungsmengen | [[Kern-berechnen]] -- wie man den Kern tatsachlich berechnet

> [!info] English: [[../../EN/systems-of-equations/Homogeneous-vs-Inhomogeneous]]

---

*Zuletzt uberpruft: 2026-06-09*
