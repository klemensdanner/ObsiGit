# Homogeneous vs. Inhomogeneous Systems

> **Prerequisites:** [[Linear-Systems]], [[Solution-Set]], [[Kernel]]

A linear system $Ax = b$ falls into one of two families depending on the right-hand side $b$.

## Definitions

| Type | Form | Characteristic |
|------|------|---------------|
| **Homogeneous** | $Ax = 0$ | Right-hand side is the zero vector |
| **Inhomogeneous** | $Ax = b$ with $b \neq 0$ | Right-hand side is non-zero |

## Homogeneous Systems ($Ax = 0$)

Every homogeneous system has at least one guaranteed solution: $x = 0$ (the **trivial solution**). The question is only whether there are *more* solutions beyond $x = 0$.

The solution set of $Ax = 0$ is exactly the [[Kernel|kernel]] of $A$:

$$\{x \mid Ax = 0\} = \operatorname{Kern}(A)$$

Unlike general solution sets, $\operatorname{Kern}(A)$ is always a **subspace** (not just a manifold): it contains $0$, and is closed under addition and scalar multiplication — if $x$ and $y$ are solutions, so is $\alpha x + \beta y$.

> [!example]
> For the matrix from [[Gaussian-Elimination-Examples#Example 1|UE_10.4]]:
> $$A = \begin{pmatrix} 1 & 0 & -2 \\ 3 & -1 & 2 \\ 1 & -1 & 6 \end{pmatrix}$$
>
> $Ax = 0$ gives: $x = t \begin{pmatrix} 2 \\ 8 \\ 1 \end{pmatrix} = \operatorname{Kern}(A)$ — a line through the origin.

## Inhomogeneous Systems ($Ax = b$, $b \neq 0$)

The solution set is **not** a subspace (it generally doesn't contain $0$). Instead, it's a [[Linear-Manifold|linear manifold]]: a shifted version of the kernel.

## The Fundamental Structure

> [!warning] Exam-relevant

The general solution of an inhomogeneous system is:

$$\boxed{\text{All solutions to } Ax = b \;=\; x_p + \operatorname{Kern}(A)}$$

where $x_p$ is any **particular solution** — just one vector that satisfies $Ax_p = b$.

> [!tip] Why this works
> If $x$ is any solution to $Ax = b$, then $A(x - x_p) = Ax - Ax_p = b - b = 0$.
>
> So $(x - x_p) \in \operatorname{Kern}(A)$. That means $x = x_p + v$ for some $v \in \operatorname{Kern}(A)$.
>
> Conversely, for any $v \in \operatorname{Kern}(A)$: $A(x_p + v) = Ax_p + Av = b + 0 = b$.

## Side-by-Side Example

Consider $A = \begin{pmatrix} 2 & 1 \\ 4 & 2 \end{pmatrix}$ (rank 1).

| | $Ax = 0$ (homog.) | $Ax = \begin{pmatrix}3\\6\end{pmatrix}$ (inhomog.) |
|---|---|---|
| **Row reduce** | $\begin{pmatrix}2&1\\0&0\end{pmatrix}x = 0$ | $\begin{pmatrix}2&1&3\\0&0&0\end{pmatrix}$ |
| **Result** | $2x_1 + x_2 = 0$ | $2x_1 + x_2 = 3$ |
| **Set** | $x_2 = -2x_1$ → $x = t\begin{pmatrix}1\\-2\end{pmatrix}$ | $x_2 = 3 - 2x_1$ → $x = \begin{pmatrix}0\\3\end{pmatrix} + t\begin{pmatrix}1\\-2\end{pmatrix}$ |
| **Geometry** | Line through origin | Same line, shifted away from origin |
| **Type** | Subspace ([[Kernel]]) | [[Linear-Manifold\|Linear manifold]] |

Notice the structure: $\text{Inhomog. solution} = \underbrace{\begin{pmatrix}0\\3\end{pmatrix}}_{x_p} + \underbrace{t\begin{pmatrix}1\\-2\end{pmatrix}}_{\operatorname{Kern}(A)}$

> **Next steps:** [[Kernel-vs-Solution-Set]] — the unified view of kernel and solution sets | [[Computing-Kernel]] — how to actually compute the kernel

> [!info] Deutsch: [[../../DE/gleichungssysteme/Homogen-vs-Inhomogen]]

---

*Last reviewed: 2026-06-09*
