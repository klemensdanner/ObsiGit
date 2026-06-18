# Rang

> **Voraussetzungen:** [[Matrix]], [[Linearkombination]]

Der **Rang** (engl. rank, auch *Rang einer Matrix*) einer Matrix misst, „wie viele Dimensionen sie tatsächlich nutzt". Er gibt an, wie viel Information die Matrix wirklich trägt — wie viele ihrer Spalten (oder Zeilen) tatsächlich unabhängig sind.

## Definition

Der Rang einer $m \times n$-Matrix $A$ ist die Dimension des Spaltenraums — die [[Linearkombination|lineare Hülle]] ihrer Spaltenvektoren:

$$\operatorname{Rang}(A) = \dim(\operatorname{span}\{\text{Spalten von } A\})$$

Gleichwertig: Der Rang ist die Anzahl der **Pivotspalten** (engl. pivot columns) nach dem [[Gaußsches-Eliminationsverfahren|Gaußschen Eliminationsverfahren]]. Jede Pivotspalte entspricht einer Basisvariable; Spalten ohne Pivot gehören zu freien Variablen.

> [!tip] Wichtige Tatsache
> Spaltenrang = Zeilenrang. Die Anzahl der unabhängigen Spalten ist stets gleich der Anzahl der unabhängigen Zeilen. Du kannst den Rang also über beide Wege berechnen.

> [!example] Visueller Vergleich
> $\begin{pmatrix} 1 & 0 & 2 \\ 0 & 1 & 3 \end{pmatrix}$ — Spalten: $(1,0)$, $(0,1)$ und $(2,3) = 2(1,0) + 3(0,1)$. Nur 2 unabhängige Spalten. **Rang = 2**.
>
> $\begin{pmatrix} 1 & 2 \\ 2 & 4 \end{pmatrix}$ — Zweite Spalte = $2 \times$ erste Spalte. Nur 1 unabhängige Spalte. **Rang = 1**.

## Was der Rang aussagt

Für eine $m \times n$-Matrix $A$:

| Rangwert | Bedeutung |
|----------|-----------|
| $\operatorname{Rang}(A) = n$ | **Voller Spaltenrang** (engl. full column rank) — Spalten sind linear unabhängig |
| $\operatorname{Rang}(A) = m$ | **Voller Zeilenrang** (engl. full row rank) — Zeilen spannen den gesamten Ausgaberaum auf |
| $\operatorname{Rang}(A) = m = n$ | **Voller Rang** (engl. full rank, quadratische Matrix) — $A$ ist [[Reguläre-Matrix|regulär/invertierbar]] |
| $\operatorname{Rang}(A) < \min(m, n)$ | **Rangdefekt** (engl. rank deficient) — manche Information ist redundant |

## Rang berechnen

1. Wende das [[Gaußsches-Eliminationsverfahren|Gaußsche Eliminationsverfahren]] an, um $A$ in [[Obere-Dreiecksform|obere Dreiecksform]] zu bringen
2. Zähle die Anzahl der **Zeilen ungleich Null** (diese entsprechen den Pivotpositionen)
3. Diese Anzahl ist der Rang

Die Pivotspalten sind genau jene Spalten, die in der eliminierten Form eine führende Eins (oder einen Pivotwert) enthalten. Spalten ohne Pivot entsprechen den freien Variablen und tragen nichts zum Rang bei.

> [!example]
> $A = \begin{pmatrix} 2 & 1 & 0 \\ -1 & 0 & 1 \\ 1 & 1 & 1 \end{pmatrix}$
>
> Nach der Elimination: $\begin{pmatrix} 2 & 1 & 0 \\ 0 & 0,5 & 1 \\ 0 & 0 & 0 \end{pmatrix}$
>
> Zwei Zeilen ungleich Null → $\operatorname{Rang}(A) = 2$

## Verbindung zu anderen Konzepten

> [!warning] Prüfungsrelevant
> Für eine quadratische $n \times n$-Matrix $A$ sind die folgenden Aussagen **alle äquivalent**. Ist eine wahr, sind alle wahr:
> - $\operatorname{Rang}(A) = n$ (voller Rang)
> - $A$ ist [[Reguläre-Matrix|regulär/invertierbar]]
> - $\det(A) \neq 0$ (siehe [[Determinante]])
> - $\operatorname{Kern}(A) = \{0\}$ (Kern enthält nur den Nullvektor — siehe [[Kern]])
> - $Ax = b$ hat für jedes $b$ eine eindeutige Lösung
> - Die Spalten von $A$ sind linear unabhängig

## Rang und Kern

Der **Rangsatz** (engl. Rank-Nullity Theorem, siehe [[Kern-und-Bild]]) verbindet den Rang mit dem [[Kern]]:

$$\dim(\operatorname{Kern}(A)) + \operatorname{Rang}(A) = n$$

wobei $n$ die Anzahl der Spalten ist. Ein höherer Rang bedeutet also einen kleineren Kern und umgekehrt.

> **Nächste Schritte:** [[Kern-und-Bild]] — die Rang-Kern-Beziehung im Detail | [[Reguläre-Matrix]] — wann Rang die Invertierbarkeit garantiert

> [!info] English: [[../../EN/prerequisites/Rank]]

---

*Zuletzt geprüft: 2026-06-09*
