# Determinant

> **Prerequisites:** [[Matrix]]

The **determinant** of a square matrix is a single number, written $\det(A)$ or $|A|$, that captures important properties of the matrix. Geometrically, it measures how much the linear transformation "scales" volumes, and whether it flips orientation.

## Intuition

Think of the unit square (area 1) in $\mathbb{R}^2$. Apply a matrix $A$ as a transformation. The image is a parallelogram whose area is $|\det(A)|$. If $\det(A)$ is negative, the orientation flipped (mirror image).

For a matrix to be [[Regular-Matrix|invertible]], this area must not collapse to zero — hence $\det(A) \neq 0$.

## Computing Determinants

### $2 \times 2$: The Basic Formula

$$\det\begin{pmatrix} a & b \\ c & d \end{pmatrix} = ad - bc$$

> [!example]
> $\det\begin{pmatrix} 3 & 1 \\ 2 & 4 \end{pmatrix} = 3 \cdot 4 - 1 \cdot 2 = 12 - 2 = 10$

### $3 \times 3$: Sarrus' Rule

$$\det\begin{pmatrix} a_{11} & a_{12} & a_{13} \\ a_{21} & a_{22} & a_{23} \\ a_{31} & a_{32} & a_{33} \end{pmatrix} = \begin{aligned} &a_{11}a_{22}a_{33} + a_{12}a_{23}a_{31} + a_{13}a_{21}a_{32} \\ &- a_{13}a_{22}a_{31} - a_{11}a_{23}a_{32} - a_{12}a_{21}a_{33} \end{aligned}$$

> [!tip] Memorization trick
> Write the first two columns again to the right:
> ```
> a11 a12 a13 | a11 a12
> a21 a22 a23 | a21 a22
> a31 a32 a33 | a31 a32
> ```
> Sum the three ↘ diagonals (blue), subtract the three ↙ diagonals (red).

### $n \times n$: Laplace Expansion

For larger matrices, we "develop" (expand) along a row or column, recursively reducing to smaller determinants.

**The idea:** Pick a row $i$ (or column $j$). The determinant is the sum of each entry in that row times its **cofactor**:

$$\det(A) = \sum_{j=1}^n a_{ij} \, C_{ij}$$

where the **cofactor** $C_{ij}$ is:

- **Minor** $M_{ij}$: The determinant of the submatrix formed by deleting row $i$ and column $j$
- **Cofactor** $C_{ij} = (-1)^{i+j} \cdot M_{ij}$ — the sign alternates in a chessboard pattern:

$$\begin{pmatrix} + & - & + & \cdots \\ - & + & - & \cdots \\ + & - & + & \cdots \\ \vdots & \vdots & \vdots & \ddots \end{pmatrix}$$

> [!warning] Exam-relevant — UE_10.1
> Apply Laplace expansion repeatedly until you reach $3 \times 3$ submatrices, then use Sarrus. This is how we compute determinants of $4 \times 4$ and larger matrices.

> [!example] Working through UE_10.1
> Compute $\det\begin{pmatrix} 1 & 0 & 0 & 0 & 1 \\ -2 & 2 & -1 & 0 & 3 \\ -1 & 0 & -3 & 3 & 4 \\ 0 & 0 & 2 & 0 & 0 \\ 3 & 0 & 4 & -1 & -3 \end{pmatrix}$
>
> **Expand along column 2** (it has three zeros — minimal work):
>
> Only $a_{22} = 2$ contributes. Its cofactor: $C_{22} = (-1)^{2+2} M_{22} = +M_{22}$.
>
> Delete row 2, column 2 — we get a $4 \times 4$ determinant.
>
> Continue expanding until we reach $3 \times 3$, then apply Sarrus.

## Properties

| Property | Explanation |
|----------|-------------|
| $\det(AB) = \det(A) \det(B)$ | Determinant of product = product of determinants |
| $\det(A^{-1}) = 1 / \det(A)$ | Follows from above: $\det(AA^{-1}) = \det(I) = 1$ |
| $\det(A^T) = \det(A)$ | Transpose doesn't change determinant |
| $\det(I) = 1$ | Identity has determinant 1 |
| Row swap → sign flips | $\det(\text{swapped}) = -\det(\text{original})$ |
| Scale a row by $\lambda$ → det scales by $\lambda$ | Multiply one row by 5 → determinant ×5 |
| Add multiple of row → det unchanged | This is why row operations work |

### Proof: Upper Triangular Determinant (UE_10.2)

> [!warning] Exam-relevant

For an upper triangular matrix, the determinant equals the product of the diagonal entries:

$$\det\begin{pmatrix} a_{11} & a_{12} & \cdots & a_{1n} \\ 0 & a_{22} & \cdots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & \cdots & a_{nn} \end{pmatrix} = a_{11} \cdot a_{22} \cdot \cdots \cdot a_{nn}$$

**Proof by repeated Laplace expansion on the first column:**

Expand along column 1. Only $a_{11}$ can be non-zero (all entries below it are zero). Its minor $M_{11}$ is the $(n-1) \times (n-1)$ upper triangular matrix with $a_{22}, \ldots, a_{nn}$ on the diagonal.

So $\det(A_n) = a_{11} \cdot \det(A_{n-1})$.

By induction: $\det(A_n) = a_{11} \cdot a_{22} \cdot \det(A_{n-2}) = \cdots = a_{11} \cdot a_{22} \cdot \cdots \cdot a_{nn}$.

The same proof works for **lower** triangular matrices (all zeros above diagonal) by expanding along the first row.

## Determinant and Invertibility

$$\det(A) \neq 0 \quad \Longleftrightarrow \quad A \text{ is } \textbf{regular/invertible}$$

$$\det(A) = 0 \quad \Longleftrightarrow \quad A \text{ is } \textbf{singular}$$

> **Next steps:** [[Regular-Matrix]] — the full set of regularity criteria | [[Gauss-Jordan]] — the practical method for computing inverses

> [!info] Deutsch: [[../../DE/matrix-inversion/Determinante]]

---

*Last reviewed: 2026-06-09*
