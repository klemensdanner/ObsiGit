# Gaussian Elimination

> **Prerequisites:** [[Linear-Systems]], [[Matrix]], [[Row-Operations]]

**Gaussian elimination** is the workhorse algorithm of linear algebra. It systematically transforms any linear system $Ax = b$ into [[Upper-Triangular-Form|upper triangular form]], from which solutions are read off by back-substitution.

## Motivation: Why We Need a Method

You can solve $2 \times 2$ systems by hand (isolate $x_1$, substitute into the other equation). But for $n \times n$ systems with $n > 2$, that approach becomes a mess. Gaussian elimination is the systematic, machine-friendly alternative that works for any size.

## The Algorithm (Step by Step)

Given an augmented matrix $[A \mid b]$:

1. **Forward elimination** — column by column, left to right:
   - Find the **pivot** — the first non-zero entry in the current column, on or below the current row
   - If the pivot row is not the current row, swap rows (see [[Row-Operations]])
   - For every row *below* the pivot row: subtract a multiple of the pivot row to eliminate the entry below the pivot

2. **Back-substitution** — once in [[Upper-Triangular-Form|upper triangular form]], solve from bottom to top:
   - The last non-zero row gives the last variable
   - Substitute that into the row above to get the next variable
   - Continue upward

> [!warning] Exam-relevant
> Gaussian elimination gives you three things simultaneously:
> 1. Whether a solution exists (no contradiction row)
> 2. The [[Solution-Set|type of solution set]] (unique vs. infinite)
> 3. The actual solution values

## Worked Example

> From UE_10.3: Solve $\begin{pmatrix} 2 & 1 & 2 \\ -1 & 0 & 1 \\ 2 & 10 & 0 \end{pmatrix} x = \begin{pmatrix} 1 \\ 2 \\ 3 \end{pmatrix}$

**Step 1: Write the augmented matrix**

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ -1 & 0 & 1 & 2 \\ 2 & 10 & 0 & 3 \end{array}\right)$$

**Step 2: Forward elimination**

*Column 1 — pivot is $2$ in row 1:*
- Row 2: $R_2 \leftarrow R_2 + \frac{1}{2}R_1$ (eliminates $-1$)
- Row 3: $R_3 \leftarrow R_3 - R_1$ (eliminates $2$)

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ 0 & 0.5 & 2 & 2.5 \\ 0 & 9 & -2 & 2 \end{array}\right)$$

*Column 2 — pivot is $0.5$ in row 2:*
- Row 3: $R_3 \leftarrow R_3 - 18R_2$ (eliminates $9$, since $9/0.5 = 18$)

$$\left(\begin{array}{ccc|c} 2 & 1 & 2 & 1 \\ 0 & 0.5 & 2 & 2.5 \\ 0 & 0 & -38 & -43 \end{array}\right)$$

Now we're in upper triangular form. No row like $(0\;0\;0 \mid c)$ with $c \neq 0$ → solution exists. Three pivots, three variables → unique solution.

**Step 3: Back-substitution**

From row 3: $-38x_3 = -43$ → $x_3 = \frac{43}{38}$

From row 2: $0.5x_2 + 2x_3 = 2.5$ → $0.5x_2 = 2.5 - 2 \cdot \frac{43}{38}$ → $x_2 = \ldots$

From row 1: $2x_1 + x_2 + 2x_3 = 1$ → solve for $x_1$

## Edge Cases

| Situation | What to do |
|-----------|------------|
| **Zero pivot** — current column has all zeros at/below current row | [[Row-Operations\|Swap]] with a row below that has a non-zero entry. If none exist, move to the next column (this creates a free variable). |
| **Contradiction row** — a row like $(0\;0\;\ldots\;0 \mid c)$ with $c \neq 0$ | Stop — the system has **no solution**. |
| **Row of all zeros** — $(0\;0\;\ldots\;0 \mid 0)$ | The row is redundant. Remove it or keep as a zero row — no effect on solutions. |

> **Practice:** Solve the systems from UE_10.4 and UE_10.5. See [[Gaussian-Elimination-Examples]] for full worked solutions.

> **Next steps:** [[Gaussian-Elimination-Examples]] — two more worked examples with commentary | [[Upper-Triangular-Form]] — why the triangular shape matters | [[Solution-Set]] — interpreting what the elimination reveals

> [!info] Deutsch: [[../../DE/gleichungssysteme/Gauss-Elimination]]

---

*Last reviewed: 2026-06-09*
