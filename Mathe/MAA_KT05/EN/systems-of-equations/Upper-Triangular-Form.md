# Upper Triangular Form

> **Prerequisites:** [[Row-Operations]], [[Matrix]]

A matrix is in **upper triangular form** (or *row echelon form*) when all entries *below* the main diagonal are zero. This is the target shape of [[Gaussian-Elimination|Gaussian elimination]] — once here, you can read off solutions directly.

## Definition

$$\begin{pmatrix}
a_{11} & a_{12} & a_{13} & \cdots & a_{1n} \\
0      & a_{22} & a_{23} & \cdots & a_{2n} \\
0      & 0      & a_{33} & \cdots & a_{3n} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
0      & 0      & 0      & \cdots & a_{nn}
\end{pmatrix}$$

For every entry $a_{ij}$ with $i > j$ (below the diagonal): $a_{ij} = 0$.

> [!tip] Checking
> Draw the diagonal from top-left to bottom-right. Everything to the left of and below that line must be zero.

## Why It's Useful

Once in upper triangular form, the last equation involves only the last variable. Solve that, substitute upward — this is **back-substitution**:

$$\begin{aligned}
a_{nn} x_n &= b_n \quad &&\rightarrow \quad x_n = b_n / a_{nn} \\
a_{n-1,n-1} x_{n-1} + a_{n-1,n} x_n &= b_{n-1} \quad &&\rightarrow \quad \text{plug in } x_n, \text{ solve for } x_{n-1} \\
&\;\;\vdots
\end{aligned}$$

## Worked Example (UE_11.1)

> Solve the system already in upper triangular form:
> $$\begin{pmatrix} 1 & 3 & -2 & 0 & 2 \\ 0 & -2 & 4 & -2 & 6 \\ 0 & 0 & 0 & 1 & 3 \\ 0 & 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 & 0 \end{pmatrix} x = \begin{pmatrix} -2 \\ 8 \\ 2 \\ 0 \\ 0 \end{pmatrix}$$

**Step 1: Identify pivots.** Pivots are at columns 1 ($1$), 2 ($-2$), and 4 ($1$). Columns 3 and 5 have no pivots → they are **free variables**.
- Basic variables: $x_1, x_2, x_4$
- Free variables: $x_3, x_5$

**Step 2: Back-substitution from the bottom non-zero row.**

Row 4: $0 \cdot x_3 + 0 \cdot x_5$ — zero row, skip.
Row 3: $x_4 + 3x_5 = 2$ → $x_4 = 2 - 3x_5$

Row 2: $-2x_2 + 4x_3 - 2x_4 + 6x_5 = 8$
Substitute $x_4$: $-2x_2 + 4x_3 - 2(2 - 3x_5) + 6x_5 = 8$
→ $-2x_2 + 4x_3 - 4 + 6x_5 + 6x_5 = 8$
→ $-2x_2 + 4x_3 + 12x_5 = 12$
→ $x_2 = 2x_3 + 6x_5 - 6$

Row 1: $x_1 + 3x_2 - 2x_3 + 0x_4 + 2x_5 = -2$
Substitute $x_2$: $x_1 + 3(2x_3 + 6x_5 - 6) - 2x_3 + 2x_5 = -2$
→ $x_1 + 6x_3 + 18x_5 - 18 - 2x_3 + 2x_5 = -2$
→ $x_1 + 4x_3 + 20x_5 = 16$
→ $x_1 = 16 - 4x_3 - 20x_5$

**Step 3: Write solution as a [[Linear-Manifold|linear manifold]].**

Set $x_3 = s$, $x_5 = t$ (free parameters):

$$x = \begin{pmatrix} 16 \\ -6 \\ 0 \\ 2 \\ 0 \end{pmatrix} + s \begin{pmatrix} -4 \\ 2 \\ 1 \\ 0 \\ 0 \end{pmatrix} + t \begin{pmatrix} -20 \\ 6 \\ 0 \\ -3 \\ 1 \end{pmatrix}$$

## Connection to Determinant

For a square upper triangular matrix, the [[Determinant|determinant]] is simply the product of the diagonal entries:

$$\det\begin{pmatrix} a_{11} & a_{12} & a_{13} \\ 0 & a_{22} & a_{23} \\ 0 & 0 & a_{33} \end{pmatrix} = a_{11} \cdot a_{22} \cdot a_{33}$$

> [!warning] Exam-relevant — UE_10.2
> This is not a coincidence — it's provable by repeatedly applying Laplace expansion to the first column. See [[Determinant#Proof for Upper Triangular Matrices|the proof]].

> **Next steps:** [[Solution-Set]] — classifying the solution type | [[Gaussian-Elimination]] — how to get a matrix into this form

> [!info] Deutsch: [[../../DE/gleichungssysteme/Obere-Dreiecksform]]

---

*Last reviewed: 2026-06-09*
