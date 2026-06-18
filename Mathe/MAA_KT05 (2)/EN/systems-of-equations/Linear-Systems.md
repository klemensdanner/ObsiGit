# Linear Systems of Equations

> **Prerequisites:** [[Vector]], [[Matrix]]

A **linear system of equations** is a set of linear equations that must all be satisfied simultaneously. "Linear" means each equation only contains terms like $3x_1$, $-x_2$, etc. — no $x^2$, no $\sin(x)$, no $x_1 x_2$.

## From Equations to Matrix Form

Take a system like:

$$\begin{aligned}
2x_1 + x_2 + 2x_3 &= 1 \\
-x_1 + x_3 &= 2 \\
2x_1 + 10x_2 &= 3
\end{aligned}$$

This is much cleaner in matrix form $Ax = b$:

$$\underbrace{\begin{pmatrix} 2 & 1 & 2 \\ -1 & 0 & 1 \\ 2 & 10 & 0 \end{pmatrix}}_{A} \underbrace{\begin{pmatrix} x_1 \\ x_2 \\ x_3 \end{pmatrix}}_{x} = \underbrace{\begin{pmatrix} 1 \\ 2 \\ 3 \end{pmatrix}}_{b}$$

> [!tip] Reading matrix form
> - $A$ is the **coefficient matrix** — one row per equation, one column per variable
> - $x$ is the **unknown vector** — what we're solving for
> - $b$ is the **right-hand side** — the constants
> - Each row of $A$ dotted with $x$ equals the corresponding entry in $b$

## Geometric Meaning

Each equation defines a "flat" (line in $\mathbb{R}^2$, plane in $\mathbb{R}^3$, hyperplane beyond). The solution is the intersection of all these flats:

| In $\mathbb{R}^2$ (two variables) | In $\mathbb{R}^3$ (three variables) |
|---|---|
| Two lines | Three planes |
| Intersection = point (unique solution) | Intersection = point (unique solution) |
| Parallel lines (no solution) | Planes with no common intersection |
| Same line (infinitely many) | Planes sharing a line (infinitely many) |

## Three Possible Outcomes

Every linear system falls into exactly one of these cases:

| Case | When it happens | Solution form |
|------|----------------|---------------|
| **No solution** | Contradiction: e.g., row becomes $0 = 5$ | $\emptyset$ (empty set) |
| **Exactly one solution** | Full [[Rank\|rank]], every variable has a pivot | A single vector $x^*$ |
| **Infinitely many solutions** | Fewer pivots than variables → free variables | A [[Linear-Manifold\|linear manifold]] |

> [!warning] Exam-relevant
> You determine which case you're in *during* [[Gaussian-Elimination|Gaussian elimination]], not beforehand. The elimination process itself reveals the case.

## The Augmented Matrix

For solving, we work with the **augmented matrix** $[A \mid b]$, which tacks $b$ onto the right side of $A$:

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ -1 & 0 & 1 & 2 \\ 2 & 10 & 0 & 3 \end{array}\right)$$

The vertical bar is a visual reminder: the rightmost column is special (it's $b$, not coefficients).

## Solving Strategy

1. Write the augmented matrix $[A \mid b]$
2. Apply [[Gaussian-Elimination|Gaussian elimination]] to reach [[Upper-Triangular-Form|upper triangular form]]
3. Use back-substitution to read off the solution
4. Determine the [[Solution-Set|solution set]] type

> [!example] Quick preview — see [[Gaussian-Elimination]] for the full walkthrough
> The system above (from UE_10.3) reduces to:
> $$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ 0 & 0.5 & 2 & 2.5 \\ 0 & 0 & -16 & -8 \end{array}\right)$$
>
> Back-substitution: $x_3 = 0.5$, $x_2 = 3$, $x_1 = -1.5$

> **Next steps:** [[Gaussian-Elimination]] — the algorithm | [[Solution-Set]] — understanding the three outcome types in depth

> [!info] Deutsch: [[../../DE/gleichungssysteme/Lineare-Gleichungssysteme]]

---

*Last reviewed: 2026-06-09*
