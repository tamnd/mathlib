# 03. Mathlib as mathematics

This document describes Mathlib as a body of mathematics: its foundations, its design, the ideas that a reader must learn once, and the way its areas depend on each other. The handbook teaches these ideas in Volumes 0 and 1 and uses them everywhere after. The sizes and the folder tree are in 01.1 and in report A.

## 3.1 The foundation

Mathlib is written in Lean 4, whose logic is a dependent type theory with:
- a hierarchy of universes `Sort u`, with `Prop` at the bottom and `Type u = Sort (u+1)`;
- inductive types (the natural numbers, structures, the logical connectives);
- quotient types (`Quot`, with the axiom `Quot.sound`);
- the axioms `propext` (equal propositions are equal) and `Classical.choice`.

A proof in Mathlib uses at most these three axioms (`propext`, `Classical.choice`, `Quot.sound`). The handbook says this in Volume 0 and shows `#print axioms` on one main theorem of each volume. Mathlib is classical: excluded middle and choice are used freely, and decidability instances are a tool for computation, not a restriction on proofs.

What the reader must learn:
1. **Propositions are types and proofs are terms.** A theorem `theorem foo : P` is a term of type `P`. The handbook uses this only to read statements: `∀ x, P x` is a dependent function type, `∃ x, P x` is an inductive type, `P → Q` is implication.
2. **Sets are predicates.** `Set α` is `α → Prop`. A subset is not a type, but every set gives a subtype `↥s`. This is why Mathlib has both `Set`-level and type-level forms of many results.
3. **Functions are total.** Every function is defined everywhere. Division by zero, the square root of a negative number, the logarithm of zero, the limit of a divergent sequence and the integral of a non-integrable function all have values. These are the **junk values** (3.4).

## 3.2 The design ideas

These ideas shape almost every statement in the library. Volume 1 has one chapter for each.

### 3.2.1 Type classes and the hierarchy

Algebraic and analytic structure is carried by type classes: `Monoid`, `Group`, `Ring`, `Field`, `Module R M`, `Algebra R A`, `TopologicalSpace`, `MetricSpace`, `NormedField`, `MeasurableSpace`, and so on. A class extends others (`Ring` extends `Semiring` and `Neg`). Instances are found by search. A theorem stated for `[Field K]` applies to $\mathbb{Q}$, $\mathbb{R}$, $\mathbb{C}$, $\mathbb{Z}/p$ and every other field the library knows.

The hierarchy is large. The algebraic part alone has the chain magma, semigroup, monoid, group, with commutative, ordered, additive and "with zero" variants. A reader needs the map of the hierarchy, not each class. Volume 1 prints the map, and each volume that uses a part of it repeats the relevant piece.

Mixins and unbundled predicates: some properties are separate classes that combine with a structure (`IsDomain`, `CharZero`, `NoZeroDivisors`, `T2Space`, `CompactSpace`, `IsFiniteMeasure`). A theorem lists them as hypotheses in square brackets.

### 3.2.2 Bundled morphisms and morphism classes

A ring homomorphism is a structure `R →+* S` that holds the function and the proofs. Mathlib has bundled types for many kinds of maps (`→*`, `→+`, `→ₗ[R]`, `→ₐ[R]`, `≃`, `≃+*`, `→L[𝕜]`, `≃ₜ`, `→ᵇ`, and more) and classes over them (`MonoidHomClass`, `RingHomClass`, `FunLike`). A lemma like `map_add` is stated once for every type of maps that are additive. The handbook explains the pattern once (Volume 1) and then names the bundled type at each definition.

### 3.2.3 Coercions

A natural number in a real formula is written `(n : ℝ)` in Lean and shown as `↑n`. A subgroup coerces to a set and to a type. A bundled map coerces to a function. The `norm_cast` and `push_cast` tactics move coercions. The handbook writes the coercion arrows in the Mathlib boxes and omits them in the mathematical text, as textbooks do, and says so.

### 3.2.4 Filters

Limits in Mathlib are stated with filters. `Tendsto f l₁ l₂` says that the preimage under `f` of each set of `l₂` is in `l₁`. With `l₁ = atTop` and `l₂ = 𝓝 a` this is the limit of a sequence. With `l₁ = 𝓝[≠] x` it is a limit at a point. "Eventually" (`∀ᶠ x in l, P x`) and "frequently" are filter statements. Almost everywhere in measure theory is the filter `ae μ`. The handbook introduces filters in the topology volume, but it states every limit theorem of the analysis volumes in the textbook form first and then in the filter form, so that a reader of the analysis volumes does not need filters until the Mathlib box.

### 3.2.5 Generality

Mathlib states a result in the most general setting it can prove it in. The intermediate value theorem is for a densely ordered conditionally complete linear order with the order topology. Taylor's theorem is for functions into a normed space. Cauchy-Schwarz is for an inner product space over `RCLike 𝕜`, which covers $\mathbb{R}$ and $\mathbb{C}$ at once. The handbook states the textbook case first and the Mathlib generality second, and it gives an example that only the general form covers.

### 3.2.6 Order and lattices

Many objects of Mathlib form a complete lattice: the subgroups of a group, the topologies on a type, the filters, the σ-algebras, the submodules, the ideals. Mathlib uses this to get infima, suprema, generated objects (`Subgroup.closure`, `Ideal.span`) and Galois connections (`map` and `comap`) with one API. The order volume (06.2) teaches lattices and Galois connections before the algebra volumes, so that these appear as one idea.

