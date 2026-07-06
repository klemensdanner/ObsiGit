# Lineare Mannigfaltigkeit

> **Voraussetzungen:** [[Vektor]], [[Linearkombination]]

Eine **lineare Mannigfaltigkeit** (engl. linear manifold) ist ein verschobener Unterraum — stelle dir eine Ebene vor, die nicht durch den Ursprung verläuft. Sie entsteht, wenn man einen **Untervektorraum** (engl. subspace, auch *Unterraum* genannt) — eine „Fläche" durch den Ursprung — an eine andere Stelle verschiebt.

## Definition

Eine Menge $M \subseteq \mathbb{R}^n$ ist eine lineare Mannigfaltigkeit, wenn sie sich schreiben lässt als:

$$M = v_0 + U = \{v_0 + u \mid u \in U\}$$

dabei ist $v_0$ ein fester Vektor (die **Verschiebung**, engl. shift) und $U$ ein Untervektorraum (eine Menge, die unter Addition und Skalarmultiplikation abgeschlossen ist).

Da sich jeder Untervektorraum als [[Linearkombination|lineare Hülle]] darstellen lässt, schreiben wir üblicherweise:

$$M = v_0 + \operatorname{span}\{v_1, v_2, \ldots, v_k\}$$

Die Zahl $k$ ist die **Dimension** der Mannigfaltigkeit.

> [!example] Im $\mathbb{R}^2$
> Die Gerade $y = 2x + 1$ verläuft nicht durch den Ursprung (bei $x=0$ ist $y=1$).
>
> Schreibe sie als Mannigfaltigkeit: nimm einen Punkt auf der Geraden, etwa $v_0 = (0, 1)$.
> Die Richtung der Geraden ist $(1, 2)$.
>
> Also: $M = \begin{pmatrix} 0 \\ 1 \end{pmatrix} + \operatorname{span}\left\{\begin{pmatrix} 1 \\ 2 \end{pmatrix}\right\}$
>
> Jeder Punkt auf der Geraden ist $(0,1) + t(1,2) = (t, 1+2t)$.

> [!example] Im $\mathbb{R}^3$
> Eine vom Ursprung verschobene Ebene:
> $M = \begin{pmatrix} 1 \\ 0 \\ -1 \end{pmatrix} + \operatorname{span}\left\{\begin{pmatrix} 1 \\ 0 \\ 2 \end{pmatrix}, \begin{pmatrix} 0 \\ 1 \\ 3 \end{pmatrix}\right\}$
>
> Jeder Punkt dieser Ebene hat die Form $(1 + s,\; t,\; -1 + 2s + 3t)$.

## Warum lineare Mannigfaltigkeiten wichtig sind

Die **Lösungsmenge eines inhomogenen linearen Gleichungssystems** $Ax = b$ (mit $b \neq 0$) ist eine lineare Mannigfaltigkeit:

$$\text{Alle Lösungen} = x_p + \operatorname{Kern}(A)$$

dabei ist $x_p$ eine beliebige *partikuläre* Lösung. Siehe [[Lösungsmenge]] und [[Homogen-vs-Inhomogen]] für die vollständige Erklärung.

## Gleichheit von Mannigfaltigkeiten prüfen

> [!warning] Prüfungsrelevant — UE_11.3

Angenommen, du hast die Lösung von $Ax = b$ gefunden und $v_0 + \operatorname{span}\{v_1, v_2\}$ erhalten, aber die Musterlösung sagt $w_0 + \operatorname{span}\{w_1, w_2\}$. Sind es dieselben Mengen?

**Zwei lineare Mannigfaltigkeiten $v_0 + U$ und $w_0 + W$ sind genau dann gleich, wenn:**
1. **$U = W$** — die Richtungsräume (engl. direction subspaces) sind identisch (gleiche lineare Hülle), **und**
2. **$v_0 - w_0 \in U$** — die Differenz der Verschiebungsvektoren liegt in diesem Unterraum

> [!tip] Was das in der Praxis bedeutet
> Um zu prüfen, ob zwei Lösungsdarstellungen dieselbe Menge beschreiben:
> 1. Überprüfe, ob jeder Richtungsvektor aus der einen Darstellung in der linearen Hülle der anderen liegt (und umgekehrt)
> 2. Überprüfe, ob die Differenz der Partikulärlösungen eine Linearkombination der Richtungsvektoren ist
>
> Wenn beides gilt, beschreiben die beiden Darstellungen ein und dieselbe lineare Mannigfaltigkeit.

## Untervektorraum vs. Lineare Mannigfaltigkeit

| Eigenschaft | Untervektorraum | Lineare Mannigfaltigkeit |
|------------|-----------------|--------------------------|
| Enthält $0$? | Immer | Nur wenn $v_0 \in U$ |
| Abgeschlossen unter $+$? | Ja | Nein (im Allgemeinen) |
| Lösung von $Ax = 0$? | Ja — [[Kern]] | Nein |
| Lösung von $Ax = b$ ($b \neq 0$)? | Nein | **Ja** |

> **Nächste Schritte:** [[Lösungsmenge]] — wie Mannigfaltigkeiten als Lösungen linearer Gleichungssysteme auftreten | [[Homogen-vs-Inhomogen]] — der Zusammenhang zwischen homogenen Systemen und Mannigfaltigkeiten

> [!info] English: [[../../EN/prerequisites/Linear-Manifold]]

---

*Zuletzt geprüft: 2026-06-09*
