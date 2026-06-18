# Elementary Row Operations

> **Prerequisites:** [[Matrix]]

**Elementary row operations** are the three legal moves you can make on a matrix without changing its solution set. They are the "moves" in [[Gaussian-Elimination|Gaussian elimination]].

## The Three Operations

| # | Operation | Notation | Effect |
|---|-----------|----------|--------|
| **1** | **Swap** two rows | $R_i \leftrightarrow R_j$ | Exchange rows $i$ and $j$ |
| **2** | **Scale** a row | $R_i \leftarrow \lambda R_i$ | Multiply row $i$ by $\lambda \neq 0$ |
| **3** | **Add a multiple** | $R_i \leftarrow R_i + \lambda R_j$ | Add $\lambda$ times row $j$ to row $i$ |

> [!warning] Exam-relevant
> Operation 3 is the most used and the most error-prone. You add a multiple of row $j$ **to** row $i$. Row $j$ itself does NOT change. Only row $i$ is modified.

## Why They Preserve the Solution Set

Each operation corresponds to an action on the equations that's reversible and doesn't change what values of $x$ satisfy them:

1. **Swap:** Reordering equations doesn't change their meaning. $2x + y = 5$ and $x - y = 1$ is the same system regardless of which comes first.

2. **Scale:** Multiplying both sides of an equation by a non-zero number doesn't change its solutions. $2x + 4y = 8$ and $x + 2y = 4$ describe the same line.

3. **Add multiple:** If $E_1$ and $E_2$ are true equations, then $E_1 + \lambda E_2$ is also true. This is the key idea: we're creating a new equation from old ones, but every solution of the original system remains a solution.

> [!tip] Think of it this way
> Each operation is *reversible*. If you can undo an operation and get back to the original system, the solution set is unchanged. All three are reversible:
> - Swap again to undo a swap
> - Scale by $1/\lambda$ to undo scaling by $\lambda$
> - Add $-\lambda R_j$ to undo adding $\lambda R_j$

## Systematic Use in Gaussian Elimination

The goal is always to create zeros below the pivot:

```
┌─────────────────────────────────────┐
│  For column k, pivot at row k:       │
│                                      │
│  1. If a_kk = 0, swap row k with     │
│     a row below (Op 1)              │
│                                      │
│  2. For each row i > k:              │
│     R_i ← R_i - (a_ik/a_kk) R_k      │
│     (Op 3 — creates zero at a_ik)   │
└─────────────────────────────────────┘
```

The multiplier $\frac{a_{ik}}{a_{kk}}$ is chosen so that the entry below the pivot becomes exactly zero.

> [!example]
> To eliminate a $3$ below a pivot of $2$: $\;R_i \leftarrow R_i - \frac{3}{2}R_k$
>
> Check: $3 - \frac{3}{2} \cdot 2 = 3 - 3 = 0$ ✓

> **Next steps:** [[Upper-Triangular-Form]] — the target shape we're working toward | [[Gaussian-Elimination]] — the algorithm that uses these operations

> [!info] Deutsch: [[../../DE/gleichungssysteme/Zeilenoperationen]]

---

*Last reviewed: 2026-06-09*