### 3.2.7 Finiteness

Mathlib has several forms of "finite": `Finset α` (a finite set as data), `Fintype α` (a type with a list of its elements), `Finite α` (a type that is finite, as a proposition), `Set.Finite s`, and `Nat.card` and `Fintype.card` and `Finset.card` and `Set.ncard` and `Set.encard` and `Cardinal.mk`. Sums over finite sets are `Finset.sum`, and `∑ᶠ` and `tsum` are the finite and the unconditional infinite sums. The handbook gives a table of these forms in Volume 1 and uses it in the combinatorics and algebra volumes.

### 3.2.8 Naming and normal forms

Lemma names follow a convention: the name reads the statement (`mul_comm`, `Nat.succ_le_iff`, `Continuous.comp`, `IsCompact.image`). A reader who knows the convention can guess most names. The `simp` set defines a normal form for each kind of expression. The handbook teaches the naming convention in Volume 1 and uses it to explain the E0 families (04.3), which are named by pattern.

### 3.2.9 `to_additive` and duplication

Each multiplicative result about monoids and groups has an additive twin made by the `to_additive` attribute: `mul_comm` and `add_comm`, `Subgroup` and `AddSubgroup`, `prod` and `sum`. The handbook states the multiplicative form and names the twin. The coverage rule counts the twin at the depth of its source (04.4).

## 3.3 The areas and how they depend on each other

The folders of `Mathlib/` (report A §3) group into areas. The diagram shows the main dependencies. An arrow means that the later area uses the earlier one in its definitions, not only in a few proofs.

```
Logic, Order ─┬─► Data (Nat, Int, Rat, List, Finset, Set) ─► Algebra (hierarchy, big operators)
              │                                                    │
              │                    ┌───────────────────────────────┼──────────────────────┐
              │                    ▼                               ▼                      ▼
              │             GroupTheory          LinearAlgebra ◄── RingTheory ──► FieldTheory
              │                    │                    │              │               │
              ▼                    │                    ▼              ▼               ▼
   SetTheory (cardinals,           │            RepresentationTheory  NumberTheory ◄───┘
   ordinals)                       │                                   ▲
              ┌────────────────────┘                                   │
              ▼                                                        │
   Topology (filters, spaces, uniform, metric) ─► Analysis (normed spaces, calculus,
              │                                     special functions, complex) ───┤
              ▼                                           │                         │
   MeasureTheory ─► Probability                           ▼                         │
              ▲                                    Geometry (Euclidean, manifolds)  │
              └──────────── Analysis (integrals) ───┘                               │
                                                                                    │
   CategoryTheory ─► AlgebraicTopology, Condensed, AlgebraicGeometry ◄── RingTheory ┘
   Combinatorics, Computability, ModelTheory, InformationTheory, Dynamics: on Algebra, Order, Topology
   Tactic: the tools of all areas
```

Two facts follow for the handbook.
1. **The teaching order is not the folder order.** `Mathlib/Order` is needed before algebra, and `Mathlib/CategoryTheory` is written in a style that needs the reader to know some algebra and topology first, even though it depends on little of the library. Volume order is in 06.
2. **Some areas are large and shallow, some small and deep.** `Mathlib/Data` and `Mathlib/Algebra` hold many API lemmas (high E0 share). `Mathlib/NumberTheory` and `Mathlib/Analysis` hold long chains of real theorems (high E3 share). The page estimates of 06 follow the E3 and E2 counts, not the file counts.

## 3.4 The conventions that surprise a mathematician

Volume 1 has a chapter that lists these. Each later Mathlib box that meets one refers back to it.

| Convention | Example | Why |
|---|---|---|
| Total division | `x / 0 = 0`, `(0 : ℝ)⁻¹ = 0` | functions are total; many identities hold with no hypothesis |
| Truncated subtraction on ℕ | `(3 : ℕ) - 5 = 0` | ℕ has no negatives |
| Integer division rounds | `(7 : ℤ) / 2 = 3`, `(-7 : ℤ) / 2 = -4` | the Euclidean convention |
| Junk values of partial functions | `Real.sqrt (-1) = 0`, `Real.log 0 = 0`, `Real.log (-x) = Real.log x` | totality; chosen to make lemmas hold |
| Limits and integrals of bad functions | `deriv f x = 0` if `f` is not differentiable at `x`; `∫ x, f x ∂μ = 0` if `f` is not integrable; `limUnder` is a choice | totality |
| Infinite sums | `tsum f = 0` if `f` is not summable; summable means unconditionally | the topology of finite subsets |
| `ENNReal` and `EReal` | measures take values in `[0, ∞]` | measure theory needs ∞ |
| Indexing | `Fin n` is `{0, …, n-1}`; matrices are `Matrix m n R`, functions of two index types | types as index sets |
| Polynomials | `Polynomial R` is a finitely supported function; `natDegree 0 = 0` and `degree 0 = ⊥` | totality |
| Equality of structures | two groups are "the same" only up to `≃*` | types are not sets |

## 3.5 What Mathlib does not have

The handbook says what is missing, as a textbook says what is beyond its scope. Each volume ends with a short chapter "What Mathlib does not yet have" that lists the standard results of the area that are not in the library at the edition commit, from Mathlib's `docs/undergrad.yaml` (the entries with no declaration, 01.1) and from the review of the volume. This chapter is regenerated at each edition from the curated lists. A missing result that is later added moves into the main text in the next edition, through the drift report (05.5).
