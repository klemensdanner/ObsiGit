# Linear Manifold

> **Prerequisites:** [[Vector]], [[Linear-Combination]]

A **linear manifold** is a shifted subspace — think of a plane that doesn't pass through the origin. It's what you get when you take a subspace (a "flat" through the origin) and slide it somewhere else.

## Definition

A set $M \subseteq \mathbb{R}^n$ is a linear manifold if it can be written as:

$$M = v_0 + U = \{v_0 + u \mid u \in U\}$$

where $v_0$ is a fixed vector (the *shift*) and $U$ is a subspace (a set closed under addition and scalar multiplication).

Since every subspace can be expressed as a [[Linear-Combination|span]], we usually write:

$$M = v_0 + \operatorname{span}\{v_1, v_2, \ldots, v_k\}$$

The number $k$ is the **dimension** of the manifold.

> [!example] In $\mathbb{R}^2$
> The line $y = 2x + 1$ does not pass through the origin (at $x=0$, $y=1$).
>
> Write it as a manifold: take a point on the line, say $v_0 = (0, 1)$.
> The direction of the line is $(1, 2)$.
>
> So: $M = \begin{pmatrix} 0 \\ 1 \end{pmatrix} + \operatorname{span}\left\{\begin{pmatrix} 1 \\ 2 \end{pmatrix}\right\}$
>
> Every point on the line is $(0,1) + t(1,2) = (t, 1+2t)$.

> [!example] In $\mathbb{R}^3$
> A plane shifted from the origin:
> $M = \begin{pmatrix} 1 \\ 0 \\ -1 \end{pmatrix} + \operatorname{span}\left\{\begin{pmatrix} 1 \\ 0 \\ 2 \end{pmatrix}, \begin{pmatrix} 0 \\ 1 \\ 3 \end{pmatrix}\right\}$

## Why Linear Manifolds Matter

The **solution set of an inhomogeneous linear system** $Ax = b$ (with $b \neq 0$) is a linear manifold:

$$\text{All solutions} = x_p + \operatorname{Kern}(A)$$

where $x_p$ is any *particular* solution. See [[Solution-Set]] and [[Homogeneous-vs-Inhomogeneous]] for the full story.

## Checking Equality of Two Manifolds

> [!warning] Exam-relevant — UE_11.3

Suppose you found the solution to $Ax = b$ and got $v_0 + \operatorname{span}\{v_1, v_2\}$, but the model solution says $w_0 + \operatorname{span}\{w_1, w_2\}$. Are they the same set?

**Two linear manifolds $v_0 + U$ and $w_0 + W$ are equal if and only if:**
1. **$U = W$** — the direction subspaces are identical (same span), **and**
2. **$v_0 - w_0 \in U$** — the difference between the shift vectors lies in that subspace

> [!tip] What this means in practice
> To check if two solution representations describe the same set:
> 1. Verify that every direction vector from one representation lies in the span of the other's direction vectors (and vice versa)
> 2. Verify that the difference of the particular solutions is a linear combination of the direction vectors
>
> If both hold, the two representations describe the exact same linear manifold.

## Subspace vs. Linear Manifold

| Property | Subspace | Linear Manifold |
|----------|----------|-----------------|
| Contains $0$? | Always | Only if $v_0 \in U$ |
| Closed under $+$? | Yes | No (generally) |
| Solution of $Ax = 0$? | Yes — [[Kernel]] | No |
| Solution of $Ax = b$ ($b \neq 0$)? | No | **Yes** |

> **Next steps:** [[Solution-Set]] — how manifolds appear as solutions to linear systems | [[Homogeneous-vs-Inhomogeneous]] — the homogeneous/manifold connection

> [!info] Deutsch: [[../../DE/prerequisites/Lineare-Mannigfaltigkeit]]

---

*Last reviewed: 2026-06-09*
