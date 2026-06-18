# Kern

> **Voraussetzungen:** [[Lineare-Funktion]], [[Vektor]], [[Matrix]]

Der **Kern** (engl. *kernel*) einer [[Lineare-Funktion|linearen Funktion]] ist die Menge aller Eingabevektoren, die auf den Nullvektor abgebildet werden. Man kann ihn sich als den "blinden Fleck" der Funktion vorstellen — alles, was die Funktion "nicht sieht" oder "zu Nichts zermalmt".

## Definition

Für eine lineare Funktion $f: V \to W$:

$$\operatorname{Kern}(f) = \{x \in V \mid f(x) = 0\}$$

Für eine [[Matrix|Matrix]] $A$ (die eine lineare Funktion $f(x) = Ax$ repräsentiert):

$$\operatorname{Kern}(A) = \{x \in \mathbb{R}^n \mid Ax = 0\}$$

> [!tip] Anschaulich
> Der Kern beantwortet die Frage: "Welche Vektoren $x$ ergeben $Ax = 0$?"
>
> Es ist die Lösungsmenge des [[Homogen-vs-Inhomogen|homogenen Gleichungssystems]] $Ax = 0$.

## Intuition: Was "zermalmt" wird

Stell dir $f(x_1, x_2) = (x_1 - x_2,\; 0)$ vor. Diese Funktion nimmt $(x_1, x_2)$ und gibt $(x_1 - x_2, 0)$ zurück.

Was wird auf $(0,0)$ abgebildet? Wir brauchen $x_1 - x_2 = 0$, also $x_1 = x_2$. Der Kern ist die Gerade $\{(t, t) \mid t \in \mathbb{R}\}$ — alle Vektoren, deren beide Komponenten gleich sind.

> [!example] Veranschaulichung
> Für $f(x) = Ax$ mit $A = \begin{pmatrix} 1 & -1 \\ 0 & 0 \end{pmatrix}$:
>
> Die gesamte Gerade $y = x$ wird auf $(0,0)$ abgebildet. Die Matrix "zerdrückt" eine Dimension zu Null.
>
> $\operatorname{Kern}(A) = \operatorname{span}\left\{\begin{pmatrix}1\\1\end{pmatrix}\right\}$ — ein 1-dimensionaler Unterraum.

## Der Kern ist stets ein Unterraum

Im Gegensatz zu allgemeinen Lösungsmengen (die sogenannte [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeiten]] sind) ist der Kern ein echter **Unterraum** (engl. *subspace*) des Eingaberaums. Das bedeutet:

1. **$0 \in \operatorname{Kern}(f)$:** Der Nullvektor ist immer im Kern (da $f(0) = 0$ für jede lineare Funktion)
2. **Abgeschlossen unter Addition:** Wenn $x, y \in \operatorname{Kern}(f)$, dann $x + y \in \operatorname{Kern}(f)$
3. **Abgeschlossen unter skalarer Multiplikation:** Wenn $x \in \operatorname{Kern}(f)$, dann $\alpha x \in \operatorname{Kern}(f)$

## Kern und Injektivität

> [!warning] Prüfungsrelevant

Eine lineare Funktion $f$ ist **injektiv** (engl. *injective*, one-to-one: verschiedene Eingaben $\to$ verschiedene Ausgaben) genau dann, wenn ihr Kern nur den Nullvektor enthält:

$$f \text{ ist injektiv} \quad \Longleftrightarrow \quad \operatorname{Kern}(f) = \{0\}$$

**Begründung:** Enthielte $\operatorname{Kern}(f)$ ein $v \neq 0$, dann gälte $f(x) = f(x + v)$ für jedes $x$ (da $f(v) = 0$), was die Injektivität verletzt. Ist umgekehrt $\operatorname{Kern}(f) = \{0\}$ und $f(x) = f(y)$, dann folgt $f(x - y) = 0$, also $x - y = 0$, also $x = y$.

## Kern und Invertierbarkeit

Für eine quadratische Matrix $A$ ist $\operatorname{Kern}(A) = \{0\}$ äquivalent dazu, dass $A$ [[Regulaere-Matrix|regulär/invertierbar]] ist:

$$\operatorname{Kern}(A) = \{0\} \;\Longleftrightarrow\; \det(A) \neq 0 \;\Longleftrightarrow\; A \text{ ist invertierbar}$$

Ein nichttrivialer Kern bedeutet, dass die Matrix mindestens eine Dimension "kollabieren" lässt — das ist irreversibel. Was einmal zermalmt wurde, kann man nicht rückgängig machen.

> [!tip] Merksatz
> $\operatorname{Kern}(A) = \{0\}$ bedeutet: $Ax = 0$ hat nur die triviale Lösung $x = 0$.
> $\operatorname{Kern}(A) \neq \{0\}$ bedeutet: $Ax = 0$ hat unendlich viele Lösungen.

## Beispiele

**Trivialer Kern:** $A = \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix}$ (Einheitsmatrix). Das System $Ax = 0$ erzwingt $x_1 = 0$ und $x_2 = 0$. Also $\operatorname{Kern}(A) = \{0\}$ — nur der Nullvektor. Die zugehörige Funktion ist injektiv.

**Nichttrivialer Kern:** $A = \begin{pmatrix} 1 & 2 \\ 2 & 4 \end{pmatrix}$. Die zweite Zeile ist das Doppelte der ersten. Das System $Ax = 0$ reduziert sich auf $x_1 + 2x_2 = 0$. Mit freier Variable $x_2 = t$ folgt $x_1 = -2t$, also:

$$\operatorname{Kern}(A) = \operatorname{span}\left\{\begin{pmatrix}-2\\1\end{pmatrix}\right\}$$

Die Funktion ist nicht injektiv — der Kern ist eine Gerade durch den Ursprung.

**Nullmatrix:** $A = \begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}$. Jeder Vektor wird auf $(0,0)$ abgebildet. Der Kern ist der gesamte $\mathbb{R}^2$: $\operatorname{Kern}(A) = \mathbb{R}^2$. Dies ist der maximal mögliche Kern.

> **Nächste Schritte:** [[Kern-Berechnen]] — die Schritt-für-Schritt-Anleitung | [[Kern-und-Bild]] — der Zusammenhang zwischen Kern und Bild

> [!info] English: [[../../EN/kernel/Kernel]]

---

*Zuletzt überprüft: 2026-06-09*
