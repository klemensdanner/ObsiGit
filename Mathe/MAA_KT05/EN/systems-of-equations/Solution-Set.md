# Solution Set of a Linear System

> **Prerequisites:** [[Linear-Systems]], [[Gaussian-Elimination]], [[Linear-Manifold]]

Every linear system $Ax = b$ has exactly one of three possible outcomes. [[Gaussian-Elimination|Gaussian elimination]] reveals which one during the forward elimination phase.

## The Three Cases

### Case 1: No Solution ($\emptyset$)

**How to recognize:** During elimination, a row appears in the augmented matrix of the form:

$$(0 \; 0 \; \ldots \; 0 \mid c) \quad \text{with } c \neq 0$$

This translates to the equation $0 = c$, which is impossible.

> [!example]
> From [[Gaussian-Elimination-Examples#Example 2|UE_10.5]]: the elimination produced $(0\;0\;0 \mid 1)$ → $0 = 1$ → no solution.

The geometric interpretation: the equations contradict each other (e.g., parallel planes that don't all intersect at a common point).

### Case 2: Exactly One Solution

**How to recognize:** Every column of $A$ has a pivot. No free variables. The elimination produces an upper triangular form with non-zero entries on the entire diagonal (for a square system).

> [!example]
> From [[Gaussian-Elimination#Worked Example|UE_10.3]]: pivots in columns 1, 2, 3 → unique solution $x = (-1.5, 3, 0.5)^T$

The geometric interpretation: $n$ hyperplanes intersecting at exactly one point.

### Case 3: Infinitely Many Solutions

**How to recognize:** No contradiction row, but fewer pivots than variables. Variables without pivots are **free** — they can take any value, and the other variables are expressed in terms of them.

The solution is a [[Linear-Manifold|linear manifold]]: $x = v_0 + \alpha_1 v_1 + \cdots + \alpha_k v_k$, where $k$ = number of free variables = (number of variables) − (number of pivots).

> [!example]
> From [[Gaussian-Elimination-Examples#Example 1|UE_10.4]]: 2 pivots for 3 variables → 1 free variable → solution is a line in $\mathbb{R}^3$.

## Determining the Solution Type: Decision Flow

```
Elimination complete
        │
        ├─ Contradiction row? ──── YES ──→ NO SOLUTION
        │
        NO
        │
        ├─ Variables = Pivots? ─── YES ──→ UNIQUE SOLUTION
        │
        NO
        │
        └─→ INFINITELY MANY SOLUTIONS
            (linear manifold of dimension: variables − pivots)
```

## Checking Equality of Two Solution Representations

> [!warning] Exam-relevant — UE_11.3

Suppose you solved $Ax = b$ and got $v_0 + U$, but the model solution says $w_0 + W$. How to check if both describe the same set?

**Two representations describe the same [[Linear-Manifold|linear manifold]] if:**

1. **Same direction space:** $U = W$. Verify by checking that every basis vector of $U$ lies in $W$ and vice versa. Since both come from Gaussian elimination, $U$ and $W$ typically have the same dimension — it's enough to check that each $u_i \in U$ can be expressed as a linear combination of the $w_j \in W$.

2. **Shift difference in the space:** $v_0 - w_0 \in U$. The difference between the two "particular solutions" must lie in the direction space. Equivalently: there exist coefficients $\alpha_i$ such that $v_0 = w_0 + \sum \alpha_i w_i$.

> [!tip] Practical check
> Set up $v_0 = w_0 + \alpha_1 w_1 + \cdots + \alpha_k w_k$, solve for $\alpha_1, \ldots, \alpha_k$. If a solution exists, and both spans are equal, the two manifolds are identical.

## Why Solution Vectors from Gaussian Elimination are Linearly Independent

> [!warning] Exam-relevant — UE_11.4

When Gaussian elimination produces a solution of the form $v_0 + \alpha_1 v_1 + \cdots + \alpha_k v_k$, the set $\{v_1, \ldots, v_k\}$ is **always linearly independent**.

**Why:** Each $v_i$ corresponds to exactly one free variable. In $v_i$, that free variable is set to $1$ and all *other* free variables are set to $0$. This means:
- $v_i$ has a $1$ in the component corresponding to "its" free variable
- All other $v_j$ ($j \neq i$) have a $0$ in that same component

No linear combination of the other $v_j$ can ever reproduce $v_i$ because they all have $0$ where $v_i$ has $1$. This is a direct structural guarantee from the algorithm — no extra checking needed.

> [!example] From UE_10.4
> Solution: $v_0 + t \cdot v_1$ where $v_1 = (2, 8, 1)^T$ and $x_3$ was the free variable.
> $v_1$ has a $1$ at position 3 ($x_3$'s position). A single non-zero vector is always linearly independent.

> **Next steps:** [[Homogeneous-vs-Inhomogeneous]] — the deeper structure behind solution sets | [[Kernel-vs-Solution-Set]] — how the kernel ties it all together

> [!info] Deutsch: [[../../DE/gleichungssysteme/Loesungsmenge]]

---

*Last reviewed: 2026-06-09*
