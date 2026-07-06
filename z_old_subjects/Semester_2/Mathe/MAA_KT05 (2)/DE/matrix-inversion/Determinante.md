# Determinante

> **Voraussetzungen:** [[Matrix]]

Die **Determinante** (determinant) einer quadratischen Matrix ist eine einzelne Zahl, geschrieben $\det(A)$ oder $|A|$, die wichtige Eigenschaften der Matrix beschreibt. Geometrisch gibt sie an, wie stark die lineare Abbildung Volumina "skaliert" und ob sie die Orientierung umkehrt.

## Intuition

Stelle dir das Einheitsquadrat (Fläche 1) im $\mathbb{R}^2$ vor. Wende eine Matrix $A$ als Transformation an. Das Bild ist ein Parallelogramm, dessen Fläche $|\det(A)|$ beträgt. Ist $\det(A)$ negativ, hat sich die Orientierung umgekehrt (Spiegelbild).

Damit eine Matrix [[Regulaere-Matrix|invertierbar]] ist, darf diese Fläche nicht auf Null kollabieren — daher $\det(A) \neq 0$.

## Determinanten berechnen

### $2 \times 2$: Die Grundformel

$$\det\begin{pmatrix} a & b \\ c & d \end{pmatrix} = ad - bc$$

> [!example]
> $\det\begin{pmatrix} 3 & 1 \\ 2 & 4 \end{pmatrix} = 3 \cdot 4 - 1 \cdot 2 = 12 - 2 = 10$

### $3 \times 3$: Die Regel von Sarrus (Sarrus' rule)

$$\det\begin{pmatrix} a_{11} & a_{12} & a_{13} \\ a_{21} & a_{22} & a_{23} \\ a_{31} & a_{32} & a_{33} \end{pmatrix} = \begin{aligned} &a_{11}a_{22}a_{33} + a_{12}a_{23}a_{31} + a_{13}a_{21}a_{32} \\ &- a_{13}a_{22}a_{31} - a_{11}a_{23}a_{32} - a_{12}a_{21}a_{33} \end{aligned}$$

> [!tip] Eselsbrücke
> Schreibe die ersten beiden Spalten rechts neben die Matrix:
> ```
> a11 a12 a13 | a11 a12
> a21 a22 a23 | a21 a22
> a31 a32 a33 | a31 a32
> ```
> Addiere die drei ↘-Diagonalen (blau), subtrahiere die drei ↙-Diagonalen (rot).

### $n \times n$: Der Laplace'sche Entwicklungssatz (Laplace expansion)

Für größere Matrizen entwickeln wir die Determinante entlang einer Zeile oder Spalte und reduzieren sie rekursiv auf kleinere Determinanten.

**Die Idee:** Wähle eine Zeile $i$ (oder Spalte $j$). Die Determinante ist die Summe jedes Eintrags dieser Zeile multipliziert mit seinem **Kofaktor** (cofactor):

$$\det(A) = \sum_{j=1}^n a_{ij} \, C_{ij}$$

Dabei ist der **Kofaktor** $C_{ij}$ wie folgt definiert:

- **Minor** (minor) $M_{ij}$: Die Determinante der Untermatrix, die durch Streichen von Zeile $i$ und Spalte $j$ entsteht
- **Kofaktor** $C_{ij} = (-1)^{i+j} \cdot M_{ij}$ — das Vorzeichen wechselt in einem Schachbrettmuster:

$$\begin{pmatrix} + & - & + & \cdots \\ - & + & - & \cdots \\ + & - & + & \cdots \\ \vdots & \vdots & \vdots & \ddots \end{pmatrix}$$

> [!warning] Prüfungsrelevant — UE_10.1
> Wende den Laplace'schen Entwicklungssatz wiederholt an, bis du $3 \times 3$-Untermatrizen erhältst, und verwende dann die Regel von Sarrus. So berechnen wir Determinanten von $4 \times 4$- und größeren Matrizen.

