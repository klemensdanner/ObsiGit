# Kern berechnen

> **Voraussetzungen:** [[Kern]], [[Gauss-Elimination]], [[Homogen-vs-Inhomogen]]

Der [[Kern|Kern]] ist eine *Menge* — um damit zu arbeiten, müssen wir ihn konkret als [[Linearkombination|Spann]] (engl. *span*) konkreter Vektoren beschreiben. Dieses Dokument zeigt, wie das Schritt für Schritt geht.

## Die Vorgehensweise

Um $\operatorname{Kern}(A)$ für eine $m \times n$-Matrix $A$ zu berechnen:

1. **Stelle das homogene System auf:** $Ax = 0$
2. **Wende die [[Gauss-Elimination|Gauß-Elimination]]** auf $A$ an (die rechte Seite bleibt null — eine erweiterte Matrix $[A \mid 0]$ ist nicht zwingend nötig, aber hilfreich)
3. **Identifiziere die freien Variablen** (engl. *free variables*) — Spalten ohne Pivot
4. **Drücke die Basisvariablen** (engl. *basic variables*, Spalten mit Pivot) durch die freien Variablen aus
5. **Schreibe den Kern als Spann:** Setze für jede freie Variable den Wert $1$ und die anderen auf $0$, lies die zugehörigen Basisvariablen ab
6. **Ergebnis:** $\operatorname{Kern}(A) = \operatorname{span}\{v_1, v_2, \ldots, v_k\}$, wobei $k$ = Anzahl der freien Variablen

> [!tip] Kernaussage
> $\dim(\operatorname{Kern}(A))$ = Anzahl der freien Variablen = $n - \operatorname{rang}(A)$.
>
> Dies ist der **Rangsatz** (engl. *rank-nullity theorem*), auch Dimensionssatz genannt — siehe [[Kern-und-Bild]].

## Ausführliches Beispiel (UE_11.2)

> Berechne $\operatorname{Kern}(f)$ mit $f\begin{pmatrix} x_1 \\ x_2 \\ x_3 \\ x_4 \end{pmatrix} = \begin{pmatrix} -x_1 + 2x_2 + 2x_4 \\ 2x_1 - x_2 + 3x_3 + x_4 \\ 3x_2 + 3x_3 + 9x_4 \end{pmatrix}$

**Schritt 1: Matrix $A$ von $f$ aufstellen**

$$A = \begin{pmatrix} -1 & 2 & 0 & 2 \\ 2 & -1 & 3 & 1 \\ 0 & 3 & 3 & 9 \end{pmatrix}$$

(Probe: $Ax$ ergibt exakt die drei Komponenten von $f(x)$.)

**Schritt 2: $Ax = 0$ aufstellen und Gauß-Elimination anwenden**

Erweiterte Matrix:

$$\left(\begin{array}{cccc|c} -1 & 2 & 0 & 2 & 0 \\ 2 & -1 & 3 & 1 & 0 \\ 0 & 3 & 3 & 9 & 0 \end{array}\right)$$

*Elimination:*
- $R_2 \leftarrow R_2 + 2R_1$:
$$\left(\begin{array}{cccc|c} -1 & 2 & 0 & 2 & 0 \\ 0 & 3 & 3 & 5 & 0 \\ 0 & 3 & 3 & 9 & 0 \end{array}\right)$$

- $R_3 \leftarrow R_3 - R_2$:
$$\left(\begin{array}{cccc|c} -1 & 2 & 0 & 2 & 0 \\ 0 & 3 & 3 & 5 & 0 \\ 0 & 0 & 0 & 4 & 0 \end{array}\right)$$

**Schritt 3: Struktur erkennen**

Pivots befinden sich in den Spalten 1, 2 und 4. Spalte 3 hat **kein Pivot** $\to$ $x_3$ ist eine **freie Variable**.

Basisvariablen: $x_1, x_2, x_4$ (ausgedrückt durch $x_3$).

**Schritt 4: Rückwärtssubstitution**

Zeile 3: $4x_4 = 0$ $\to$ $x_4 = 0$

Zeile 2: $3x_2 + 3x_3 + 5x_4 = 0$ $\to$ $3x_2 + 3x_3 + 0 = 0$ $\to$ $x_2 = -x_3$

Zeile 1: $-x_1 + 2x_2 + 0x_3 + 2x_4 = 0$ $\to$ $-x_1 + 2(-x_3) + 0 = 0$ $\to$ $-x_1 - 2x_3 = 0$ $\to$ $x_1 = -2x_3$

**Schritt 5: Parametrisierung**

Setze $x_3 = t$ (frei):

$$x = \begin{pmatrix} -2t \\ -t \\ t \\ 0 \end{pmatrix} = t \begin{pmatrix} -2 \\ -1 \\ 1 \\ 0 \end{pmatrix}$$

**Ergebnis:** $\operatorname{Kern}(f) = \operatorname{span}\left\{\begin{pmatrix} -2 \\ -1 \\ 1 \\ 0 \end{pmatrix}\right\}$ — ein 1-dimensionaler Unterraum des $\mathbb{R}^4$.

> [!tip] Probe
> $f\begin{pmatrix} -2 \\ -1 \\ 1 \\ 0 \end{pmatrix} = \begin{pmatrix} -(-2) + 2(-1) + 2(0) \\ 2(-2) - (-1) + 3(1) + 0 \\ 3(-1) + 3(1) + 9(0) \end{pmatrix} = \begin{pmatrix} 2 - 2 + 0 \\ -4 + 1 + 3 + 0 \\ -3 + 3 + 0 \end{pmatrix} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$ $\checkmark$

## Übungsaufgabe

> Berechne den Kern der Matrix aus UE_10.3: $A = \begin{pmatrix} 2 & 1 & 2 \\ -1 & 0 & 1 \\ 2 & 10 & 0 \end{pmatrix}$

*Hinweis: Da diese Matrix vollen Rang hat (3 Pivots bei 3 Spalten), was muss ihr Kern sein?*

> **Nächste Schritte:** [[Kern-und-Bild]] — wie Kern- und Bilddimension zusammenhängen | [[Kern-vs-Loesungsmenge]] — den Kern nutzen, um alle Lösungen von $Ax = b$ zu beschreiben

> [!info] English: [[../../EN/kernel/Computing-Kernel]]

---

*Zuletzt überprüft: 2026-06-09*
