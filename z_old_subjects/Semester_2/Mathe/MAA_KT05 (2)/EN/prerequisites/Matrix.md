# Matrix

> **Prerequisites:** [[Vector]]

A **matrix** is a rectangular grid of numbers arranged in rows and columns. Think of it as:
- A table of coefficients from a system of equations
- A "machine" that transforms input [[Vector|vectors]] into output vectors
- A way to organize multiple vectors side by side

## Dimensions and Notation

A matrix with $m$ rows and $n$ columns is called an **$m \times n$ matrix** ("m by n"). The entry in row $i$, column $j$ is written as $a_{ij}$:

$$A = \begin{pmatrix}
a_{11} & a_{12} & \cdots & a_{1n} \\
a_{21} & a_{22} & \cdots & a_{2n} \\
\vdots & \vdots & \ddots & \vdots \\
a_{m1} & a_{m2} & \cdots & a_{mn}
\end{pmatrix}$$

> [!example]
> A $2 \times 3$ matrix: $\begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 5 \end{pmatrix}$
>
> $a_{11} = 1$, $a_{12} = 0$, $a_{23} = 5$

## Matrix-Vector Multiplication

This is the most important operation. A matrix $A$ ($m \times n$) times a [[Vector|vector]] $x$ ($n \times 1$) produces a new vector ($m \times 1$):

$$Ax = \begin{pmatrix} a_{11} & \cdots & a_{1n} \\ \vdots & & \vdots \\ a_{m1} & \cdots & a_{mn} \end{pmatrix} \begin{pmatrix} x_1 \\ \vdots \\ x_n \end{pmatrix} = \begin{pmatrix} a_{11}x_1 + a_{12}x_2 + \cdots + a_{1n}x_n \\ \vdots \\ a_{m1}x_1 + a_{m2}x_2 + \cdots + a_{mn}x_n \end{pmatrix}$$

> [!tip] Key Insight
> $Ax$ **is a [[Linear-Combination|linear combination]] of the columns of** $A$, with the components of $x$ as weights:
>
> $$Ax = x_1 \begin{pmatrix} a_{11} \\ \vdots \\ a_{m1} \end{pmatrix} + x_2 \begin{pmatrix} a_{12} \\ \vdots \\ a_{m2} \end{pmatrix} + \cdots + x_n \begin{pmatrix} a_{1n} \\ \vdots \\ a_{mn} \end{pmatrix}$$
>
> Every time you see $Ax$, think: "I'm combining the columns of $A$ using $x$ as the recipe."

## Matrix-Matrix Multiplication

$A$ ($m \times n$) times $B$ ($n \times p$) gives $C$ ($m \times p$):

$$C = AB \quad \text{where} \quad c_{ij} = \sum_{k=1}^n a_{ik} \, b_{kj}$$

The entry $c_{ij}$ is the dot product of row $i$ of $A$ with column $j$ of $B$.

> [!warning] Exam-relevant
> Matrix multiplication is **not commutative**: in general $AB \neq BA$. One of the two products may not even be defined if dimensions don't match in the reversed order.

## Other Operations

| Operation | Rule | Requirement |
|-----------|------|-------------|
| **Addition** | $(A + B)_{ij} = a_{ij} + b_{ij}$ | Same dimensions |
| **Scalar multiplication** | $(\alpha A)_{ij} = \alpha \cdot a_{ij}$ | None |
| **Transposition** $A^T$ | $(A^T)_{ij} = a_{ji}$ — swap rows and columns | None |

## Where Matrices Appear

- [[Linear-Function|Linear functions]] are represented by matrices — every linear function from $\mathbb{R}^n$ to $\mathbb{R}^m$ can be written as $f(x) = Ax$
- [[Linear-Systems|Linear systems]] are written in matrix form $Ax = b$
- [[Determinant|Determinants]] are computed from (square) matrices
- [[Matrix-Inverse|Matrix inverses]] undo what a matrix does

> **Next steps:** [[Linear-Function]] — understanding matrices as transformations | [[Linear-Systems]] — using matrices to solve equations

> [!info] Deutsch: [[../../DE/prerequisites/Matrix]]

---

*Last reviewed: 2026-06-09*
