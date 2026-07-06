# Kernel vs. Solution Set

> **Prerequisites:** [[Kernel]], [[Solution-Set]], [[Homogeneous-vs-Inhomogeneous]], [[Linear-Manifold]]

This file ties together the three main topics: systems of equations, kernels, and matrix inversion. It's the "unifying view" — if you understand this, you understand the core structure of linear algebra.

## The Big Picture

Every linear system $Ax = b$ has a solution structure dictated entirely by the [[Kernel|kernel]] of $A$:

$$\boxed{\text{All solutions to } Ax = b \;=\; x_p + \operatorname{Kern}(A)}$$

where $x_p$ is any **one** particular solution satisfying $Ax_p = b$.

## Three Scenarios, One Formula

| The system $Ax = b$ | Kernel | Solution structure |
|---------------------|--------|--------------------|
| **$b = 0$** (homogeneous) | $\operatorname{Kern}(A)$ is the full solution set | $\operatorname{Kern}(A)$ — a subspace (passes through origin) |
| **$b \neq 0$** (inhomogeneous) | $\operatorname{Kern}(A)$ is the "direction space" | $x_p + \operatorname{Kern}(A)$ — a [[Linear-Manifold\|linear manifold]] (shifted subspace) |
| **$A$ invertible** | $\operatorname{Kern}(A) = \{0\}$ | $x = A^{-1}b$ — unique solution (manifold of dimension 0) |

## Why This Structure Holds

The proof is one line in each direction:

**If $x$ is a solution, then $x - x_p \in \operatorname{Kern}(A)$:**
$$A(x - x_p) = Ax - Ax_p = b - b = 0$$

**If $v \in \operatorname{Kern}(A)$, then $x_p + v$ is a solution:**
$$A(x_p + v) = Ax_p + Av = b + 0 = b$$

So the solution set is exactly $x_p + \operatorname{Kern}(A)$ — no more, no less.

## Concrete Full Example

Solve $Ax = b$ completely, where:

$$A = \begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 2 \\ 1 & -1 & 6 \end{pmatrix}, \quad b = \begin{pmatrix} -1 \\ 4 \\ 6 \end{pmatrix}$$

From [[Gaussian-Elimination-Examples#Example 1|UE_10.4]]:

**Step 1: Find a particular solution $x_p$.** Set the free variable $x_3 = 0$:
$$x_p = \begin{pmatrix} -1 \\ -7 \\ 0 \end{pmatrix}$$

**Step 2: Find the kernel.** Solve $Ax = 0$:
$$\operatorname{Kern}(A) = \operatorname{span}\left\{\begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix}\right\}$$

**Step 3: Combine:**
$$\text{All solutions} = \begin{pmatrix} -1 \\ -7 \\ 0 \end{pmatrix} + t \begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix}, \quad t \in \mathbb{R}$$

## Connection to Matrix Inversion

When $A$ is [[Regular-Matrix|regular]] ($\det(A) \neq 0$, full rank):

- $\operatorname{Kern}(A) = \{0\}$ — only the zero vector
- $Ax = b$ has exactly one solution: $x = A^{-1}b$
- The linear manifold $x_p + \operatorname{Kern}(A)$ collapses to a single point: $\{A^{-1}b\}$

This is why [[Matrix-Inverse|matrix inversion]] is such a clean method — but only works when the kernel is trivial.

## Connection to Rank

The dimension of the solution manifold equals $\dim(\operatorname{Kern}(A))$, which by the [[Kernel-and-Image|Rank-Nullity Theorem]] equals $n - \operatorname{rank}(A)$:

| Rank situation | $\dim(\operatorname{Kern})$ | Solution type |
|----------------|---------------------------|---------------|
| Full rank ($\operatorname{rank} = n$) | $0$ | Unique solution (a point) |
| Rank $n-1$ | $1$ | Solutions form a line |
| Rank $n-2$ | $2$ | Solutions form a plane |
| Rank $n-k$ | $k$ | Solutions form a $k$-dimensional manifold |

> [!warning] Exam-relevant
> The number of free variables in the solution = $\dim(\operatorname{Kern}(A))$ = $n - \operatorname{rank}(A)$.
>
> Knowing any two of $\{\text{rank}, \dim(\operatorname{Kern}), n\}$ gives you the third.

## Summary: The Solution Algorithm (Complete)

To fully solve $Ax = b$:

1. Apply [[Gaussian-Elimination]] → determine if solutions exist
2. If yes, find **one** particular solution $x_p$ (set all free variables to 0)
3. Find **all** solutions to $Ax = 0$ → this is $\operatorname{Kern}(A)$
4. Write the general solution: $x = x_p + \operatorname{Kern}(A)$

> **Next steps:** Return to [[Home|Home]] for an overview, or explore any topic via the graph view.

> [!info] Deutsch: [[../../DE/kern/Kern-vs-Loesungsmenge]]

---

*Last reviewed: 2026-06-09*
