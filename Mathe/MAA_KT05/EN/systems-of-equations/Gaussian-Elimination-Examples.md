# Gaussian Elimination — Additional Examples

> **Prerequisites:** [[Gaussian-Elimination]]

Two more fully worked examples with commentary. These complement the main example in [[Gaussian-Elimination]].

---

## Example 1: Infinitely Many Solutions (UE_10.4)

> Solve $\begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 2 \\ 1 & -1 & 6 \end{pmatrix} x = \begin{pmatrix} -1 \\ 4 \\ 6 \end{pmatrix}$

**Augmented matrix:**

$$\left(\begin{array}{ccc|c} 1 & 0 & -2 & -1 \\ 3 & -1 & 2 & 4 \\ 1 & -1 & 6 & 6 \end{array}\right)$$

**Forward elimination:**

*Column 1 — pivot is $1$ in row 1:*
- $R_2 \leftarrow R_2 - 3R_1$: eliminates the $3$
- $R_3 \leftarrow R_3 - R_1$: eliminates the $1$

$$\left(\begin{array}{ccc|c} 1 & 0 & -2 & -1 \\ 0 & -1 & 8 & 7 \\ 0 & -1 & 8 & 7 \end{array}\right)$$

*Column 2 — pivot is $-1$ in row 2:*
- $R_3 \leftarrow R_3 - R_2$: eliminates the $-1$ below

$$\left(\begin{array}{ccc|c} 1 & 0 & -2 & -1 \\ 0 & -1 & 8 & 7 \\ 0 & 0 & 0 & 0 \end{array}\right)$$

**Analysis:** A row of all zeros appeared — the third equation was redundant (it was row 1 + row 2). But no contradiction. Two pivots, three variables → **infinitely many solutions**, one free variable.

> [!tip] Different from UE_10.3
> UE_10.3 had 3 pivots → unique solution. Here, 2 pivots for 3 variables → one degree of freedom ($x_3$ is free).

**Parameterization** — set $x_3 = t$ (free parameter), then:

From row 2: $-x_2 + 8t = 7$ → $x_2 = 8t - 7$

From row 1: $x_1 - 2t = -1$ → $x_1 = 2t - 1$

**Solution:** $x = \begin{pmatrix} -1 \\ -7 \\ 0 \end{pmatrix} + t \begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix}$, for any $t \in \mathbb{R}$

This is a [[Linear-Manifold|linear manifold]] — a line in $\mathbb{R}^3$ (1-dimensional, since 1 free parameter).

---

## Example 2: No Solution (UE_10.5)

> Solve $\begin{pmatrix} 2 & 1 & 0 \\ -1 & 0 & 1 \\ 1 & 1 & 1 \end{pmatrix} x = \begin{pmatrix} 1 \\ 2 \\ 4 \end{pmatrix}$

**Augmented matrix:**

$$\left(\begin{array}{ccc|c} 2 & 1 & 0 & 1 \\ -1 & 0 & 1 & 2 \\ 1 & 1 & 1 & 4 \end{array}\right)$$

**Forward elimination:**

*Column 1 — pivot is $2$ in row 1:*
- $R_2 \leftarrow R_2 + 0.5R_1$
- $R_3 \leftarrow R_3 - 0.5R_1$

$$\left(\begin{array}{ccc|c} 2 & 1 & 0 & 1 \\ 0 & 0.5 & 1 & 2.5 \\ 0 & 0.5 & 1 & 3.5 \end{array}\right)$$

*Column 2 — pivot is $0.5$ in row 2:*
- $R_3 \leftarrow R_3 - R_2$

$$\left(\begin{array}{ccc|c} 2 & 1 & 0 & 1 \\ 0 & 0.5 & 1 & 2.5 \\ 0 & 0 & 0 & 1 \end{array}\right)$$

**Analysis:** The third row reads $0x_1 + 0x_2 + 0x_3 = 1$ — which is $0 = 1$, a contradiction.

**→ No solution.** The system is inconsistent. (Geometrically: the three planes don't share a common point.)

> [!tip] The tell-tale sign
> A contradiction row $(0\;0\;\ldots\;0 \mid c)$ with $c \neq 0$ in the augmented matrix always means **no solution**. This is the only way to prove inconsistency.

## Summary: Three Systems, Three Outcomes

| Exercise | Matrix | Result | Type |
|----------|--------|--------|------|
| UE_10.3 | $\begin{pmatrix} 2&1&2\\-1&0&1\\2&10&0 \end{pmatrix}$ | Unique: $x \approx (-1.5, 3, 0.5)$ | [[Solution-Set\|Exactly one]] |
| UE_10.4 | $\begin{pmatrix} 1&0&-2\\3&-1&2\\1&-1&6 \end{pmatrix}$ | $x = (-1,-7,0)^T + t(2,8,1)^T$ | [[Solution-Set\|Infinitely many]] |
| UE_10.5 | $\begin{pmatrix} 2&1&0\\-1&0&1\\1&1&1 \end{pmatrix}$ | Contradiction row → $\emptyset$ | [[Solution-Set\|No solution]] |

> **Next steps:** [[Solution-Set]] — understanding the three outcome types systematically | [[Upper-Triangular-Form]] — solving systems already in triangular form

> [!info] Deutsch: [[../../DE/gleichungssysteme/Gauss-Elimination-Beispiele]]

---

*Last reviewed: 2026-06-09*