> [!example] Durchgerechnet nach UE_10.1
> Berechne $\det\begin{pmatrix} 1 & 0 & 0 & 0 & 1 \\ -2 & 2 & -1 & 0 & 3 \\ -1 & 0 & -3 & 3 & 4 \\ 0 & 0 & 2 & 0 & 0 \\ 3 & 0 & 4 & -1 & -3 \end{pmatrix}$
>
> **Entwickeln entlang Spalte 2** (drei Nullen — minimaler Aufwand):
>
> Nur $a_{22} = 2$ trägt bei. Sein Kofaktor: $C_{22} = (-1)^{2+2} M_{22} = +M_{22}$.
>
> Streiche Zeile 2, Spalte 2 — wir erhalten eine $4 \times 4$-Determinante.
>
> Fahre mit der Entwicklung fort, bis du $3 \times 3$-Determinanten erhältst, dann wende Sarrus an.

## Eigenschaften

| Eigenschaft | Erklärung |
|-------------|-----------|
| $\det(AB) = \det(A) \det(B)$ | Determinante eines Produkts = Produkt der Determinanten |
| $\det(A^{-1}) = 1 / \det(A)$ | Folgt aus obigem: $\det(AA^{-1}) = \det(I) = 1$ |
| $\det(A^T) = \det(A)$ | Transponieren ändert die Determinante nicht |
| $\det(I) = 1$ | Die Einheitsmatrix hat Determinante 1 |
| Zeilenvertauschung → Vorzeichenwechsel | $\det(\text{vertauscht}) = -\det(\text{original})$ |
| Zeile mit $\lambda$ multiplizieren → det wird mit $\lambda$ multipliziert | Multipliziere eine Zeile mit 5 → Determinante ×5 |
| Vielfaches einer Zeile addieren → det unverändert | Darum funktionieren Zeilenoperationen |

### Beweis: Determinante einer oberen Dreiecksmatrix (UE_10.2)

> [!warning] Prüfungsrelevant

Für eine **obere Dreiecksmatrix** (upper triangular matrix) ist die Determinante das Produkt der Diagonaleinträge (product of the diagonal entries):

$$\det\begin{pmatrix} a_{11} & a_{12} & \cdots & a_{1n} \\ 0 & a_{22} & \cdots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & a_{nn} \end{pmatrix} = a_{11} \cdot a_{22} \cdot \cdots \cdot a_{nn}$$

**Beweis durch wiederholte Laplace-Entwicklung entlang der ersten Spalte:**

Entwickle entlang Spalte 1. Nur $a_{11}$ kann von Null verschieden sein (alle Einträge darunter sind Null). Der Minor $M_{11}$ ist die $(n-1) \times (n-1)$ obere Dreiecksmatrix mit $a_{22}, \ldots, a_{nn}$ auf der Diagonalen.

Also gilt $\det(A_n) = a_{11} \cdot \det(A_{n-1})$.

Durch Induktion: $\det(A_n) = a_{11} \cdot a_{22} \cdot \det(A_{n-2}) = \cdots = a_{11} \cdot a_{22} \cdot \cdots \cdot a_{nn}$.

Derselbe Beweis funktioniert für **untere** Dreiecksmatrizen (alle Nullen oberhalb der Diagonalen) durch Entwicklung entlang der ersten Zeile.

## Determinante und Invertierbarkeit

$$\det(A) \neq 0 \quad \Longleftrightarrow \quad A \text{ ist } \textbf{regulär/invertierbar}$$

$$\det(A) = 0 \quad \Longleftrightarrow \quad A \text{ ist } \textbf{singulär}$$

> [!tip] Konsequenz für $2 \times 2$-Matrizen
> Die Formel $A^{-1} = \frac{1}{ad-bc}\begin{pmatrix} d & -b \\ -c & a \end{pmatrix}$ gilt genau dann, wenn $ad - bc \neq 0$. Der Nenner ist die Determinante — ist sie Null, existiert keine Inverse.

> **Nächste Schritte:** [[Regulaere-Matrix]] — der vollständige Katalog der Regularitätskriterien | [[Gauss-Jordan]] — die praktische Methode zur Berechnung von Inversen

> [!info] English: [[../../EN/matrix-inversion/Determinant]]

---

*Zuletzt überprüft: 2026-06-09*
