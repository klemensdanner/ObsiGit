# Rank

> **Prerequisites:** [[Matrix]], [[Linear-Combination]]

The **rank** of a matrix measures "how many dimensions it actually uses." It tells you how much information the matrix truly carries — how many of its columns (or rows) are genuinely independent.

## Definition

The rank of an $m \times n$ matrix $A$ is the dimension of the column space — the [[Linear-Combination|span]] of its column vectors:

$$\operatorname{rank}(A) = \dim(\operatorname{span}\{\text{columns of } A\})$$

Equivalently: rank is the number of **pivot columns** after [[Gaussian-Elimination|Gaussian elimination]].

> [!tip] Key fact
> Column rank = row rank. The number of independent columns always equals the number of independent rows. So you can compute rank by looking at either.

> [!example] Visual comparison
> $\begin{pmatrix} 1 & 0 & 2 \\ 0 & 1 & 3 \end{pmatrix}$ — Columns: $(1,0)$, $(0,1)$, and $(2,3) = 2(1,0) + 3(0,1)$. Only 2 independent columns. **Rank = 2**.
>
> $\begin{pmatrix} 1 & 2 \\ 2 & 4 \end{pmatrix}$ — Second column = $2 \times$ first column. Only 1 independent column. **Rank = 1**.

## What Rank Tells You

For an $m \times n$ matrix $A$:

| Rank value | Meaning |
|-----------|---------|
| $\operatorname{rank}(A) = n$ | **Full column rank** — columns are linearly independent |
| $\operatorname{rank}(A) = m$ | **Full row rank** — rows span the entire output space |
| $\operatorname{rank}(A) = m = n$ | **Full rank** (square matrix) — $A$ is [[Regular-Matrix|regular/invertible]] |
| $\operatorname{rank}(A) < \min(m, n)$ | **Rank deficient** — some information is redundant |

## Computing Rank

1. Apply [[Gaussian-Elimination|Gaussian elimination]] to bring $A$ to [[Upper-Triangular-Form|upper triangular form]]
2. Count the number of **non-zero rows** (these correspond to pivot positions)
3. That count is the rank

> [!example]
> $A = \begin{pmatrix} 2 & 1 & 0 \\ -1 & 0 & 1 \\ 1 & 1 & 1 \end{pmatrix}$
>
> After elimination: $\begin{pmatrix} 2 & 1 & 0 \\ 0 & 0.5 & 1 \\ 0 & 0 & 0 \end{pmatrix}$
>
> Two non-zero rows → $\operatorname{rank}(A) = 2$

## Connection to Other Concepts

> [!warning] Exam-relevant
> For a square $n \times n$ matrix $A$, the following are ALL equivalent. If one is true, all are true:
> - $\operatorname{rank}(A) = n$ (full rank)
> - $A$ is [[Regular-Matrix|regular/invertible]]
> - $\det(A) \neq 0$ (see [[Determinant]])
> - $\operatorname{Kern}(A) = \{0\}$ (kernel contains only the zero vector — see [[Kernel]])
> - $Ax = b$ has a unique solution for every $b$
> - The columns of $A$ are linearly independent

## Rank and the Kernel

The **Rank-Nullity Theorem** (see [[Kernel-and-Image]]) connects rank to the [[Kernel|kernel]]:

$$\dim(\operatorname{Kern}(A)) + \operatorname{rank}(A) = n$$

where $n$ is the number of columns. So a higher rank means a smaller kernel, and vice versa.

> **Next steps:** [[Kernel-and-Image]] — the rank-nullity relationship in full | [[Regular-Matrix]] — when rank guarantees invertibility

> [!info] Deutsch: [[../../DE/prerequisites/Rang]]

---

*Last reviewed: 2026-06-09*
