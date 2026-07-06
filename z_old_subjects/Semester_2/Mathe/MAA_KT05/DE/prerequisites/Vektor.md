# Vektor

> **Voraussetzungen:** keine — dieser Artikel ist ein Einstiegspunkt

Ein **Vektor** (engl. vector) ist eine geordnete Liste von Zahlen. Man kann ihn sich vorstellen als:
- Einen Pfeil, der im Raum in eine Richtung zeigt
- Eine Zeile oder Spalte in einer Tabelle
- Einen Datenpunkt mit mehreren Koordinaten
- Die Koeffizienten in einer Gleichung wie $3x_1 - 2x_2 + x_3$

Wir arbeiten im $\mathbb{R}^n$ — der Menge aller Vektoren mit $n$ reellen Komponenten.

## Schreibweise

Ein Vektor mit $n$ Komponenten kann als **Spaltenvektor** (engl. column vector) oder **Zeilenvektor** (engl. row vector) geschrieben werden:

$$v = \begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix} \quad \text{oder} \quad v = (v_1, v_2, \ldots, v_n)$$

Beide Schreibweisen sind gleichwertig. Die Spaltenform wird bevorzugt, wenn Vektoren mit [[Matrix|Matrizen]] in Wechselwirkung treten.

## Grundlegende Operationen

**Vektoraddition** (engl. vector addition) — komponentenweise addieren:

$$\begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix} + \begin{pmatrix} w_1 \\ w_2 \\ \vdots \\ w_n \end{pmatrix} = \begin{pmatrix} v_1 + w_1 \\ v_2 + w_2 \\ \vdots \\ v_n + w_n \end{pmatrix}$$

**Skalarmultiplikation** (engl. scalar multiplication) — jede Komponente mit derselben Zahl $\alpha$ multiplizieren:

$$\alpha \cdot \begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix} = \begin{pmatrix} \alpha v_1 \\ \alpha v_2 \\ \vdots \\ \alpha v_n \end{pmatrix}$$

> [!example] Konkretes Beispiel
> Im $\mathbb{R}^3$: $v = (1, -2, 4)$, $w = (3, 0, -1)$
>
> $v + w = (4, -2, 3)$
>
> $2v = (2, -4, 8)$
>
> $-w = (-3, 0, 1)$

## Besondere Vektoren

- **Nullvektor** (engl. zero vector) $0 = (0, 0, \ldots, 0)$ — addiert man ihn, ändert sich nichts: $v + 0 = v$
- **Inverser Vektor** (engl. inverse vector) $-v = (-v_1, -v_2, \ldots, -v_n)$ — es gilt $v + (-v) = 0$

## Eigenschaften der Vektoraddition

Die Vektoraddition gehorcht denselben Regeln wie die gewöhnliche Addition:
- **Kommutativgesetz:** $v + w = w + v$
- **Assoziativgesetz:** $(u + v) + w = u + (v + w)$
- **Neutrales Element:** $v + 0 = v$
- **Inverses Element:** $v + (-v) = 0$

Diese Eigenschaften machen $\mathbb{R}^n$ zu einer kommutativen Gruppe bezüglich der Addition — eine Grundvoraussetzung für einen Vektorraum.

## Schlüsselkonzept

Jeder Vektor im $\mathbb{R}^n$ lässt sich aus den **Standardbasisvektoren** (engl. standard basis vectors) zusammensetzen:

$$e_1 = \begin{pmatrix}1\\0\\0\\ \vdots\\0\end{pmatrix}, \; e_2 = \begin{pmatrix}0\\1\\0\\ \vdots\\0\end{pmatrix}, \; \ldots, \; e_n = \begin{pmatrix}0\\0\\ \vdots\\0\\1\end{pmatrix}$$

Zum Beispiel: $(3, -2, 5) = 3e_1 + (-2)e_2 + 5e_3$

Diese Idee — Vektoren durch Skalierung und Addition zu bauen — nennt sich **Linearkombination** (engl. linear combination) und ist das zentrale Konzept der linearen Algebra.

## Wohin das führt

Vektoren sind die Objekte, die:
- [[Lineare-Funktion|Lineare Funktionen]] als Eingabe nehmen und als Ausgabe liefern
- [[Lineare-Gleichungssysteme|Lineare Gleichungssysteme]] lösen
- [[Matrix|Matrizen]] transformieren
- [[Kern|Kerne]] bilden

> **Nächste Schritte:** [[Matrix]] — wie man Vektoren in rechteckigen Anordnungen organisiert | [[Linearkombination]] — neue Vektoren aus vorhandenen bauen

> [!info] English: [[../../EN/prerequisites/Vector]]

---

*Zuletzt geprüft: 2026-06-09*
