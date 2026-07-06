# Gauss-Elimination

> **Voraussetzungen:** [[Lineare-Gleichungssysteme]], [[Matrix]], [[Zeilenoperationen]]

Die **Gauss-Elimination** (Gaussian elimination), auch **Gauß'sches Eliminationsverfahren** genannt, ist der wichtigste Algorithmus der linearen Algebra. Sie transformiert jedes lineare System $Ax = b$ systematisch in die [[Obere-Dreiecksform|obere Dreiecksform]], aus der sich die Losungen durch Ruckwartssubstitution ablesen lassen.

## Motivation: Warum wir eine Methode brauchen

Zweimal-zwei-Systeme ($2 \times 2$) lassen sich noch von Hand losen ($x_1$ isolieren, in die andere Gleichung einsetzen). Doch fur $n \times n$-Systeme mit $n > 2$ wird dieser Ansatz schnell unubersichtlich. Die Gauss-Elimination ist die systematische, maschinenfreundliche Alternative, die fur beliebige Großen funktioniert.

## Der Algorithmus (Schritt fur Schritt)

Gegeben ist eine erweiterte Matrix $[A \mid b]$:

1. **Vorwartselimination** (forward elimination) -- Spalte fur Spalte, von links nach rechts:
   - Finde das **Pivot** (pivot) bzw. **Pivotelement** -- den ersten Nicht-Null-Eintrag in der aktuellen Spalte, auf oder unterhalb der aktuellen Zeile
   - Wenn die Pivot-Zeile nicht die aktuelle Zeile ist, vertausche die Zeilen (siehe [[Zeilenoperationen]])
   - Fur jede Zeile **unterhalb** der Pivot-Zeile: subtrahiere ein Vielfaches der Pivot-Zeile, um den Eintrag unterhalb des Pivots zu eliminieren

2. **Ruckwartssubstitution** (back-substitution) -- sobald die [[Obere-Dreiecksform|obere Dreiecksform]] erreicht ist, lose von unten nach oben:
   - Die letzte Nicht-Null-Zeile ergibt die letzte Variable
   - Setze diese in die daruberliegende Zeile ein, um die nachste Variable zu erhalten
   - Fahre damit nach oben fort

> [!warning] Prufungsrelevant
> Die Gauss-Elimination liefert drei Dinge gleichzeitig:
> 1. Ob eine Losung existiert (keine Widerspruchszeile)
> 2. Den Typ der [[Loesungsmenge|Losungsmenge]] (eindeutig vs. unendlich)
> 3. Die tatsachlichen Losungswerte

## Durchgerechnetes Beispiel

> Aus UE_10.3: Lose $\begin{pmatrix} 2 & 1 & 2 \\ -1 & 0 & 1 \\ 2 & 10 & 0 \end{pmatrix} x = \begin{pmatrix} 1 \\ 2 \\ 3 \end{pmatrix}$

**Schritt 1: Erweiterte Matrix aufschreiben**

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ -1 & 0 & 1 & 2 \\ 2 & 10 & 0 & 3 \end{array}\right)$$

**Schritt 2: Vorwartselimination**

*Spalte 1 -- Pivot ist $2$ in Zeile 1:*
- Zeile 2: $Z_2 \leftarrow Z_2 + \frac{1}{2}Z_1$ (eliminiert die $-1$)
- Zeile 3: $Z_3 \leftarrow Z_3 - Z_1$ (eliminiert die $2$)

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ 0 & 0.5 & 2 & 2.5 \\ 0 & 9 & -2 & 2 \end{array}\right)$$

*Spalte 2 -- Pivot ist $0.5$ in Zeile 2:*
- Zeile 3: $Z_3 \leftarrow Z_3 - 18Z_2$ (eliminiert $9$, da $9/0.5 = 18$)

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ 0 & 0.5 & 2 & 2.5 \\ 0 & 0 & -38 & -43 \end{array}\right)$$

Jetzt sind wir in oberer Dreiecksform. Keine Zeile wie $(0\;0\;0 \mid c)$ mit $c \neq 0$ $\rightarrow$ Losung existiert. Drei Pivots, drei Variablen $\rightarrow$ eindeutige Losung.

**Schritt 3: Ruckwartssubstitution**

Aus Zeile 3: $-38x_3 = -43$ $\rightarrow$ $x_3 = \frac{43}{38}$

Aus Zeile 2: $0.5x_2 + 2x_3 = 2.5$ $\rightarrow$ $0.5x_2 = 2.5 - 2 \cdot \frac{43}{38}$ $\rightarrow$ $x_2 = \ldots$

Aus Zeile 1: $2x_1 + x_2 + 2x_3 = 1$ $\rightarrow$ nach $x_1$ auflosen

> [!tip] Notation
> In deutschen Texten wird die Gauss-Elimination auch oft als **Gauß-Algorithmus** oder **Gauß-Verfahren** bezeichnet. Die englische Schreibweise ,,Gaussian elimination" ist jedoch ebenso gebrauchlich. Die grundlegende Idee ist in beiden Fallen identisch.

## Sonderfalle

| Situation | Vorgehen |
|-----------|----------|
| **Nullpivot** (zero pivot) -- aktuelle Spalte hat nur Nullen auf oder unterhalb der aktuellen Zeile | Mit einer darunterliegenden Zeile [[Zeilenoperationen|vertauschen]], die einen Nicht-Null-Eintrag hat. Existiert keine, zur nachsten Spalte ubergehen (dies erzeugt eine freie Variable). |
| **Widerspruchszeile** (contradiction row) -- eine Zeile wie $(0\;0\;\ldots\;0 \mid c)$ mit $c \neq 0$ | Abbruch -- das System hat **keine Losung**. |
| **Nullzeile** -- $(0\;0\;\ldots\;0 \mid 0)$ | Die Zeile ist redundant. Entfernen oder als Nullzeile stehen lassen -- kein Einfluss auf die Losung. |

> **Ubung:** Lose die Systeme aus UE_10.4 und UE_10.5. Siehe [[Gauss-Elimination-Beispiele]] fur vollstandig durchgerechnete Losungen.

> **Nachste Schritte:** [[Gauss-Elimination-Beispiele]] -- zwei weitere durchgerechnete Beispiele mit Kommentar | [[Obere-Dreiecksform]] -- warum die Dreiecksform wichtig ist | [[Loesungsmenge]] -- die drei Ausgangstypen im Uberblick

> [!info] English: [[../../EN/systems-of-equations/Gaussian-Elimination]]

---

*Zuletzt uberpruft: 2026-06-09*
