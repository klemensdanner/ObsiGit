# Linear Function

> **Prerequisites:** [[Vector]], [[Matrix]]

A **linear function** (also called a *linear map* or *linear transformation*) is a function that "plays nicely" with vector addition and scalar multiplication. It preserves the structure of the vector space.

Think of it this way: if you scale the input, the output scales the same way. If you add two inputs, the output is the sum of the individual outputs. No surprises, no curves — purely straight-line behavior.

## The Two Defining Properties

A function $f: \mathbb{R}^n \to \mathbb{R}^m$ is linear if and only if:

1. **Additivity:** $f(x + y) = f(x) + f(y)$ for all vectors $x, y$
2. **Homogeneity:** $f(\alpha x) = \alpha f(x)$ for all vectors $x$ and scalars $\alpha$

> [!example] Checking linearity
> Is $f(x_1, x_2) = (3x_1 - x_2,\; x_1 + 2x_2)$ linear?
>
> **Additivity:**
> $f(x+y) = (3(x_1+y_1) - (x_2+y_2),\; (x_1+y_1) + 2(x_2+y_2))$
> $\quad = (3x_1 - x_2 + 3y_1 - y_2,\; x_1 + 2x_2 + y_1 + 2y_2)$
> $\quad = (3x_1 - x_2, x_1 + 2x_2) + (3y_1 - y_2, y_1 + 2y_2) = f(x) + f(y)$ ✓
>
> **Homogeneity:**
> $f(\alpha x) = (3\alpha x_1 - \alpha x_2,\; \alpha x_1 + 2\alpha x_2)$
> $\quad = \alpha(3x_1 - x_2, x_1 + 2x_2) = \alpha f(x)$ ✓
>
> → $f$ is linear.

> [!example] Not linear
> $g(x_1, x_2) = (x_1^2,\; x_2)$ is **not** linear. Test homogeneity: $g(2x) = (4x_1^2, 2x_2) \neq 2g(x) = (2x_1^2, 2x_2)$.

## Every Linear Function is a Matrix

This is the crucial connection to [[Matrix|matrices]]:

> [!warning] Exam-relevant
> Every linear function $f: \mathbb{R}^n \to \mathbb{R}^m$ can be written as $f(x) = Ax$ for some $m \times n$ matrix $A$.
>
> The columns of $A$ are simply $f(e_1), f(e_2), \ldots, f(e_n)$ — the images of the standard basis vectors.

> [!example] From function to matrix
> Take $f(x_1, x_2, x_3) = (2x_1 - x_3,\; x_1 + 3x_2 + x_3)$ from $\mathbb{R}^3$ to $\mathbb{R}^2$.
>
> Feed in the basis vectors:
> - $f(1,0,0) = (2, 1)$  → column 1
> - $f(0,1,0) = (0, 3)$  → column 2
> - $f(0,0,1) = (-1, 1)$ → column 3
>
> So $f(x) = \begin{pmatrix} 2 & 0 & -1 \\ 1 & 3 & 1 \end{pmatrix} \begin{pmatrix} x_1 \\ x_2 \\ x_3 \end{pmatrix}$

## Key Vocabulary

Two important sets associated with every linear function:

| Concept | Notation | Meaning |
|---------|----------|---------|
| **[[Kernel]]** | $\operatorname{Kern}(f)$ | All inputs that map to $0$: $\{x \mid f(x) = 0\}$ |
| **[[Kernel-and-Image\|Image]]** | $\operatorname{Bild}(f)$ | All outputs actually reached: $\{f(x) \mid x \in \mathbb{R}^n\}$ |

These are explored in depth in the [[Kernel|kernel section]].

> **Next steps:** [[Linear-Combination]] — understanding span and how vectors combine | [[Kernel]] — the set of vectors a function sends to zero

> [!info] Deutsch: [[../../DE/prerequisites/Lineare-Funktion]]

---

*Last reviewed: 2026-06-09*
