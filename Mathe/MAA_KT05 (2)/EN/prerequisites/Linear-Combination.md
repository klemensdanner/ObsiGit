# Linear Combination

> **Prerequisites:** [[Vector]]

A **linear combination** is what you get when you scale vectors and add them together. It's the most fundamental way of building new vectors from existing ones.

## Definition

Given vectors $v_1, v_2, \ldots, v_k$ and scalars (numbers) $\alpha_1, \alpha_2, \ldots, \alpha_k$, the expression

$$\alpha_1 v_1 + \alpha_2 v_2 + \cdots + \alpha_k v_k$$

is called a **linear combination** of $v_1, \ldots, v_k$. The $\alpha_i$ are the *coefficients* (or *weights*) of the combination.

> [!example] Building vectors
> In $\mathbb{R}^2$, take $v_1 = (1,0)$ and $v_2 = (0,1)$:
>
> - $3v_1 + 2v_2 = 3(1,0) + 2(0,1) = (3, 0) + (0, 2) = (3, 2)$
> - $-v_1 + 4v_2 = (-1, 4)$
> - $0v_1 + 0v_2 = (0, 0)$ (the zero vector — always reachable)
>
> With just these two vectors, you can reach **any point** in $\mathbb{R}^2$.

## The Span (Linear Hull)

The **span** (or *linear hull*) of a set of vectors is the set of *all possible* linear combinations of those vectors:

$$\operatorname{span}\{v_1, \ldots, v_k\} = \{\alpha_1 v_1 + \cdots + \alpha_k v_k \mid \alpha_1, \ldots, \alpha_k \in \mathbb{R}\}$$

> [!tip] Intuition
> The span answers: "Starting from these vectors, what points can I reach by scaling and adding?"
>
> - Span of one non-zero vector in $\mathbb{R}^2$ → a line through the origin
> - Span of two independent vectors in $\mathbb{R}^2$ → the entire plane
> - Span of two dependent vectors (one is a multiple of the other) → still just a line

## Linear Independence (Brief)

A set of vectors is **linearly independent** if no vector in the set can be written as a linear combination of the others. Equivalently:

$$\alpha_1 v_1 + \cdots + \alpha_k v_k = 0 \quad \text{only when} \quad \alpha_1 = \alpha_2 = \cdots = \alpha_k = 0$$

If you *can* get the zero vector with non-zero coefficients, the vectors are **linearly dependent** — at least one of them is "redundant."

> [!example]
> - $\{(1,0), (0,1)\}$ are independent in $\mathbb{R}^2$
> - $\{(1,0), (2,0)\}$ are dependent — $(2,0) = 2(1,0)$, the second is just a scaled copy of the first

> [!warning] Exam-relevant — UE_11.4
> When Gaussian elimination produces solution vectors $v_1, \ldots, v_k$ (one per free variable), these vectors are **always linearly independent**. Why? Each $v_i$ has a $1$ in the position corresponding to "its" free variable — a position where all other $v_j$ have $0$. No linear combination can cancel that $1$ without using $v_i$ itself.

## Where Linear Combinations Appear

- **[[Matrix]]-vector product:** $Ax$ is the linear combination of the columns of $A$ with weights $x_1, \ldots, x_n$
- **[[Linear-Manifold|Linear manifolds]]:** Solutions of $Ax = b$ are shifted spans
- **[[Kernel|Kernel]]** is expressed as $\operatorname{span}\{v_1, \ldots, v_k\}$
- **[[Rank]]** measures the dimension of the span of the columns

> **Next steps:** [[Linear-Manifold]] — what happens when you shift a span | [[Rank]] — measuring the "size" of a span

> [!info] Deutsch: [[../../DE/prerequisites/Linearkombination]]

---

*Last reviewed: 2026-06-09*
