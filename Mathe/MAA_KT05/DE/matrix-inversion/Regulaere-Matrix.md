# Reguläre Matrix

> **Voraussetzungen:** [[Matrix-Inverse]], [[Rang]], [[Determinante]]

Eine quadratische Matrix heißt **regulär** (regular), wenn sie eine [[Matrix-Inverse|Inverse]] besitzt. Existiert keine Inverse, nennt man sie **singulär** (singular). Dieses Merkblatt fasst alle äquivalenten Kriterien zusammen, mit denen du den jeweiligen Fall überprüfen kannst.

## Begriffsklärung

| Begriff | Bedeutung |
|---------|-----------|
| **Regulär** (regular) | $A^{-1}$ existiert |
| **Invertierbar** (invertible) | Gleichbedeutend mit regulär |
| **Nichtsingulär** (non-singular) | Gleichbedeutend mit regulär |
| **Singulär** (singular) | $A^{-1}$ existiert **nicht** |
| **Degeneriert** (degenerate) | Gleichbedeutend mit singulär |

## Die Äquivalenzkette (equivalence chain)

> [!warning] Prüfungsrelevant

Für eine $n \times n$-Matrix $A$ sind **alle** folgenden Aussagen äquivalent. Trifft eine zu, treffen alle zu. Ist eine falsch, sind alle falsch.

| # | Kriterium | Beschreibung |
|---|-----------|--------------|
| 1 | $A^{-1}$ existiert | $A$ ist per Definition regulär/invertierbar |
| 2 | $\det(A) \neq 0$ | Siehe [[Determinante]] — Determinante ungleich Null |
| 3 | $\operatorname{Rang}(A) = n$ | Voller [[Rang]] (full rank) — alle Zeilen/Spalten linear unabhängig |
| 4 | $\operatorname{Kern}(A) = \{0\}$ | Nur der Nullvektor wird auf Null abgebildet — siehe [[Kern]] (kernel) |
| 5 | Spalten sind linear unabhängig | Keine Spalte ist eine [[Linearkombination]] der anderen |
| 6 | $A$ ist zeilenäquivalent zu $I_n$ | Die [[Gauss-Elimination|Gauß-Elimination]] kann $A$ auf die Einheitsmatrix reduzieren |
| 7 | $Ax = b$ hat für jedes $b$ eine eindeutige Lösung | Das System ist stets lösbar, und die Lösung ist eindeutig |
| 8 | $Ax = 0$ hat nur die triviale Lösung $x = 0$ | Das homogene System besitzt keine nichttrivialen Lösungen |

> [!tip] Welches Kriterium verwenden?
> - **Schnellprüfung:** Berechne $\det(A)$. Ist $\det(A) = 0$, ist die Matrix singulär. Allerdings ist die Determinantenberechnung für große $n$ aufwändig.
> - **Praktische Prüfung:** Führe die [[Gauss-Elimination|Gauß-Elimination]] durch — erscheint eine Nullzeile, ist die Matrix singulär. Erreichst du die volle obere Dreiecksform mit von Null verschiedenen Diagonaleinträgen, ist sie regulär.
> - **Konzeptionell:** Kollabiert die Matrix irgendeine Dimension? Enthält $\operatorname{Kern}(A)$ mehr als nur $\{0\}$, ist die Matrix singulär.

## Warum die Äquivalenz gilt

Die Äquivalenz dieser Kriterien ist ein zentrales Resultat der linearen Algebra. Hier ein kurzer Überblick über die Zusammenhänge:

- **(1) $\Longleftrightarrow$ (2):** Die Inverse lässt sich über die Determinantenformel $A^{-1} = \frac{1}{\det(A)} \operatorname{adj}(A)$ berechnen, was nur für $\det(A) \neq 0$ funktioniert.
- **(2) $\Longleftrightarrow$ (3):** Der Rang ist die Größe der größten Untermatrix mit $\det \neq 0$. Bei vollem Rang $n$ muss $\det(A) \neq 0$ gelten.
- **(3) $\Longleftrightarrow$ (4):** Die Dimensionsformel $\dim(\operatorname{Kern}(A)) + \operatorname{Rang}(A) = n$ verknüpft Kern und Rang direkt. Voller Rang $\Longleftrightarrow$ $\dim(\operatorname{Kern}(A)) = 0$ $\Longleftrightarrow$ $\operatorname{Kern}(A) = \{0\}$.
- **(4) $\Longleftrightarrow$ (8):** $Ax = 0$ hat genau dann nichttriviale Lösungen, wenn $\operatorname{Kern}(A)$ mehr als $\{0\}$ enthält.

