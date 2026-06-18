# Computing the Kernel

> **Prerequisites:** [[Kernel]], [[Gaussian-Elimination]], [[Homogeneous-vs-Inhomogeneous]]

The [[Kernel|kernel]] is a *set* — to work with it, we need to describe it concretely as the [[Linear-Combination|span]] of specific vectors. This file shows how.

## The Procedure

To compute $\operatorname{Kern}(A)$ for an $m \times n$ matrix $A$:

1. **Set up the homogeneous system** $Ax = 0$
2. **Apply [[Gaussian-Elimination|Gaussian elimination]]** to $A$ (the right side stays zero — no augmented matrix needed, but you can use $[A \mid 0]$)
3. **Identify free variables** — columns without pivots
4. **Express basic variables** (columns with pivots) in terms of free variables
5. **Write the kernel as a span:** For each free variable, set it to $1$ and the others to $0$, then read off the corresponding basic variable values
6. **Result:** $\operatorname{Kern}(A) = \operatorname{span}\{v_1, v_2, \ldots, v_k\}$ where $k$ = number of free variables

> [!tip] Key insight
> $\dim(\operatorname{Kern}(A))$ = number of free variables = $n - \operatorname{rank}(A)$.
>
> This is the **Rank-Nullity Theorem** — see [[Kernel-and-Image]].

## Worked Example (UE_11.2)

> Compute $\operatorname{Kern}(f)$ where $f\begin{pmatrix} x_1 \\ x_2 \\ x_3 \\ x_4 \end{pmatrix} = \begin{pmatrix} -x_1 + 2x_2 + 2x_4 \\ 2x_1 - x_2 + 3x_3 + x_4 \\ 3x_2 + 3x_3 + 9x_4 \end{pmatrix}$

**Step 1: Write the matrix $A$ representing $f$**

$$A = \begin{pmatrix} -1 & 2 & 0 & 2 \\ 2 & -1 & 3 & 1 \\ 0 & 3 & 3 & 9 \end{pmatrix}$$

(Check: $Ax$ gives exactly the three components of $f(x)$.)

**Step 2: Set up $Ax = 0$ and apply Gaussian elimination**

Augmented matrix:

$$\left(\begin{array}{cccc|c} -1 & 2 & 0 & 2 & 0 \\ 2 & -1 & 3 & 1 & 0 \\ 0 & 3 & 3 & 9 & 0 \end{array}\right)$$

*Elimination:*
- $R_2 \leftarrow R_2 + 2R_1$:
$$\left(\begin{array}{cccc|c} -1 & 2 & 0 & 2 & 0 \\ 0 & 3 & 3 & 5 & 0 \\ 0 & 3 & 3 & 9 & 0 \end{array}\right)$$

- $R_3 \leftarrow R_3 - R_2$:
$$\left(\begin{array}{cccc|c} -1 & 2 & 0 & 2 & 0 \\ 0 & 3 & 3 & 5 & 0 \\ 0 & 0 & 0 & 4 & 0 \end{array}\right)$$

**Step 3: Identify structure**

Pivots are in columns 1, 2, and 4. Column 3 has **no pivot** → $x_3$ is a **free variable**.

Basic variables: $x_1, x_2, x_4$ (expressed in terms of $x_3$).

**Step 4: Back-substitution**

Row 3: $4x_4 = 0$ → $x_4 = 0$

Row 2: $3x_2 + 3x_3 + 5x_4 = 0$ → $3x_2 + 3x_3 + 0 = 0$ → $x_2 = -x_3$

Row 1: $-x_1 + 2x_2 + 0x_3 + 2x_4 = 0$ → $-x_1 + 2(-x_3) + 0 = 0$ → $-x_1 - 2x_3 = 0$ → $x_1 = -2x_3$

**Step 5: Parameterize**

Set $x_3 = t$ (free):

$$x = \begin{pmatrix} -2t \\ -t \\ t \\ 0 \end{pmatrix} = t \begin{pmatrix} -2 \\ -1 \\ 1 \\ 0 \end{pmatrix}$$

**Result:** $\operatorname{Kern}(f) = \operatorname{span}\left\{\begin{pmatrix} -2 \\ -1 \\ 1 \\ 0 \end{pmatrix}\right\}$ — a 1-dimensional subspace of $\mathbb{R}^4$.

> [!tip] Verification
> $f\begin{pmatrix} -2 \\ -1 \\ 1 \\ 0 \end{pmatrix} = \begin{pmatrix} -(-2) + 2(-1) + 2(0) \\ 2(-2) - (-1) + 3(1) + 0 \\ 3(-1) + 3(1) + 9(0) \end{pmatrix} = \begin{pmatrix} 2 - 2 + 0 \\ -4 + 1 + 3 + 0 \\ -3 + 3 + 0 \end{pmatrix} = \begin{pmatrix} 0 \\ 0 \\ 0 \end{pmatrix}$ ✓

## Practice

> Compute the kernel of the matrix from [[Gaussian-Elimination|UE_10.3]]: $A = \begin{pmatrix} 2 & 1 & 2 \\ -1 & 0 & 1 \\ 2 & 10 & 0 \end{pmatrix}$

*Hint: Since this matrix turned out to have full rank (3 pivots for 3 columns), what must its kernel be?*

> **Next steps:** [[Kernel-and-Image]] — how kernel dimension relates to image dimension | [[Kernel-vs-Solution-Set]] — using the kernel to describe all solutions of $Ax = b$

> [!info] Deutsch: [[../../DE/kern/Kern-Berechnen]]

---

*Last reviewed: 2026-06-09*
