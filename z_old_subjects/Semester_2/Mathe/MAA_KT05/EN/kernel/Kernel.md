# Kernel

> **Prerequisites:** [[Linear-Function]], [[Vector]], [[Matrix]]

The **kernel** (German: *Kern*) of a [[Linear-Function|linear function]] is the set of all inputs that get mapped to zero. Think of it as the "blind spot" of the function — everything the function "can't see" or "crushes to nothing."

## Definition

For a linear function $f: V \to W$:

$$\operatorname{Kern}(f) = \{x \in V \mid f(x) = 0\}$$

For a [[Matrix|matrix]] $A$ (which represents a linear function $f(x) = Ax$):

$$\operatorname{Kern}(A) = \{x \in \mathbb{R}^n \mid Ax = 0\}$$

> [!tip] In plain terms
> The kernel answers: "Which vectors $x$ make $Ax$ come out to exactly zero?"
>
> It's the solution set of the [[Homogeneous-vs-Inhomogeneous|homogeneous system]] $Ax = 0$.

## Intuition: What Gets "Crushed"

Imagine $f(x_1, x_2) = (x_1 - x_2,\; 0)$. This function projects everything onto the $x$-axis and then shifts... no, it simply takes $(x_1, x_2)$ and outputs $(x_1 - x_2, 0)$.

What maps to $(0,0)$? We need $x_1 - x_2 = 0$, so $x_1 = x_2$. The kernel is the line $\{(t, t) \mid t \in \mathbb{R}\}$ — all vectors where the two components are equal.

> [!example] Visual
> For $f(x) = Ax$ with $A = \begin{pmatrix} 1 & -1 \\ 0 & 0 \end{pmatrix}$:
>
> The entire line $y = x$ gets mapped to $(0,0)$. The matrix "squashes" one dimension to zero.
>
> $\operatorname{Kern}(A) = \operatorname{span}\left\{\begin{pmatrix}1\\1\end{pmatrix}\right\}$ — a 1-dimensional subspace.

## The Kernel is Always a Subspace

Unlike general solution sets (which are [[Linear-Manifold|linear manifolds]]), the kernel is a genuine subspace of the input space. This means:

1. **$0 \in \operatorname{Kern}(f)$:** The zero vector is always in the kernel (since $f(0) = 0$ for any linear function)
2. **Closed under addition:** If $x, y \in \operatorname{Kern}(f)$, then $x + y \in \operatorname{Kern}(f)$
3. **Closed under scalar multiplication:** If $x \in \operatorname{Kern}(f)$, then $\alpha x \in \operatorname{Kern}(f)$

## Kernel and Injectivity

> [!warning] Exam-relevant

A linear function $f$ is **injective** (one-to-one: different inputs → different outputs) if and only if its kernel contains only the zero vector:

$$f \text{ is injective} \quad \Longleftrightarrow \quad \operatorname{Kern}(f) = \{0\}$$

**Why:** If $\operatorname{Kern}(f)$ contained some $v \neq 0$, then $f(x) = f(x + v)$ for any $x$ (since $f(v) = 0$), violating injectivity. Conversely, if $\operatorname{Kern}(f) = \{0\}$ and $f(x) = f(y)$, then $f(x - y) = 0$, so $x - y = 0$, so $x = y$.

## Kernel and Invertibility

For a square matrix $A$, having $\operatorname{Kern}(A) = \{0\}$ is equivalent to $A$ being [[Regular-Matrix|regular/invertible]]:

$$\operatorname{Kern}(A) = \{0\} \;\Longleftrightarrow\; \det(A) \neq 0 \;\Longleftrightarrow\; A \text{ is invertible}$$

A non-trivial kernel means the matrix "collapses" at least one dimension, which is irreversible — you can't "uncollapse" what was lost.

> **Next steps:** [[Computing-Kernel]] — the step-by-step procedure | [[Kernel-and-Image]] — the relationship between kernel and image

> [!info] Deutsch: [[../../DE/kern/Kern]]

---

*Last reviewed: 2026-06-09*
