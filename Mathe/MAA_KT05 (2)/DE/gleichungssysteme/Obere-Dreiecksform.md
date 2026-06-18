# Obere Dreiecksform

> **Voraussetzungen:** [[Zeilenoperationen]], [[Matrix]]

Eine Matrix befindet sich in **oberer Dreiecksform** (upper triangular form), auch **Zeilenstufenform** (row echelon form) genannt, wenn alle Eintrage **unterhalb** der Hauptdiagonale Null sind. Dies ist die Zielform der [[Gauss-Elimination|Gauss-Elimination]] -- ist sie erreicht, lassen sich die Losungen direkt ablesen.

## Definition

$$\begin{pmatrix}
a_{11} & a_{12} & a_{13} & \cdots & a_{1n} \\
0      & a_{22} & a_{23} & \cdots & a_{2n} \\
0      & 0      & a_{33} & \cdots & a_{3n} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
0      & 0      & 0      & \cdots & a_{nn}
\end{pmatrix}$$

Fur jeden Eintrag $a_{ij}$ mit $i > j$ (unterhalb der Diagonalen) gilt: $a_{ij} = 0$.

> [!tip] Uberprufung
> Zeichne die Diagonale von oben links nach unten rechts. Alles links von und unterhalb dieser Linie muss Null sein.

## Warum sie nutzlich ist

In oberer Dreiecksform involviert die letzte Gleichung nur noch die letzte Variable. Lose diese, setze sie nach oben ein -- das ist die **Ruckwartssubstitution** (back-substitution):

$$\begin{aligned}
a_{nn} x_n &= b_n \quad &&\rightarrow \quad x_n = b_n / a_{nn} \\
a_{n-1,n-1} x_{n-1} + a_{n-1,n} x_n &= b_{n-1} \quad &&\rightarrow \quad \text{einsetzen von } x_n, \text{ losen nach } x_{n-1} \\
&\;\;\vdots
\end{aligned}$$

## Durchgerechnetes Beispiel (UE_11.1)

> Lose das System, das bereits in oberer Dreiecksform vorliegt:
> $$\begin{pmatrix} 1 & 3 & -2 & 0 & 2 \\ 0 & -2 & 4 & -2 & 6 \\ 0 & 0 & 0 & 1 & 3 \\ 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 \end{pmatrix} x = \begin{pmatrix} -2 \\ 8 \\ 2 \\ 0 \\ 0 \end{pmatrix}$$

**Schritt 1: Pivots identifizieren.** Pivots befinden sich in Spalte 1 ($1$), Spalte 2 ($-2$) und Spalte 4 ($1$). Die Spalten 3 und 5 haben keine Pivots $\rightarrow$ sie sind **freie Variablen** (free variables).
- **Basisvariablen** (basic variables): $x_1, x_2, x_4$
- **Freie Variablen:** $x_3, x_5$

**Schritt 2: Ruckwartssubstitution von der untersten Nicht-Null-Zeile.**

Zeile 4: $0 \cdot x_3 + 0 \cdot x_5$ -- Nullzeile, uberspringen.
Zeile 3: $x_4 + 3x_5 = 2$ $\rightarrow$ $x_4 = 2 - 3x_5$

Zeile 2: $-2x_2 + 4x_3 - 2x_4 + 6x_5 = 8$
Setze $x_4$ ein: $-2x_2 + 4x_3 - 2(2 - 3x_5) + 6x_5 = 8$
$\rightarrow$ $-2x_2 + 4x_3 - 4 + 6x_5 + 6x_5 = 8$
$\rightarrow$ $-2x_2 + 4x_3 + 12x_5 = 12$
$\rightarrow$ $x_2 = 2x_3 + 6x_5 - 6$

Zeile 1: $x_1 + 3x_2 - 2x_3 + 0x_4 + 2x_5 = -2$
Setze $x_2$ ein: $x_1 + 3(2x_3 + 6x_5 - 6) - 2x_3 + 2x_5 = -2$
$\rightarrow$ $x_1 + 6x_3 + 18x_5 - 18 - 2x_3 + 2x_5 = -2$
$\rightarrow$ $x_1 + 4x_3 + 20x_5 = 16$
$\rightarrow$ $x_1 = 16 - 4x_3 - 20x_5$

**Schritt 3: Losung als [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]] schreiben.**

Setze $x_3 = s$, $x_5 = t$ (freie Parameter):

$$x = \begin{pmatrix} 16 \\ -6 \\ 0 \\ 2 \\ 0 \end{pmatrix} + s \begin{pmatrix} -4 \\ 2 \\ 1 \\ 0 \\ 0 \end{pmatrix} + t \begin{pmatrix} -20 \\ 6 \\ 0 \\ -3 \\ 1 \end{pmatrix}$$

> [!tip] Unterscheidung: Zeilenstufenform vs. reduzierte Zeilenstufenform
> Die hier beschriebene obere Dreiecksform wird auch als **Zeilenstufenform** (row echelon form, REF) bezeichnet. Daruber hinaus gibt es die **reduzierte Zeilenstufenform** (reduced row echelon form, RREF), bei der auch die Eintrage **oberhalb** jedes Pivots eliminiert werden. Fur die Gauss-Elimination genugt die einfache Zeilenstufenform -- die RREF ist fur das Gauss-Jordan-Verfahren relevant.

## Verbindung zur Determinante

Fur eine quadratische obere Dreiecksmatrix ist die [[Determinante|Determinante]] einfach das Produkt der Diagonaleintrage:

$$\det\begin{pmatrix} a_{11} & a_{12} & a_{13} \\ 0 & a_{22} & a_{23} \\ 0 & 0 & a_{33} \end{pmatrix} = a_{11} \cdot a_{22} \cdot a_{33}$$

> [!warning] Prufungsrelevant -- UE_10.2
> Dies ist kein Zufall -- es ist durch wiederholte Laplace-Entwicklung nach der ersten Spalte beweisbar. Siehe den Beweis unter [[Determinante#Beweis fur obere Dreiecksmatrizen]].

> **Nachste Schritte:** [[Loesungsmenge]] -- den Losungstyp klassifizieren | [[Gauss-Elimination]] -- wie man eine Matrix in diese Form bringt

> [!info] English: [[../../EN/systems-of-equations/Upper-Triangular-Form]]

---

*Zuletzt uberpruft: 2026-06-09*
