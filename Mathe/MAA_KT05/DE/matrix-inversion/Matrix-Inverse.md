# Matrix-Inverse

> **Voraussetzungen:** [[Matrix]], [[Lineare-Funktion]]

Die **Inverse** (inverse) einer quadratischen Matrix $A$, geschrieben $A^{-1}$, ist die Matrix, die die Wirkung von $A$ ruckgängig macht. Wenn $A$ einen Vektor $x$ in $Ax$ überführt, dann führt $A^{-1}$ den Vektor $Ax$ wieder zurück nach $x$.

## Intuition

Stelle dir $A$ als eine Funktion vor: $f(x) = Ax$. Die Inverse $A^{-1}$ ist die Umkehrfunktion:

$$A^{-1}(Ax) = x \quad \text{und} \quad A(A^{-1}x) = x$$

Genauso wie $\sqrt{\phantom{x}}$ das Quadrieren umkehrt und $\div 5$ die Multiplikation mit $5$ umkehrt, kehrt die **Matrixinverse** (matrix inverse) die Matrixmultiplikation um.

## Definition

Für eine $n \times n$ (quadratische) Matrix $A$ erfüllt ihre Inverse $A^{-1}$:

$$AA^{-1} = A^{-1}A = I_n$$

wobei $I_n$ die $n \times n$ **Einheitsmatrix** (identity matrix) ist — Einsen auf der Diagonale, Nullen überall sonst:

$$I_3 = \begin{pmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{pmatrix}$$

$I_n$ verhält sich bei der Matrixmultiplikation wie die Zahl $1$: $I_n A = A I_n = A$.

## Existenz und Eindeutigkeit

Wenn eine Inverse existiert, ist sie **eindeutig** (unique). Das heißt, es kann nicht zwei verschiedene Matrizen $B$ und $C$ geben, die beide $AB = BA = I$ und $AC = CA = I$ erfüllen. Der Beweis: $B = BI = B(AC) = (BA)C = IC = C$.

Ob eine Inverse existiert, hängt von der Determinante ab (siehe [[Determinante]]): $A^{-1}$ existiert genau dann, wenn $\det(A) \neq 0$ gilt. Eine Matrix mit existierender Inverser heißt [[Regulaere-Matrix|regulär]], andernfalls singulär.

## Geometrische Deutung

Die Inverse einer Matrix entspricht geometrisch der **Rücktransformation**: Wenn $A$ eine Streckung, Scherung oder Drehung bewirkt, dann macht $A^{-1}$ diese Rückgängig.

> [!example] Drehmatrix
> $A = \begin{pmatrix} \cos\theta & -\sin\theta \\ \sin\theta & \cos\theta \end{pmatrix}$ dreht Vektoren um den Winkel $\theta$.
> Ihre Inverse $A^{-1} = \begin{pmatrix} \cos\theta & \sin\theta \\ -\sin\theta & \cos\theta \end{pmatrix}$ dreht um $-\theta$ zurück.

> [!warning] Prüfungsrelevant
> Nur **quadratische** Matrizen können Inverse besitzen, und **nicht alle quadratischen Matrizen tun das**. Wenn $A^{-1}$ existiert, heißt $A$ [[Regulaere-Matrix|regulär]] (regular, auch invertierbar). Andernfalls ist $A$ *singulär* (singular).

## Warum die Inverse wichtig ist

Wenn $A$ invertierbar ist, kannst du $Ax = b$ in einer Zeile lösen:

$$Ax = b \quad \Longrightarrow \quad x = A^{-1}b$$

Multipliziere beide Seiten von links mit $A^{-1}$: $A^{-1}Ax = A^{-1}b$, und da $A^{-1}A = I$ ist, erhältst du $x = A^{-1}b$.

> [!tip] Wann anwenden
> Wenn du $Ax = b$ für **viele verschiedene** $b$-Vektoren mit derselben Matrix $A$ lösen musst, berechne $A^{-1}$ einmal und multipliziere dann. Für ein einzelnes $b$ ist das [[Gauss-Elimination|Gauß-Verfahren]] schneller.

## Eigenschaften

| Eigenschaft | Bedeutung |
|-------------|-----------|
| $(A^{-1})^{-1} = A$ | Zweimaliges Invertieren liefert die Ausgangsmatrix |
| $(AB)^{-1} = B^{-1}A^{-1}$ | Inverse eines Produkts = Produkt der Inversen, **in umgekehrter Reihenfolge** |
| $(A^T)^{-1} = (A^{-1})^T$ | Inverse der Transponierten = Transponierte der Inversen |
| $\det(A^{-1}) = 1 / \det(A)$ | Siehe [[Determinante]] |

> [!example]
> Für $A = \begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix}$ gilt: $A^{-1} = \begin{pmatrix} 1/2 & 0 \\ 0 & 1/3 \end{pmatrix}$
>
> Probe: $AA^{-1} = \begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix} \begin{pmatrix} 1/2 & 0 \\ 0 & 1/3 \end{pmatrix} = \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix} = I_2$ ✓

## Berechnungsmethoden

Die wichtigste Methode ist das [[Gauss-Jordan|Gauß-Jordan-Verfahren]]:
1. Schreibe die erweiterte Matrix $[A \mid I]$
2. Eliminiere, bis die linke Seite $I$ ist
3. Die rechte Seite ist dann $A^{-1}$

Für eine $2 \times 2$-Matrix gibt es eine Kurzformel (siehe [[Determinante]]):

$$A^{-1} = \frac{1}{ad - bc} \begin{pmatrix} d & -b \\ -c & a \end{pmatrix} \quad \text{(falls } ad - bc \neq 0\text{)}$$

> [!tip] Probe nicht vergessen
> Überprüfe dein Ergebnis stets durch Multiplikation $A \cdot A^{-1}$. Ergibt sich die Einheitsmatrix, stimmt die Rechnung.

## Wichtige Merkregeln

- Die Inverse ist **nur für quadratische Matrizen** definiert. Rechteckige Matrizen besitzen keine Inverse im obigen Sinne.
- Die Reihenfolge bei $(AB)^{-1} = B^{-1}A^{-1}$ ist entscheidend: die innere Matrix wird zur äußeren.
- Die Inverse eines Skalars $\lambda$ (einer $1 \times 1$-Matrix) ist $1/\lambda$ — vorausgesetzt $\lambda \neq 0$, was mit $\det(\lambda) \neq 0$ übereinstimmt.

> **Nächste Schritte:** [[Gauss-Jordan]] — Schritt-für-Schritt-Berechnung der Inversen | [[Regulaere-Matrix]] — wann die Inverse existiert | [[Determinante]] — Determinante und Invertierbarkeit

> [!info] English: [[../../EN/matrix-inversion/Matrix-Inverse]]

---

*Zuletzt überprüft: 2026-06-09*
