# Gauss-Jordan Elimination

> **Prerequisites:** [[Matrix-Inverse]], [[Gaussian-Elimination]], [[Row-Operations]]

**Gauss-Jordan elimination** computes the [[Matrix-Inverse|inverse]] of a matrix. It extends [[Gaussian-Elimination|Gaussian elimination]] — where Gaussian stops at upper triangular form, Gauss-Jordan goes all the way to the identity matrix.

## Motivation

The formula for the inverse using cofactors (see [[Determinant]]) is theoretically elegant but computationally horrific for $n > 3$. Gauss-Jordan is the practical method.

## The Algorithm

Given an $n \times n$ matrix $A$:

1. Write the augmented matrix $[A \mid I_n]$
2. Apply [[Row-Operations|elementary row operations]] to transform the left side into $I_n$
3. The right side is then $A^{-1}$: you have $[I_n \mid A^{-1}]$

> [!tip] The intuition
> Each row operation is equivalent to multiplying on the left by some matrix. The sequence of operations that turns $A$ into $I$ is exactly $A^{-1}$. Applying those same operations to $I$ produces $A^{-1}$.

## Difference from Gaussian Elimination

| Step | Gaussian Elim. | Gauss-Jordan |
|------|---------------|--------------|
| Forward elimination (zeros below pivots) | ✅ | ✅ |
| Make pivots equal to $1$ | Optional | ✅ (scale each pivot row) |
| **Backward elimination** (zeros **above** pivots) | ❌ | ✅ |
| End result | [[Upper-Triangular-Form]] | Identity matrix $I$ |

Gaussian elimination produces a triangle; Gauss-Jordan goes further and produces the identity matrix.

## Worked Example (UE_11.5)

> Compute the inverse of $A = \begin{pmatrix} 1 & 1 & 1 \\ 1 & 2 & 3 \\ 0 & 1 & 3 \end{pmatrix}$

**Step 1: Augment with $I_3$**

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 1 & 1 & 0 & 0 \\ 1 & 2 & 3 & 0 & 1 & 0 \\ 0 & 1 & 3 & 0 & 0 & 1 \end{array}\right)$$

**Step 2: Forward elimination** (zeros below pivots)

*Column 1:* $R_2 \leftarrow R_2 - R_1$

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 1 & 1 & 0 & 0 \\ 0 & 1 & 2 & -1 & 1 & 0 \\ 0 & 1 & 3 & 0 & 0 & 1 \end{array}\right)$$

*Column 2:* $R_3 \leftarrow R_3 - R_2$

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 1 & 1 & 0 & 0 \\ 0 & 1 & 2 & -1 & 1 & 0 \\ 0 & 0 & 1 & 1 & -1 & 1 \end{array}\right)$$

Now the left side is upper triangular. **Gauss-Jordan continues** — eliminate *above* the diagonal:

**Step 3: Backward elimination** (zeros above pivots)

*Eliminate column 3 above row 3:*
- $R_2 \leftarrow R_2 - 2R_3$
- $R_1 \leftarrow R_1 - R_3$

$$\left(\begin{array}{ccc|ccc} 1 & 1 & 0 & 0 & 1 & -1 \\ 0 & 1 & 0 & -3 & 3 & -2 \\ 0 & 0 & 1 & 1 & -1 & 1 \end{array}\right)$$

*Eliminate column 2 above row 2:* $R_1 \leftarrow R_1 - R_2$

$$\left(\begin{array}{ccc|ccc} 1 & 0 & 0 & 3 & -2 & 1 \\ 0 & 1 & 0 & -3 & 3 & -2 \\ 0 & 0 & 1 & 1 & -1 & 1 \end{array}\right)$$

**Step 4: Read off the inverse**

$$A^{-1} = \begin{pmatrix} 3 & -2 & 1 \\ -3 & 3 & -2 \\ 1 & -1 & 1 \end{pmatrix}$$

> [!tip] Always verify
> Multiply $A \cdot A^{-1}$ and confirm you get $I$. Quick spot check:
> Row 1 of $A$ · Column 1 of $A^{-1}$: $1 \cdot 3 + 1 \cdot (-3) + 1 \cdot 1 = 3 - 3 + 1 = 1$ ✓

## Edge Case: Singular Matrix

If during elimination a **row of zeros** appears on the left side, the matrix is singular — $A^{-1}$ does not exist. You cannot get the left side to $I$ because some rows are irretrievably zero.

> [!warning] Exam-relevant
> If elimination produces $[0\;0\;\ldots\;0 \mid \text{some row}]$ on the left, stop immediately — the matrix is not [[Regular-Matrix|regular]]. No inverse exists.

> **Next steps:** [[Regular-Matrix]] — the full set of invertibility criteria | [[Determinant]] — determinant checks and the $2 \times 2$ inverse formula

> [!info] Deutsch: [[../../DE/matrix-inversion/Gauss-Jordan]]

---

*Last reviewed: 2026-06-09*
