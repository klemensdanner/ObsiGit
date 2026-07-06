# Kernel and Image

> **Prerequisites:** [[Kernel]], [[Rank]], [[Linear-Function]]

Every [[Linear-Function|linear function]] $f: V \to W$ has two fundamental subspaces associated with it: the **kernel** (what gets sent to zero) and the **image** (what actually comes out). Together, they tell the complete story of the function.

## Definitions

| Space | Notation | Definition | In words |
|-------|----------|------------|----------|
| **Kernel** | $\operatorname{Kern}(f)$ | $\{x \in V \mid f(x) = 0\}$ | "Everything crushed to zero" |
| **Image** | $\operatorname{Bild}(f)$ | $\{f(x) \mid x \in V\}$ | "Everything that actually comes out" |

For a [[Matrix|matrix]] $A$ representing $f(x) = Ax$:

- $\operatorname{Kern}(A) = \{x \mid Ax = 0\}$ — solution set of the homogeneous system
- $\operatorname{Bild}(A) = \operatorname{span}\{\text{columns of } A\}$ — the column space

> [!tip] Intuition
> Imagine a projector shining a 3D object onto a 2D screen:
> - **Image** = the 2D shadow on the screen (what you see)
> - **Kernel** = the direction perpendicular to the screen (the depth information that's lost)
> - Everything along the kernel direction gets "crushed" to the same point on the screen

## The Rank-Nullity Theorem

> [!warning] Exam-relevant

For a linear function $f: V \to W$ where $V$ has finite dimension $n$:

$$\dim(\operatorname{Kern}(f)) + \dim(\operatorname{Bild}(f)) = \dim(V)$$

In words: **Input dimension = dimensions destroyed + dimensions preserved.**

For an $m \times n$ matrix $A$:

$$\dim(\operatorname{Kern}(A)) + \operatorname{rank}(A) = n$$

where $\operatorname{rank}(A) = \dim(\operatorname{Bild}(A))$ (see [[Rank]]).

> [!example]
> For the function from [[Computing-Kernel#Worked Example|UE_11.2]]:
> - Input dimension $n = 4$ ($x \in \mathbb{R}^4$)
> - $\dim(\operatorname{Kern}(f)) = 1$ (one free variable → the kernel is a line)
> - Therefore $\operatorname{rank}(A) = 4 - 1 = 3$ (the image is 3-dimensional)
>
> Check: The elimination produced 3 non-zero rows → rank = 3 ✓

## What the Numbers Tell You

| Situation | What it means |
|-----------|---------------|
| $\dim(\operatorname{Kern}) = 0$ | $f$ is injective (one-to-one). Nothing is lost. |
| $\dim(\operatorname{Bild}) = \dim(W)$ | $f$ is surjective (onto). Every output is reachable. |
| Both above | $f$ is bijective (invertible) — $A$ is [[Regular-Matrix$\|$regular]] |
| $\dim(\operatorname{Kern}) > 0$ | $f$ loses information. Multiple inputs map to the same output. |

## Computing the Image

$\operatorname{Bild}(A)$ = column space of $A$. To find a basis:

1. Apply [[Gaussian-Elimination|Gaussian elimination]] to $A$
2. Identify the **pivot columns** in the original $A$ (not the eliminated form!)
3. Those columns form a basis of $\operatorname{Bild}(A)$

> [!example]
> For $A = \begin{pmatrix} -1 & 2 & 0 & 2 \\ 2 & -1 & 3 & 1 \\ 0 & 3 & 3 & 9 \end{pmatrix}$ from UE_11.2:
>
> Pivots in columns 1, 2, and 4 → $\operatorname{Bild}(A) = \operatorname{span}\left\{\begin{pmatrix}-1\\2\\0\end{pmatrix}, \begin{pmatrix}2\\-1\\3\end{pmatrix}, \begin{pmatrix}2\\1\\9\end{pmatrix}\right\}$
>
> $\dim(\operatorname{Bild}(A)) = 3 = \operatorname{rank}(A)$ ✓

## Visual Summary

```
Input space V (dimension n)
    │
    │  f(x) = Ax
    ▼
Output space W
    │
    ├── Kernel (dimension k): vectors that map to 0
    │   "Lost" dimensions: n - rank(A)
    │
    └── Image (dimension r): vectors actually reached
        "Preserved" dimensions: rank(A)

    n = k + r   ← Rank-Nullity Theorem
```

> **Next steps:** [[Kernel-vs-Solution-Set]] — how kernel and image connect to solving $Ax = b$ | [[Rank]] — the rank concept in full detail

> [!info] Deutsch: [[../../DE/kern/Kern-und-Bild]]

---

*Last reviewed: 2026-06-09*
