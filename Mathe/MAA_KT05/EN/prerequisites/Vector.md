# Vector

> **Prerequisites:** none — this is a starting point

A **vector** is simply an ordered list of numbers. You can think of it as:
- An arrow pointing somewhere in space
- A row or column in a spreadsheet
- A data point with multiple coordinates
- The coefficients in an equation like $3x_1 - 2x_2 + x_3$

We work in $\mathbb{R}^n$ — the set of all vectors with $n$ real-number components.

## Notation

A vector with $n$ components can be written as a **column** or **row**:

$$v = \begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix} \quad \text{or} \quad v = (v_1, v_2, \ldots, v_n)$$

We switch between both forms freely. Column form is preferred when vectors interact with [[Matrix|matrices]].

## Basic Operations

**Vector Addition** — add component by component:

$$\begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix} + \begin{pmatrix} w_1 \\ w_2 \\ \vdots \\ w_n \end{pmatrix} = \begin{pmatrix} v_1 + w_1 \\ v_2 + w_2 \\ \vdots \\ v_n + w_n \end{pmatrix}$$

**Scalar Multiplication** — multiply every component by the same number $\alpha$:

$$\alpha \cdot \begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix} = \begin{pmatrix} \alpha v_1 \\ \alpha v_2 \\ \vdots \\ \alpha v_n \end{pmatrix}$$

> [!example] Concrete
> In $\mathbb{R}^3$: $v = (1, -2, 4)$, $w = (3, 0, -1)$
>
> $v + w = (4, -2, 3)$
>
> $2v = (2, -4, 8)$
>
> $-w = (-3, 0, 1)$

## Special Vectors

- **Zero vector** $0 = (0, 0, \ldots, 0)$ — adding it changes nothing: $v + 0 = v$
- **Inverse** $-v = (-v_1, -v_2, \ldots, -v_n)$ — satisfies $v + (-v) = 0$

## Key Insight

Every vector in $\mathbb{R}^n$ can be built from the **standard basis vectors**:

$$e_1 = \begin{pmatrix}1\\0\\0\\ \vdots\\0\end{pmatrix}, \; e_2 = \begin{pmatrix}0\\1\\0\\ \vdots\\0\end{pmatrix}, \; \ldots, \; e_n = \begin{pmatrix}0\\0\\ \vdots\\0\\1\end{pmatrix}$$

For example: $(3, -2, 5) = 3e_1 + (-2)e_2 + 5e_3$

This idea — building vectors by scaling and adding — is called a [[Linear-Combination|linear combination]] and is the central concept of linear algebra.

## Where This Leads

Vectors are the objects that:
- [[Linear-Function|Linear functions]] take as input and produce as output
- [[Linear-Systems|Linear systems]] solve for
- [[Matrix|Matrices]] transform
- [[Kernel|Kernels]] are made of

> **Next steps:** [[Matrix]] — how we organize vectors into rectangular arrays | [[Linear-Combination]] — building new vectors from existing ones

> [!info] Deutsch: [[../../DE/prerequisites/Vektor]]

---

*Last reviewed: 2026-06-09*
