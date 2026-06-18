# Gauß-Jordan

> **Voraussetzungen:** [[Matrix-Inverse]], [[Gauss-Elimination]], [[Zeilenoperationen]]

Das **Gauß-Jordan-Verfahren** (Gauss-Jordan elimination) berechnet die [[Matrix-Inverse|Inverse]] einer Matrix. Es erweitert die [[Gauss-Elimination|Gauß-Elimination]] — während die Gauß-Elimination bei der oberen Dreiecksform aufhört, geht Gauß-Jordan bis zur Einheitsmatrix weiter.

## Motivation

Die Formel für die Inverse über Kofaktoren (siehe [[Determinante]]) ist theoretisch elegant, aber für $n > 3$ rechnerisch äußerst aufwändig. Gauß-Jordan ist die praktische Methode.

## Der Algorithmus

Gegeben eine $n \times n$-Matrix $A$:

1. Schreibe die **erweiterte Matrix** (augmented matrix) $[A \mid I_n]$
2. Wende elementare [[Zeilenoperationen|Zeilenoperationen]] (elementary row operations) an, um die linke Seite in $I_n$ zu überführen
3. Die rechte Seite ist dann $A^{-1}$: du erhältst $[I_n \mid A^{-1}]$

> [!tip] Die Intuition dahinter
> Jede Zeilenoperation entspricht einer Linksmultiplikation mit einer bestimmten Matrix. Die Sequenz von Operationen, die $A$ in $I$ überführt, ist genau $A^{-1}$. Wendet man dieselben Operationen auf $I$ an, erhält man $A^{-1}$.

## Unterschied zur Gauß-Elimination

| Schritt | Gauß-Elimination | Gauß-Jordan |
|---------|------------------|-------------|
| **Vorwärtselimination** (forward elimination) — Nullen unterhalb der Pivots | ✅ | ✅ |
| Pivots auf $1$ setzen | Optional | ✅ (jede Pivotzeile skalieren) |
| **Rückwärtselimination** (backward elimination) — Nullen **oberhalb** der Pivots | ❌ | ✅ |
| Endergebnis | [[Obere-Dreiecksform|Obere Dreiecksform]] | Einheitsmatrix $I$ |

Die Gauß-Elimination erzeugt ein Dreieck; Gauß-Jordan geht weiter und erzeugt die Einheitsmatrix.

## Ausführliches Beispiel (UE_11.5)

> Berechne die Inverse von $A = \begin{pmatrix} 1 & 1 & 1 \\ 1 & 2 & 3 \\ 0 & 1 & 3 \end{pmatrix}$

**Schritt 1: Mit $I_3$ erweitern**

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 1 & 1 & 0 & 0 \\ 1 & 2 & 3 & 0 & 1 & 0 \\ 0 & 1 & 3 & 0 & 0 & 1 \end{array}\right)$$

**Schritt 2: Vorwärtselimination** (Nullen unterhalb der Pivots)

*Spalte 1:* $Z_2 \leftarrow Z_2 - Z_1$

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 1 & 1 & 0 & 0 \\ 0 & 1 & 2 & -1 & 1 & 0 \\ 0 & 1 & 3 & 0 & 0 & 1 \end{array}\right)$$

*Spalte 2:* $Z_3 \leftarrow Z_3 - Z_2$

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 1 & 1 & 0 & 0 \\ 0 & 1 & 2 & -1 & 1 & 0 \\ 0 & 0 & 1 & 1 & -1 & 1 \end{array}\right)$$

Nun ist die linke Seite eine obere Dreiecksmatrix. **Gauß-Jordan fährt fort** — eliminiere nun *oberhalb* der Diagonalen:

**Schritt 3: Rückwärtselimination** (Nullen oberhalb der Pivots)

*Spalte 3 oberhalb von Zeile 3 eliminieren:*
- $Z_2 \leftarrow Z_2 - 2Z_3$
- $Z_1 \leftarrow Z_1 - Z_3$

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 0 & 0 & 1 & -1 \\ 0 & 1 & 0 & -3 & 3 & -2 \\ 0 & 0 & 1 & 1 & -1 & 1 \end{array}\right)$$

*Spalte 2 oberhalb von Zeile 2 eliminieren:* $Z_1 \leftarrow Z_1 - Z_2$

$$\left(\begin{array}{ccc|ccc} 1 & 0 & 0 & 3 & -2 & 1 \\ 0 & 1 & 0 & -3 & 3 & -2 \\ 0 & 0 & 1 & 1 & -1 & 1 \end{array}\right)$$

**Schritt 4: Inverse ablesen**

$$A^{-1} = \begin{pmatrix} 3 & -2 & 1 \\ -3 & 3 & -2 \\ 1 & -1 & 1 \end{pmatrix}$$

> [!tip] Immer überprüfen
> Multipliziere $A \cdot A^{-1}$ und bestätige, dass du $I$ erhältst. Schnelle Stichprobe:
> Zeile 1 von $A$ · Spalte 1 von $A^{-1}$: $1 \cdot 3 + 1 \cdot (-3) + 1 \cdot 1 = 3 - 3 + 1 = 1$ ✓

## Randfall: Singuläre Matrix

Wenn während der Elimination auf der linken Seite eine **Nullzeile** (row of zeros) erscheint, ist die Matrix singulär — $A^{-1}$ existiert nicht. Man kann die linke Seite nicht zu $I$ umformen, weil einige Zeilen unrettbar zu Null geworden sind.

> [!warning] Prüfungsrelevant
> Wenn die Elimination auf der linken Seite $[0\;0\;\ldots\;0 \mid \text{irgendeine Zeile}]$ ergibt, brich sofort ab — die Matrix ist nicht [[Regulaere-Matrix|regulär]]. Es existiert keine Inverse.

> [!tip] Erkennung einer Nullzeile
> Eine Nullzeile erkennst du daran, dass in einer Zeile **alle** Einträge auf der linken Seite der erweiterten Matrix Null sind. Die rechte Seite darf beliebig sein — eine Nullzeile links reicht aus, um die Singularität zu besiegeln.

> **Nächste Schritte:** [[Regulaere-Matrix]] — der vollständige Katalog der Invertierbarkeitskriterien | [[Determinante]] — Determinantenkriterium und die $2 \times 2$-Inversenformel

> [!info] English: [[../../EN/matrix-inversion/Gauss-Jordan]]

---

*Zuletzt überprüft: 2026-06-09*
