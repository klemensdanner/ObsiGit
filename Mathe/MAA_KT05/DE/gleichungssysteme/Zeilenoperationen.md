# Elementare Zeilenoperationen

> **Voraussetzungen:** [[Matrix]]

**Elementare Zeilenoperationen** (elementary row operations), auch **Zeilenumformungen** genannt, sind die drei erlaubten Umformungen an einer Matrix, die deren Losungsmenge nicht verandern. Sie sind die ,,Zuge" in der [[Gauss-Elimination|Gauss-Elimination]].

## Die drei Operationen

| Nr. | Operation | Notation | Wirkung |
|-----|-----------|----------|---------|
| **1** | **Zeilenvertauschung** (row swap) | $Z_i \leftrightarrow Z_j$ | Vertauscht Zeilen $i$ und $j$ |
| **2** | **Zeilenskalierung** (row scaling) | $Z_i \leftarrow \lambda Z_i$ | Multipliziert Zeile $i$ mit $\lambda \neq 0$ |
| **3** | **Zeilenaddition** (row addition) | $Z_i \leftarrow Z_i + \lambda Z_j$ | Addiert das $\lambda$-Fache von Zeile $j$ zu Zeile $i$ |

> [!warning] Prufungsrelevant
> Operation 3 wird am haufigsten verwendet und ist die fehleranfalligste. Du addierst ein Vielfaches von Zeile $j$ **zu** Zeile $i$. Zeile $j$ selbst andert sich **nicht**. Nur Zeile $i$ wird verandert.

## Warum die Losungsmenge erhalten bleibt

Jede Operation entspricht einer Aktion an den Gleichungen, die umkehrbar ist und nicht andert, welche $x$-Werte sie erfullen:

1. **Vertauschen:** Die Reihenfolge der Gleichungen spielt keine Rolle. $2x + y = 5$ und $x - y = 1$ ist dasselbe System, egal welche Gleichung zuerst kommt.

2. **Skalieren:** Multipliziert man beide Seiten einer Gleichung mit einer Zahl ungleich Null, andert sich die Losungsmenge nicht. $2x + 4y = 8$ und $x + 2y = 4$ beschreiben dieselbe Gerade.

3. **Addition:** Wenn $G_1$ und $G_2$ wahre Gleichungen sind, dann ist auch $G_1 + \lambda G_2$ wahr. Wir erzeugen eine neue Gleichung aus alten, aber jede Losung des ursprunglichen Systems bleibt eine Losung.

> [!tip] So kannst du es dir vorstellen
> Jede Operation ist **umkehrbar** (reversible). Wenn du eine Operation ruckgangig machen und zum ursprunglichen System zuruckkehren kannst, andert sich die Losungsmenge nicht. Alle drei sind umkehrbar:
> - Erneutes Vertauschen macht eine Vertauschung ruckgangig
> - Skalieren mit $1/\lambda$ macht eine Skalierung mit $\lambda$ ruckgangig
> - Addition von $-\lambda Z_j$ macht eine Addition von $\lambda Z_j$ ruckgangig

## Haufige Fehler und Fallstricke

> [!warning] Prufungsrelevant
> Die haufigsten Fehler bei Zeilenoperationen sind:
> - **Vergessen, dass Zeile $j$ unverandert bleibt** bei $Z_i \leftarrow Z_i + \lambda Z_j$. Nur $Z_i$ andert sich.
> - **Skalierung mit Null** -- Operation 2 erlaubt nur $\lambda \neq 0$. Eine Multiplikation mit Null wurde Informationen unwiderruflich vernichten.
> - **Kombinierte Operationen in einem Schritt** -- fuhre nie zwei verschiedene Operationen gleichzeitig aus. Schreibe jeden Schritt einzeln.
> - **Vorzeichenfehler beim Multiplikator** -- der Term $-\frac{a_{ik}}{a_{kk}}$ muss exakt berechnet werden.

## Systematischer Einsatz in der Gauss-Elimination

Das Ziel ist stets, Nullen unterhalb des Pivots zu erzeugen:

```
  Fur Spalte k, Pivot in Zeile k:

  1. Falls a_kk = 0, vertausche Zeile k mit
     einer Zeile darunter (Op 1)

  2. Fur jede Zeile i > k:
     Z_i <- Z_i - (a_ik / a_kk) * Z_k
     (Op 3 -- erzeugt Null bei a_ik)
```

Der Multiplikator $\frac{a_{ik}}{a_{kk}}$ wird so gewahlt, dass der Eintrag unterhalb des Pivots exakt Null wird.

> [!example]
> Um eine $3$ unterhalb eines Pivots von $2$ zu eliminieren: $\;Z_i \leftarrow Z_i - \frac{3}{2}Z_k$
>
> Probe: $3 - \frac{3}{2} \cdot 2 = 3 - 3 = 0$ $\checkmark$

## Beispiel: Alle drei Operationen im Einsatz

Gegeben sei die Matrix $\begin{pmatrix} 0 & 2 & 4 \\ 2 & 1 & 3 \\ 1 & 1 & 1 \end{pmatrix}$.

1. **Vertauschen:** $Z_1 \leftrightarrow Z_2$ (da $a_{11} = 0$ ist)
   $\rightarrow \begin{pmatrix} 2 & 1 & 3 \\ 0 & 2 & 4 \\ 1 & 1 & 1 \end{pmatrix}$

2. **Addition:** $Z_3 \leftarrow Z_3 - \frac{1}{2}Z_1$ (erzeugt eine Null unter dem Pivot)
   $\rightarrow \begin{pmatrix} 2 & 1 & 3 \\ 0 & 2 & 4 \\ 0 & 0.5 & -0.5 \end{pmatrix}$

3. **Skalieren:** $Z_2 \leftarrow \frac{1}{2}Z_2$ (vereinfacht die Zeile, optional)
   $\rightarrow \begin{pmatrix} 2 & 1 & 3 \\ 0 & 1 & 2 \\ 0 & 0.5 & -0.5 \end{pmatrix}$

## Notation in der Praxis

In Ubungen und Klausuren wird eine Zeilenoperation meist in dieser Form notiert:

$$Z_3 \leftarrow Z_3 - 2Z_1$$

Dies bedeutet: ,,Subtrahiere das Zweifache von Zeile 1 von Zeile 3." Die ausfuhrliche Schreibweise hilft, die durchgefuhrte Operation nachvollziehbar zu dokumentieren.

> **Nachste Schritte:** [[Obere-Dreiecksform]] -- die Zielform, auf die wir hinarbeiten | [[Gauss-Elimination]] -- der Algorithmus, der diese Operationen verwendet

> [!info] English: [[../../EN/systems-of-equations/Row-Operations]]

---

*Zuletzt uberpruft: 2026-06-09*
