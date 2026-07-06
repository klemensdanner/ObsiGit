# Linearkombination

> **Voraussetzungen:** [[Vektor]]

Eine **Linearkombination** (engl. linear combination) entsteht, wenn man Vektoren skaliert und addiert. Sie ist die grundlegendste Art, neue Vektoren aus vorhandenen zu bilden.

## Definition

Gegeben sind Vektoren $v_1, v_2, \ldots, v_k$ und Skalare (Zahlen) $\alpha_1, \alpha_2, \ldots, \alpha_k$. Der Ausdruck

$$\alpha_1 v_1 + \alpha_2 v_2 + \cdots + \alpha_k v_k$$

heißt **Linearkombination** von $v_1, \ldots, v_k$. Die $\alpha_i$ sind die **Koeffizienten** (engl. coefficients, auch Gewichte) der Kombination.

> [!example] Vektoren bauen
> Im $\mathbb{R}^2$ mit $v_1 = (1,0)$ und $v_2 = (0,1)$:
>
> - $3v_1 + 2v_2 = 3(1,0) + 2(0,1) = (3, 0) + (0, 2) = (3, 2)$
> - $-v_1 + 4v_2 = (-1, 4)$
> - $0v_1 + 0v_2 = (0, 0)$ (der Nullvektor — immer erreichbar)
>
> Mit nur diesen beiden Vektoren kann man **jeden Punkt** im $\mathbb{R}^2$ erreichen, da sie eine Basis bilden.
>
> Ein Gegenbeispiel: Mit $v_1 = (1,2)$ und $v_2 = (2,4)$ kann man nur Punkte auf der Geraden $y = 2x$ erreichen — der zweite Vektor ist ein Vielfaches des ersten und fügt keine neue Richtung hinzu.

## Die lineare Hülle (Spann)

Die **lineare Hülle** (engl. span, auch *Spann* genannt) einer Menge von Vektoren ist die Menge *aller* möglichen Linearkombinationen dieser Vektoren:

$$\operatorname{span}\{v_1, \ldots, v_k\} = \{\alpha_1 v_1 + \cdots + \alpha_k v_k \mid \alpha_1, \ldots, \alpha_k \in \mathbb{R}\}$$

Die lineare Hülle ist selbst ein Untervektorraum — sie ist abgeschlossen unter Addition und Skalarmultiplikation. Das bedeutet: Jede Linearkombination von Vektoren aus der linearen Hülle liegt wieder in der linearen Hülle.

> [!tip] Intuition
> Die lineare Hülle beantwortet: „Ausgehend von diesen Vektoren, welche Punkte kann ich durch Skalieren und Addieren erreichen?"
>
> - Lineare Hülle eines einzelnen Vektors ungleich Null im $\mathbb{R}^2$ → eine Gerade durch den Ursprung
> - Lineare Hülle zweier unabhängiger Vektoren im $\mathbb{R}^2$ → die gesamte Ebene
> - Lineare Hülle zweier abhängiger Vektoren (einer ist ein Vielfaches des anderen) → immer noch nur eine Gerade

## Lineare Unabhängigkeit (Kurzfassung)

Eine Menge von Vektoren heißt **linear unabhängig** (engl. linearly independent), wenn kein Vektor der Menge als Linearkombination der anderen geschrieben werden kann. Anders ausgedrückt: Die einzige Möglichkeit, den Nullvektor zu erhalten, ist, alle Koeffizienten auf Null zu setzen.

Formal: $\alpha_1 v_1 + \cdots + \alpha_k v_k = 0$ gilt **nur wenn** $\alpha_1 = \alpha_2 = \cdots = \alpha_k = 0$.

Wenn man den Nullvektor dagegen mit von Null verschiedenen Koeffizienten erzeugen kann, sind die Vektoren **linear abhängig** (engl. linearly dependent) — mindestens einer der Vektoren ist als Linearkombination der anderen darstellbar und somit „überflüssig".

> [!example]
> - $\{(1,0), (0,1)\}$ sind **unabhängig** im $\mathbb{R}^2$
> - $\{(1,0), (2,0)\}$ sind **abhängig** — $(2,0) = 2(1,0)$, der zweite ist nur eine skalierte Kopie des ersten

> [!warning] Prüfungsrelevant — UE_11.4
> Wenn das Gaußsche Eliminationsverfahren (engl. Gaussian elimination) Lösungsvektoren $v_1, \ldots, v_k$ liefert (einer pro freier Variable), dann sind diese Vektoren **immer linear unabhängig**. Wieso? Jeder $v_i$ hat eine $1$ an der Stelle „seiner" freien Variable — eine Position, an der alle anderen $v_j$ eine $0$ haben. Keine Linearkombination kann diese $1$ wegkürzen, ohne $v_i$ selbst zu verwenden.

## Wo Linearkombinationen vorkommen

Linearkombinationen sind das Herz der linearen Algebra. Sie tauchen in fast jedem Teilgebiet auf:

- **[[Matrix]]-Vektor-Produkt:** $Ax$ ist die Linearkombination der Spalten von $A$ mit den Gewichten $x_1, \ldots, x_n$
- **[[Lineare-Mannigfaltigkeit|Lineare Mannigfaltigkeiten]]:** Lösungen von $Ax = b$ sind verschobene lineare Hüllen
- **[[Kern|Kern]]** wird als $\operatorname{span}\{v_1, \ldots, v_k\}$ ausgedrückt
- **[[Rang]]** misst die Dimension der linearen Hülle der Spalten

> **Nächste Schritte:** [[Lineare-Mannigfaltigkeit]] — was passiert, wenn man eine lineare Hülle verschiebt | [[Rang]] — die „Größe" einer linearen Hülle messen

> [!info] English: [[../../EN/prerequisites/Linear-Combination]]

---

*Zuletzt geprüft: 2026-06-09*