Das Verständnis dieser Zusammenhänge hilft, Aufgaben flexibel zu lösen — oft ist der Zugang über die Determinante am schnellsten, während der Zugang über den Rang konzeptionell aufschlussreicher ist.

## Reguläre Matrizen und lineare Gleichungssysteme

Ist $A$ regulär, ist das Lösen von $Ax = b$ unkompliziert:

| Methode | Wann anwenden |
|---------|---------------|
| $x = A^{-1}b$ | Viele verschiedene $b$ bei gleicher Matrix $A$ |
| [[Gauss-Elimination|Gauß-Elimination]] | Ein einzelnes $b$ |
| [[Gauss-Jordan|Gauß-Jordan]] | Du willst sowohl $A^{-1}$ als auch die Lösung |

Ist $A$ singulär, hat $Ax = b$ entweder **keine Lösung** oder **unendlich viele Lösungen** — niemals genau eine.

> [!example] $2 \times 2$-Fall auf einen Blick
> Für $A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}$ gilt:
> - **Regulär**, wenn $ad - bc \neq 0$ → $A^{-1} = \frac{1}{ad-bc}\begin{pmatrix} d & -b \\ -c & a \end{pmatrix}$
> - **Singulär**, wenn $ad - bc = 0$ → keine Inverse, Spalten sind Vielfache voneinander

> [!warning] Prüfungsrelevant — häufige Fehler
> - Die Äquivalenzkette gilt **nur** für quadratische Matrizen. Bei nichtquadratischen Matrizen spricht man nicht von regulär/singulär.
> - "Voller Rang" bedeutet bei einer $n \times n$-Matrix $\operatorname{Rang}(A) = n$, also $n$ linear unabhängige Zeilen **und** Spalten.
> - Die Bedingung $\det(A) \neq 0$ ist ein **scharfer Test**: schon ein极小 kleiner Betrag ungleich Null reicht für Regularität.
> - Verwechsle nicht "singulär" mit "nicht invertierbar" — es ist dieselbe Eigenschaft, nur anders benannt.

## Rechenbeispiel

> [!example] Regularität prüfen
> Prüfe, ob $A = \begin{pmatrix} 1 & 2 & 0 \\ 2 & 4 & 1 \\ 0 & 0 & 3 \end{pmatrix}$ regulär ist.
>
> **Methode 1 — Determinante:** Entwickle nach Spalte 3:
> $\det(A) = 0 \cdot (\ldots) + 1 \cdot (-1)^{2+3} \det\begin{pmatrix} 1 & 2 \\ 0 & 0 \end{pmatrix} + 3 \cdot (-1)^{3+3} \det\begin{pmatrix} 1 & 2 \\ 2 & 4 \end{pmatrix}$
> $= -1 \cdot (1\cdot 0 - 2\cdot 0) + 3 \cdot (1\cdot 4 - 2\cdot 2) = -1\cdot 0 + 3 \cdot 0 = 0$
>
> $\det(A) = 0$ → $A$ ist **singulär**.
>
> **Methode 2 — Gauß-Elimination:**
> $Z_2 \leftarrow Z_2 - 2Z_1$: $\begin{pmatrix} 1 & 2 & 0 \\ 0 & 0 & 1 \\ 0 & 0 & 3 \end{pmatrix}$
>
> In Spalte 2 gibt es kein Pivot — eine Nullzeile entsteht → singulär. Beide Methoden bestätigen dasselbe Ergebnis.

> **Nächste Schritte:** [[Determinante]] — das Determinantenkriterium im Detail | [[Kern]] — das Kern-Kriterium erklärt

> [!info] English: [[../../EN/matrix-inversion/Regular-Matrix]]

---

*Zuletzt überprüft: 2026-06-09*
