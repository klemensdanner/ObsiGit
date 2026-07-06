# Kern vs. Lösungsmenge

> **Voraussetzungen:** [[Kern]], [[Loesungsmenge]], [[Homogen-vs-Inhomogen]], [[Lineare-Mannigfaltigkeit]]

Dieses Dokument führt die drei Hauptthemen zusammen: Gleichungssysteme, Kerne und Matrixinversion. Es ist die "vereinheitlichende Sicht" — wer dies versteht, hat die Kernstruktur der linearen Algebra verstanden.

## Das große Bild

Jedes lineare System $Ax = b$ besitzt eine Lösungsstruktur, die vollständig vom [[Kern|Kern]] der Matrix $A$ bestimmt wird:

$$\boxed{\text{Alle Lösungen von } Ax = b \;=\; x_p + \operatorname{Kern}(A)}$$

wobei $x_p$ eine **einzige** partikuläre Lösung (engl. *particular solution*) ist, die $Ax_p = b$ erfüllt.

## Drei Szenarien, eine Formel

| Das System $Ax = b$ | Kern | Lösungsstruktur |
|---------------------|------|-----------------|
| **$b = 0$** (homogen) | $\operatorname{Kern}(A)$ ist die vollständige Lösungsmenge | $\operatorname{Kern}(A)$ — ein Unterraum (durch den Ursprung) |
| **$b \neq 0$** (inhomogen) | $\operatorname{Kern}(A)$ ist der "Richtungsraum" | $x_p + \operatorname{Kern}(A)$ — eine [[Lineare-Mannigfaltigkeit|lineare Mannigfaltigkeit]] (verschobener Unterraum) |
| **$A$ invertierbar** | $\operatorname{Kern}(A) = \{0\}$ | $x = A^{-1}b$ — eindeutige Lösung (Mannigfaltigkeit der Dimension 0) |

## Warum diese Struktur gilt

Der Beweis ist kurz — je eine Zeile pro Richtung:

**Wenn $x$ eine Lösung ist, dann $x - x_p \in \operatorname{Kern}(A)$:**
$$A(x - x_p) = Ax - Ax_p = b - b = 0$$

**Wenn $v \in \operatorname{Kern}(A)$, dann ist $x_p + v$ eine Lösung:**
$$A(x_p + v) = Ax_p + Av = b + 0 = b$$

Die Lösungsmenge ist also exakt $x_p + \operatorname{Kern}(A)$ — nicht mehr, nicht weniger.

## Vollständiges Beispiel

Löse $Ax = b$ vollständig, wobei:

$$A = \begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 2 \\ 1 & -1 & 6 \end{pmatrix}, \quad b = \begin{pmatrix} -1 \\ 4 \\ 6 \end{pmatrix}$$

**Schritt 1: Finde eine partikuläre Lösung $x_p$.** Setze die freie Variable $x_3 = 0$:
$$x_p = \begin{pmatrix} -1 \\ -7 \\ 0 \end{pmatrix}$$

**Schritt 2: Finde den Kern.** Löse $Ax = 0$:
$$\operatorname{Kern}(A) = \operatorname{span}\left\{\begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix}\right\}$$

**Schritt 3: Kombiniere:**
$$\text{Alle Lösungen} = \begin{pmatrix} -1 \\ -7 \\ 0 \end{pmatrix} + t \begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix}, \quad t \in \mathbb{R}$$

## Verbindung zur Matrixinversion

Wenn $A$ [[Regulaere-Matrix|regulär]] ist ($\det(A) \neq 0$, voller Rang):

- $\operatorname{Kern}(A) = \{0\}$ — nur der Nullvektor
- $Ax = b$ hat genau eine Lösung: $x = A^{-1}b$
- Die lineare Mannigfaltigkeit $x_p + \operatorname{Kern}(A)$ schrumpft auf einen einzigen Punkt: $\{A^{-1}b\}$

Deshalb ist die [[Matrix-Inverse|Matrixinversion]] eine so saubere Methode — aber sie funktioniert nur, wenn der Kern trivial ist.

> [!tip] Merkregel
> $A$ regulär $\Longleftrightarrow$ $\operatorname{Kern}(A) = \{0\}$ $\Longleftrightarrow$ $Ax = b$ hat eine eindeutige Lösung für jedes $b$.

## Verbindung zum Rang

Die Dimension der Lösungsmannigfaltigkeit ist $\dim(\operatorname{Kern}(A))$, was nach dem [[Kern-und-Bild|Rangsatz]] gleich $n - \operatorname{rang}(A)$ ist:

| Rang-Situation | $\dim(\operatorname{Kern})$ | Lösungstyp |
|----------------|----------------------------|------------|
| Voller Rang ($\operatorname{rang} = n$) | $0$ | Eindeutige Lösung (ein Punkt) |
| Rang $n-1$ | $1$ | Lösungen bilden eine Gerade |
| Rang $n-2$ | $2$ | Lösungen bilden eine Ebene |
| Rang $n-k$ | $k$ | Lösungen bilden eine $k$-dimensionale Mannigfaltigkeit |

> [!warning] Prüfungsrelevant
> Die Anzahl der freien Variablen in der Lösung = $\dim(\operatorname{Kern}(A))$ = $n - \operatorname{rang}(A)$.
>
> Kennt man zwei der drei Größen {$\operatorname{rang}$, $\dim(\operatorname{Kern})$, $n$}, hat man die dritte.

## Zusammenfassung: Der vollständige Lösungsalgorithmus

Um $Ax = b$ vollständig zu lösen:

1. Wende die [[Gauss-Elimination|Gauß-Elimination]] an $\to$ bestimme, ob Lösungen existieren
2. Falls ja, finde **eine** partikuläre Lösung $x_p$ (setze alle freien Variablen auf 0)
3. Finde **alle** Lösungen von $Ax = 0$ $\to$ das ist $\operatorname{Kern}(A)$
4. Schreibe die allgemeine Lösung: $x = x_p + \operatorname{Kern}(A)$

> **Nächste Schritte:** Zurück zu [[Home]] für eine Übersicht, oder erkunde beliebige Themen über die Graph-Ansicht.

> [!info] English: [[../../EN/kernel/Kernel-vs-Solution-Set]]

---

*Zuletzt überprüft: 2026-06-09*
