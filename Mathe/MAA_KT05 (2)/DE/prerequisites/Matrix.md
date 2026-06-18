# Matrix

> **Voraussetzungen:** [[Vektor]]

Eine **Matrix** (Plural: Matrizen) ist ein rechteckiges Zahlenfeld, angeordnet in Zeilen und Spalten. Man kann sie sich vorstellen als:
- Eine Tabelle von Koeffizienten aus einem Gleichungssystem
- Eine „Maschine", die Eingabe-[[Vektor|Vektoren]] in Ausgabevektoren transformiert
- Eine Möglichkeit, mehrere Vektoren nebeneinander zu organisieren

## Dimensionen und Schreibweise

Eine Matrix mit $m$ Zeilen und $n$ Spalten heißt **$m \times n$-Matrix** („m mal n"). Der Eintrag in Zeile $i$, Spalte $j$ wird als $a_{ij}$ geschrieben:

$$A = \begin{pmatrix}
a_{11} & a_{12} & \cdots & a_{1n} \\
a_{21} & a_{22} & \cdots & a_{2n} \\
\vdots & \vdots & \ddots & \vdots \\
a_{m1} & a_{m2} & \cdots & a_{mn}
\end{pmatrix}$$

> [!example]
> Eine $2 \times 3$-Matrix: $\begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 5 \end{pmatrix}$
>
> $a_{11} = 1$, $a_{12} = 0$, $a_{23} = 5$

## Matrix-Vektor-Multiplikation

Dies ist die wichtigste Operation. Eine Matrix $A$ ($m \times n$) multipliziert mit einem Vektor $x$ ($n \times 1$) ergibt einen neuen Vektor ($m \times 1$):

$$Ax = \begin{pmatrix} a_{11} & \cdots & a_{1n} \\ \vdots & & \vdots \\ a_{m1} & \cdots & a_{mn} \end{pmatrix} \begin{pmatrix} x_1 \\ \vdots \\ x_n \end{pmatrix} = \begin{pmatrix} a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n \\ \vdots \\ a_{m1}x_1 + a_{m2}x_2 + \cdots + a_{mn}x_n \end{pmatrix}$$

> [!tip] Schlüsselkonzept
> $Ax$ **ist eine [[Linearkombination]] der Spalten von** $A$, mit den Komponenten von $x$ als Gewichten:
>
> $$Ax = x_1 \begin{pmatrix} a_{11} \\ \vdots \\ a_{m1} \end{pmatrix} + x_2 \begin{pmatrix} a_{12} \\ \vdots \\ a_{m2} \end{pmatrix} + \cdots + x_n \begin{pmatrix} a_{1n} \\ \vdots \\ a_{mn} \end{pmatrix}$$
>
> Immer wenn du $Ax$ siehst, denke: „Ich kombiniere die Spalten von $A$ mit $x$ als Rezept."

## Matrix-Matrix-Multiplikation

$A$ ($m \times n$) mal $B$ ($n \times p$) ergibt $C$ ($m \times p$):

$$C = AB \quad \text{wobei} \quad c_{ij} = \sum_{k=1}^n a_{ik} \, b_{kj}$$

Der Eintrag $c_{ij}$ ist das Skalarprodukt von Zeile $i$ von $A$ mit Spalte $j$ von $B$. Das bedeutet: Man multipliziert die Einträge paarweise und summiert sie auf.

Für die Multiplikation muss die Spaltenanzahl von $A$ mit der Zeilenanzahl von $B$ übereinstimmen. Zwei Matrizen, bei denen das nicht der Fall ist, können nicht multipliziert werden — man sagt, sie sind **nicht konform** (engl. not conformable).

Die Matrixmultiplikation ist **assoziativ**: $(AB)C = A(BC)$, sofern die Dimensionen passen. Das ist nützlich, um komplizierte Ausdrücke umzuklammern.

> [!warning] Prüfungsrelevant
> Die Matrixmultiplikation ist **nicht kommutativ** (engl. not commutative): im Allgemeinen gilt $AB \neq BA$. Eines der beiden Produkte ist unter Umständen nicht einmal definiert, wenn die Dimensionen in umgekehrter Reihenfolge nicht passen.

## Weitere Operationen

| Operation | Regel | Bedingung |
|-----------|-------|-----------|
| **Addition** | $(A + B)_{ij} = a_{ij} + b_{ij}$ | Gleiche Dimensionen |
| **Skalarmultiplikation** | $(\alpha A)_{ij} = \alpha \cdot a_{ij}$ | Keine |
| **Transposition** (engl. transposition) $A^T$ | $(A^T)_{ij} = a_{ji}$ — Zeilen und Spalten vertauschen | Keine |

Die **Einheitsmatrix** (engl. identity matrix) $I$ ist eine quadratische Matrix mit Einsen auf der Diagonale und Nullen sonst. Sie ist das neutrale Element der Matrixmultiplikation: $A \cdot I = A$ und $I \cdot A = A$.

## Wo Matrizen vorkommen

- [[Lineare-Funktion|Lineare Funktionen]] werden durch Matrizen dargestellt — jede lineare Funktion von $\mathbb{R}^n$ nach $\mathbb{R}^m$ kann als $f(x) = Ax$ geschrieben werden
- [[Lineare-Gleichungssysteme|Lineare Gleichungssysteme]] werden in Matrixform $Ax = b$ geschrieben
- [[Determinante|Determinanten]] werden aus (quadratischen) Matrizen berechnet
- [[Matrix-Inverse|Matrixinverse]] machen die Wirkung einer Matrix rückgängig

> **Nächste Schritte:** [[Lineare-Funktion]] — Matrizen als Transformationen verstehen | [[Lineare-Gleichungssysteme]] — Matrizen zum Lösen von Gleichungen nutzen

> [!info] English: [[../../EN/prerequisites/Matrix]]

---

*Zuletzt geprüft: 2026-06-09*
