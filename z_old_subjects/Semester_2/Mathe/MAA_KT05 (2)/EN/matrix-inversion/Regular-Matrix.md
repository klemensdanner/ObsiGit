# Regular Matrix

> **Prerequisites:** [[Matrix-Inverse]], [[Rank]], [[Determinant]]

A square matrix is **regular** if it has an [[Matrix-Inverse|inverse]]. If no inverse exists, it's **singular**. This file collects all the equivalent ways to check which case you're in.

## Terminology

| Term | Meaning |
|------|---------|
| **Regular** | $A^{-1}$ exists |
| **Invertible** | Same as regular |
| **Non-singular** | Same as regular |
| **Singular** | $A^{-1}$ does NOT exist |
| **Degenerate** | Same as singular |

## The Equivalence Chain

> [!warning] Exam-relevant

For an $n \times n$ matrix $A$, **all** of the following are equivalent. If one holds, they all hold. If one fails, they all fail.

| # | Criterion | Description |
|---|-----------|-------------|
| 1 | $A^{-1}$ exists | $A$ is regular/invertible by definition |
| 2 | $\det(A) \neq 0$ | See [[Determinant]] — non-zero determinant |
| 3 | $\operatorname{rank}(A) = n$ | Full [[Rank]] — all rows/columns independent |
| 4 | $\operatorname{Kern}(A) = \{0\}$ | Only the zero vector maps to zero — see [[Kernel]] |
| 5 | Columns are linearly independent | No column is a [[Linear-Combination]] of others |
| 6 | $A$ is row-equivalent to $I_n$ | [[Gaussian-Elimination]] can reduce it to the identity |
| 7 | $Ax = b$ has a unique solution for every $b$ | The system is always solvable, and the solution is unique |
| 8 | $Ax = 0$ has only the trivial solution $x = 0$ | The homogeneous system has no non-zero solutions |

> [!tip] Which criterion to use
> - **Quick check:** Compute $\det(A)$. If $\det(A) = 0$, singular. But computing the determinant is expensive for large $n$.
> - **Practical check:** Run [[Gaussian-Elimination]] — if a zero row appears, singular. If you reach full upper triangular form with non-zero diagonal, regular.
> - **Conceptual:** Does the matrix "collapse" any dimensions? If $\operatorname{Kern}(A)$ contains more than just $\{0\}$, the matrix is singular.

## Regular Matrices and Linear Systems

If $A$ is regular, solving $Ax = b$ is straightforward:

| Method | When to use |
|--------|-------------|
| $x = A^{-1}b$ | Many $b$ with same $A$ |
| [[Gaussian-Elimination]] | Single $b$ |
| [[Gauss-Jordan]] | You want both $A^{-1}$ and the solution |

If $A$ is singular, $Ax = b$ has either **no solution** or **infinitely many solutions** — never exactly one.

> **Next steps:** [[Determinant]] — the determinant criteria in detail | [[Kernel]] — the kernel criterion explained

> [!info] Deutsch: [[../../DE/matrix-inversion/Regulaere-Matrix]]

---

*Last reviewed: 2026-06-09*
