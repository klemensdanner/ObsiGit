# Mathematics for Software Engineering — Knowledge Base

Welcome! This is an in-depth reference for the linear algebra topics covered in the MAA course at FH Hagenberg.

## What You'll Find Here

This knowledge base covers three interconnected topics from linear algebra, built from the exercise sheets UE_10 and UE_11 and the course textbook (Dreiseitl, *Mathematik für Software Engineering*, Chapters 5.2–5.5):

- **[[Linear-Systems|Systems of Linear Equations]]** — Solving $Ax = b$ with Gaussian elimination
- **[[Matrix-Inverse|Matrix Inversion]]** — Computing $A^{-1}$ and understanding when it exists
- **[[Kernel|Kernel]]** — The set of vectors a linear function sends to zero

## I Want To...

| Task | Go to |
|------|-------|
| ...solve a linear system $Ax = b$ | [[Linear-Systems]] → [[Gaussian-Elimination]] |
| ...invert a matrix | [[Matrix-Inverse]] → [[Gauss-Jordan]] |
| ...compute a kernel | [[Kernel]] → [[Computing-Kernel]] |
| ...check if a matrix is invertible | [[Regular-Matrix]] |
| ...compute a determinant | [[Determinant]] |
| ...understand solution structure | [[Solution-Set]] → [[Kernel-vs-Solution-Set]] |
| ...look up a definition quickly | Use search or graph view — every term is linked |

## Learning Paths

Depending on your goal, pick one of these paths:

### Path A: Concept-First (Understand the theory)

```
Vector → Matrix → Linear-Function → Linear-Combination
                                    ↓
                              Linear-Systems → Gaussian-Elimination
                                    ↓
                              Kernel → Kernel-and-Image
                                    ↓
                              Matrix-Inverse → Regular-Matrix
```

Start with [[Vector]] and follow the links through. Each file lists its prerequisites at the top and recommended next steps at the bottom.

### Path B: Computation-First (Solve exercise sheets)

```
Gaussian-Elimination → Gaussian-Elimination-Examples
        ↓
Upper-Triangular-Form → Solution-Set
        ↓
Computing-Kernel → Kernel-vs-Solution-Set
        ↓
Gauss-Jordan → Determinant
```

Start with [[Gaussian-Elimination]] — you'll learn the core algorithm first and pick up the theory as needed through backlinks.

## Topic Overview

| Topic | Main file | What it covers |
|-------|-----------|----------------|
| **Systems of Equations** | [[Linear-Systems]] | $Ax = b$, Gaussian elimination, solution types, homogeneous vs. inhomogeneous |
| **Matrix Inversion** | [[Matrix-Inverse]] | $A^{-1}$, Gauss-Jordan, regular/singular matrices, determinants |
| **Kernel** | [[Kernel]] | $\operatorname{Kern}(f)$, computing the kernel, rank-nullity theorem, kernel and solution sets |

## How to Use This

- **Hover** over any link to see a preview of that file's content
- **Follow** links to dive deeper into a concept
- **Backlinks** (shown in Obsidian's right sidebar) let you see which files reference the current one
- **Graph view** visualizes how all concepts connect — the three topic hubs form spokes around the prerequisites core
- **`> [!warning]` callouts** mark content that is especially relevant for exams

> [!tip] Pro tip
> Most content is behind [[prerequisites/Vector|backlinks]] — the main files are concise on purpose. Hover to preview, click to dive deep.

---

> [!info] Deutsch: [[../DE/Home]]

*Last updated: 2026-06-09*
