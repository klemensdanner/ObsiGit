# Lineare Funktion

> **Voraussetzungen:** [[Vektor]], [[Matrix]]

Eine **lineare Funktion** (engl. linear function, auch *lineare Abbildung* oder *lineare Transformation* genannt) ist eine Funktion, die „schön" mit der Vektoraddition und der Skalarmultiplikation zusammenspielt. Sie bewahrt die Struktur des Vektorraums.

Stell es dir so vor: Wenn du die Eingabe skalierst, skaliert die Ausgabe genauso. Wenn du zwei Eingaben addierst, ist die Ausgabe die Summe der einzelnen Ausgaben. Keine Überraschungen, keine Kurven — rein geradliniges Verhalten.

## Die zwei definierenden Eigenschaften

Eine Funktion $f: \mathbb{R}^n \to \mathbb{R}^m$ ist genau dann linear, wenn:

1. **Additivität** (engl. additivity): $f(x + y) = f(x) + f(y)$ für alle Vektoren $x, y$
2. **Homogenität** (engl. homogeneity): $f(\alpha x) = \alpha f(x)$ für alle Vektoren $x$ und Skalare $\alpha$

Aus diesen beiden Eigenschaften folgt sofort $f(0) = 0$ — eine lineare Funktion bildet den Nullvektor stets auf den Nullvektor ab. Das ist ein schneller Test: Erfüllt eine Funktion das nicht, kann sie nicht linear sein.

> [!example] Linearität prüfen
> Ist $f(x_1, x_2) = (3x_1 - x_2,\; x_1 + 2x_2)$ linear?
>
> **Additivität:**
> $f(x+y) = (3(x_1+y_1) - (x_2+y_2),\; (x_1+y_1) + 2(x_2+y_2))$
> $\quad = (3x_1 - x_2 + 3y_1 - y_2,\; x_1 + 2x_2 + y_1 + 2y_2)$
> $\quad = (3x_1 - x_2, x_1 + 2x_2) + (3y_1 - y_2, y_1 + 2y_2) = f(x) + f(y)$ ✓
>
> **Homogenität:**
> $f(\alpha x) = (3\alpha x_1 - \alpha x_2,\; \alpha x_1 + 2\alpha x_2)$
> $\quad = \alpha(3x_1 - x_2, x_1 + 2x_2) = \alpha f(x)$ ✓
>
> → $f$ ist linear.

> [!example] Nicht linear
> $g(x_1, x_2) = (x_1^2,\; x_2)$ ist **nicht** linear. Test der Homogenität: $g(2x) = (4x_1^2, 2x_2) \neq 2g(x) = (2x_1^2, 2x_2)$.
>
> Auch $h(x_1, x_2) = (x_1 + 1,\; x_2)$ ist nicht linear, da $h(0) = (1, 0) \neq (0, 0)$. Lineare Funktionen müssen den Nullvektor stets auf den Nullvektor abbilden.

## Jede lineare Funktion ist eine Matrix

Das ist die entscheidende Verbindung zu [[Matrix|Matrizen]]:

> [!warning] Prüfungsrelevant
> Jede lineare Funktion $f: \mathbb{R}^n \to \mathbb{R}^m$ kann als $f(x) = Ax$ für eine $m \times n$-Matrix $A$ geschrieben werden.
>
> Die Spalten von $A$ sind genau $f(e_1), f(e_2), \ldots, f(e_n)$ — die Bilder der **Standardbasis** (engl. standard basis).

> [!example] Von der Funktion zur Matrix
> Betrachte $f(x_1, x_2, x_3) = (2x_1 - x_3,\; x_1 + 3x_2 + x_3)$ von $\mathbb{R}^3$ nach $\mathbb{R}^2$.
>
> Setze die Basisvektoren ein:
> - $f(1,0,0) = (2, 1)$ → Spalte 1
> - $f(0,1,0) = (0, 3)$ → Spalte 2
> - $f(0,0,1) = (-1, 1)$ → Spalte 3
>
> Also $f(x) = \begin{pmatrix} 2 & 0 & -1 \\ 1 & 3 & 1 \end{pmatrix} \begin{pmatrix} x_1 \\ x_2 \\ x_3 \end{pmatrix}$

## Wichtige Fachbegriffe

Neben der Darstellung als Matrix sind zwei Mengen besonders wichtig, um eine lineare Funktion zu verstehen:

| Begriff | Schreibweise | Bedeutung |
|---------|-------------|-----------|
| **[[Kern]]** (engl. kernel) | $\operatorname{Kern}(f)$ | Alle Eingaben, die auf $0$ abgebildet werden: $\{x \mid f(x) = 0\}$ |
| **[[Kern-und-Bild|Bild]]** (engl. image) | $\operatorname{Bild}(f)$ | Alle Ausgaben, die tatsächlich erreicht werden: $\{f(x) \mid x \in \mathbb{R}^n\}$ |

Diese werden im [[Kern|Kapitel zum Kern]] ausführlich behandelt.

> **Nächste Schritte:** [[Linearkombination]] — Spann und die Kombination von Vektoren verstehen | [[Kern]] — die Menge der Vektoren, die eine Funktion auf Null abbildet

> [!info] English: [[../../EN/prerequisites/Linear-Function]]

---

*Zuletzt geprüft: 2026-06-09*
