# Matrix Inverse

> **Prerequisites:** [[Matrix]], [[Linear-Function]]

The **inverse** of a square matrix $A$, written $A^{-1}$, is the matrix that "undoes" what $A$ does. If $A$ transforms $x$ into $Ax$, then $A^{-1}$ transforms $Ax$ back into $x$.

## Intuition

Think of $A$ as a function: $f(x) = Ax$. The inverse $A^{-1}$ is the reverse function:

$$A^{-1}(Ax) = x \quad \text{and} \quad A(A^{-1}x) = x$$

Just like $\sqrt{\phantom{x}}$ undoes squaring, and $\div 5$ undoes $\times 5$, the matrix inverse undoes matrix multiplication.

## Definition

For an $n \times n$ (square) matrix $A$, its inverse $A^{-1}$ satisfies:

$$AA^{-1} = A^{-1}A = I_n$$

where $I_n$ is the $n \times n$ **identity matrix** — ones on the diagonal, zeros everywhere else:

$$I_3 = \begin{pmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{pmatrix}$$

$I_n$ acts like the number $1$ in matrix multiplication: $I_n A = A I_n = A$.

> [!warning] Exam-relevant
> Only **square** matrices can have inverses, and **not all square matrices do**. If $A^{-1}$ exists, $A$ is called [[Regular-Matrix|regular]] (or invertible). If not, $A$ is *singular*.

## Why the Inverse Matters

If $A$ is invertible, you can solve $Ax = b$ in one line:

$$Ax = b \quad \Longrightarrow \quad x = A^{-1}b$$

Multiply both sides on the left by $A^{-1}$: $A^{-1}Ax = A^{-1}b$, and $A^{-1}A = I$, so $x = A^{-1}b$.

> [!tip] When to use
> If you need to solve $Ax = b$ for **many different** $b$ vectors with the same $A$, compute $A^{-1}$ once, then multiply. For a single $b$, [[Gaussian-Elimination|Gaussian elimination]] is faster.

## Properties

| Property | Meaning |
|----------|---------|
| $(A^{-1})^{-1} = A$ | Inverting twice gets you back |
| $(AB)^{-1} = B^{-1}A^{-1}$ | Inverse of product = product of inverses, **reversed order** |
| $(A^T)^{-1} = (A^{-1})^T$ | Inverse of transpose = transpose of inverse |
| $\det(A^{-1}) = 1 / \det(A)$ | See [[Determinant]] |

> [!example]
> For $A = \begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix}$: $A^{-1} = \begin{pmatrix} 1/2 & 0 \\ 0 & 1/3 \end{pmatrix}$
>
> Check: $AA^{-1} = \begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix} \begin{pmatrix} 1/2 & 0 \\ 0 & 1/3 \end{pmatrix} = \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix} = I_2$ ✓

## How to Compute

The main method is [[Gauss-Jordan|Gauss-Jordan elimination]]:
1. Write the augmented matrix $[A \mid I]$
2. Eliminate until the left side is $I$
3. The right side is then $A^{-1}$

For a $2 \times 2$ matrix, there's a shortcut formula (see [[Determinant]]):

$$A^{-1} = \frac{1}{ad - bc} \begin{pmatrix} d & -b \\ -c & a \end{pmatrix} \quad \text{(if } ad - bc \neq 0\text{)}$$

> **Next steps:** [[Gauss-Jordan]] — computing the inverse step by step | [[Regular-Matrix]] — when the inverse exists | [[Determinant]] — determinant and invertibility

> [!info] Deutsch: [[../../DE/matrix-inversion/Matrix-Inverse]]

---

*Last reviewed: 2026-06-09*
