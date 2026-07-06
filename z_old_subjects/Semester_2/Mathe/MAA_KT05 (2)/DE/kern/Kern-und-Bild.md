# Kern und Bild

> **Voraussetzungen:** [[Kern]], [[Rang]], [[Lineare-Funktion]]

Jede [[Lineare-Funktion|lineare Funktion]] $f: V \to W$ hat zwei fundamentale Unterräume: den **Kern** (engl. *kernel* — das, was auf Null abgebildet wird) und das **Bild** (engl. *image* — das, was tatsächlich herauskommt). Zusammen erzählen sie die vollständige Geschichte der Funktion.

## Definitionen

| Raum | Notation | Definition | In Worten |
|------|----------|------------|-----------|
| **Kern** | $\operatorname{Kern}(f)$ | $\{x \in V \mid f(x) = 0\}$ | "Alles, was zu Null zermalmt wird" |
| **Bild** | $\operatorname{Bild}(f)$ | $\{f(x) \mid x \in V\}$ | "Alles, was tatsächlich herauskommt" |

Für eine [[Matrix|Matrix]] $A$, die $f(x) = Ax$ repräsentiert:

- $\operatorname{Kern}(A) = \{x \mid Ax = 0\}$ — Lösungsmenge des homogenen Systems
- $\operatorname{Bild}(A) = \operatorname{span}\{\text{Spalten von } A\}$ — der **Spaltenraum** (engl. *column space*)

> [!tip] Intuition
> Stell dir einen Projektor vor, der ein 3D-Objekt auf eine 2D-Leinwand wirft:
> - **Bild** = der 2D-Schatten auf der Leinwand (was man sieht)
> - **Kern** = die Richtung senkrecht zur Leinwand (die Tiefeninformation, die verloren geht)
> - Alles entlang der Kern-Richtung wird auf denselben Punkt auf der Leinwand "zerdrückt"

## Der Rangsatz (Dimensionssatz)

> [!warning] Prüfungsrelevant

Für eine lineare Funktion $f: V \to W$, wobei $V$ endliche Dimension $n$ hat:

$$\dim(\operatorname{Kern}(f)) + \dim(\operatorname{Bild}(f)) = \dim(V)$$

In Worten: **Eingabedimension = zerstörte Dimensionen + erhaltene Dimensionen.**

Für eine $m \times n$-Matrix $A$:

$$\dim(\operatorname{Kern}(A)) + \operatorname{rang}(A) = n$$

wobei $\operatorname{rang}(A) = \dim(\operatorname{Bild}(A))$ (siehe [[Rang]]).

> [!example]
> Für die Funktion aus UE_11.2 (siehe [[Kern-Berechnen|Kern berechnen]]):
> - Eingabedimension $n = 4$ ($x \in \mathbb{R}^4$)
> - $\dim(\operatorname{Kern}(f)) = 1$ (eine freie Variable $\to$ der Kern ist eine Gerade)
> - Also $\operatorname{rang}(A) = 4 - 1 = 3$ (das Bild ist 3-dimensional)
>
> Probe: Die Elimination ergab 3 Nicht-Null-Zeilen $\to$ Rang = 3 $\checkmark$

## Was die Zahlen bedeuten

| Situation | Bedeutung |
|-----------|-----------|
| $\dim(\operatorname{Kern}) = 0$ | $f$ ist **injektiv** (engl. *injective*, eineindeutig). Nichts geht verloren. |
| $\dim(\operatorname{Bild}) = \dim(W)$ | $f$ ist **surjektiv** (engl. *surjective*, onto). Jede Ausgabe ist erreichbar. |
| Beides oben | $f$ ist **bijektiv** (invertierbar) — $A$ ist [[Regulaere-Matrix\|regulär]] |
| $\dim(\operatorname{Kern}) > 0$ | $f$ verliert Information. Mehrere Eingaben führen zur selben Ausgabe. |

> [!example] Zusammenhang
> - $f$ injektiv $\Longleftrightarrow$ $\operatorname{Kern}(f) = \{0\}$
> - $f$ surjektiv $\Longleftrightarrow$ $\operatorname{Bild}(f) = W$
> - $f$ bijektiv $\Longleftrightarrow$ beides gilt

## Das Bild berechnen

$\operatorname{Bild}(A)$ = Spaltenraum von $A$. So findest du eine Basis:

1. Wende die [[Gauss-Elimination|Gauß-Elimination]] auf $A$ an
2. Identifiziere die **Pivot-Spalten** in der **ursprünglichen** Matrix $A$ (nicht in der eliminierten Form!)
3. Diese Spalten bilden eine Basis von $\operatorname{Bild}(A)$

> [!example]
> Für $A = \begin{pmatrix} -1 & 2 & 0 & 2 \\ 2 & -1 & 3 & 1 \\ 0 & 3 & 3 & 9 \end{pmatrix}$ aus UE_11.2:
>
> Pivots in den Spalten 1, 2 und 4 $\to$ $\operatorname{Bild}(A) = \operatorname{span}\left\{\begin{pmatrix}-1\\2\\0\end{pmatrix}, \begin{pmatrix}2\\-1\\3\end{pmatrix}, \begin{pmatrix}2\\1\\9\end{pmatrix}\right\}$
>
> $\dim(\operatorname{Bild}(A)) = 3 = \operatorname{rang}(A)$ $\checkmark$

## Visuelle Zusammenfassung

```
Eingaberaum V (Dimension n)
    │
    │  f(x) = Ax
    ▼
Ausgaberaum W
    │
    ├── Kern (Dimension k): Vektoren, die auf Null abgebildet werden
    │   "Verlorene" Dimensionen: n - rang(A)
    │
    └── Bild (Dimension r): Vektoren, die tatsächlich erreicht werden
        "Erhaltene" Dimensionen: rang(A)

    n = k + r   ← Rangsatz (Dimensionssatz)
```

> **Nächste Schritte:** [[Kern-vs-Loesungsmenge]] — wie Kern und Bild mit dem Lösen von $Ax = b$ zusammenhängen | [[Rang]] — der Rang-Begriff im Detail

> [!info] English: [[../../EN/kernel/Kernel-and-Image]]

---

*Zuletzt überprüft: 2026-06-09*
