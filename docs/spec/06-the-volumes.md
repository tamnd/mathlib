# 06. The volumes

The handbook has 35 volumes of text (V00 to V34) in seven parts, and a Catalogue of generated reference volumes (06.4). Together the volumes cover every top-level folder of `Mathlib/`. The folder counts are from master `b9019de30e` (2026-11-26, report A §3). The volume map that assigns modules to volumes is `blueprint/volumes.yaml` (09.2). The table here is its first version.

The order of the volumes is a teaching order. It follows the dependencies of 03.3, not the order of the folders.

## 6.1 The parts

| Part | Volumes | Reader | Mathlib folders |
|---|---|---|---|
| I. Foundations | V00 to V04 | every reader | `Logic`, `Basic`, `Order`, `Data` (numbers, sets, finite structures), `Control`, `Util`, `Lean`, `Init` |
| II. Algebra | V05 to V12 | undergraduate to graduate | `Algebra`, `GroupTheory`, `LinearAlgebra`, `RingTheory`, `FieldTheory`, `NumberTheory` |
| III. Topology and analysis | V13 to V21 | undergraduate to graduate | `Topology`, `Analysis`, `MeasureTheory`, `Probability`, `Dynamics`, `InformationTheory` |
| IV. Geometry | V22, V23 | graduate | `Geometry`, `LinearAlgebra/AffineSpace`, `Analysis/Convex` |
| V. Categories and their uses | V24 to V29 | graduate | `CategoryTheory`, `Algebra/Homology`, `Algebra/Category`, `AlgebraicTopology`, `Condensed`, `AlgebraicGeometry`, `RepresentationTheory`, `Algebra/Lie` |
| VI. Discrete mathematics and logic | V30 to V33 | undergraduate to graduate | `Combinatorics`, `SetTheory`, `ModelTheory`, `Computability`, `Data` (data structures), `Testing` |
| VII. Tactics | V34 | every Lean reader | `Tactic` |

## 6.2 The volumes

Files are the `.lean` files of the prefixes of the volume (approximate; a folder split between volumes is split by subfolder). Pages are a first estimate from 04.7, to be measured on V00, V05 and V13 at milestone M1. "Spine" gives the textbooks whose order and notation the volume follows where Mathlib allows.

| Vol. | Title | Main Mathlib prefixes | Files | Level | Pages | Spine |
|---|---|---|---|---|---|---|
| V00 | Guide: how to read Mathlib | `Init`, the Lean core as needed | n/a | guide | 180 | MIL Ch. 1 to 3; TPIL |
| V01 | The language of Mathlib | `Logic`, `Basic`, `Control`, `Util`, `Lean`; design notes | 190 | foundation | 380 | the Mathlib style guide and library notes |
| V02 | Numbers | `Data/Nat`, `Int`, `Rat`, `PNat`, `Fin`, `ZMod`, `Real` (construction), `Complex` (basics), `Num`, `Basic/Real`, `ENNReal`, `NNReal`, `EReal` | 230 | undergraduate | 420 | Tao, *Analysis I* Ch. 2 to 5; Landau, *Foundations* |
| V03 | Sets, finite structures and big operators | `Data/Set`, `Finset`, `Multiset`, `Fintype`, `Finite`, `Finsupp`, `DFinsupp`, `Sym`, `Algebra/BigOperators` | 270 | undergraduate | 480 | Graham-Knuth-Patashnik; Halmos, *Naive Set Theory* |
| V04 | Order and lattices | `Order` except `Order/Filter`, `Algebra/Order` (the order part) | 380 | undergraduate | 520 | Davey-Priestley; Birkhoff, *Lattice Theory* |
| V05 | Groups | `Algebra/Group`, `GroupWithZero`, `GroupTheory` | 400 | undergraduate | 620 | Dummit-Foote Part I; Rotman, *Theory of Groups* |
| V06 | Rings, fields and ordered algebra | `Algebra/Ring`, `Field`, `CharP`, `Star`, `Algebra/Algebra`, `Algebra/Order` (ordered rings and fields), `Algebra/ContinuedFractions`, `QuadraticAlgebra` | 330 | undergraduate | 520 | Dummit-Foote Part II; Jacobson, *Basic Algebra I* |
| V07 | Linear algebra | `Algebra/Module`, `LinearAlgebra` (basis, dimension, matrices, determinants, eigenspaces, dual, free modules, PIDs), `Data/Matrix` | 300 | undergraduate | 620 | Axler; Hoffman-Kunze |
| V08 | Multilinear algebra and forms | `LinearAlgebra` (tensor products, multilinear, exterior, Clifford, bilinear and quadratic forms, projectivization), `Algebra/DirectSum` | 150 | graduate | 420 | Bourbaki, *Algebra* Ch. II, III, IX; Lam, *Quadratic Forms* |
| V09 | Commutative algebra I: ideals, polynomials, factorization | `RingTheory` (ideals, quotients, localization, Noetherian, Artinian, UFD, PID, Euclidean), `Algebra/Polynomial`, `MvPolynomial`, `RingTheory/Polynomial`, `PowerSeries`, `MvPowerSeries` | 380 | undergraduate to graduate | 640 | Atiyah-Macdonald Ch. 1 to 7; Dummit-Foote Ch. 7 to 9 |
| V10 | Commutative algebra II: valuations, Dedekind domains, local algebra | `RingTheory` (Dedekind, valuations, completion, adic, local rings, dimension, flat, smooth, étale, unramified, Kähler, Witt vectors, finiteness, spectrum, trace and norm) | 330 | graduate | 600 | Atiyah-Macdonald Ch. 8 to 11; Matsumura; Stacks |
| V11 | Fields and Galois theory | `FieldTheory`, `RingTheory/Algebraic`, `Algebra/Field` (extensions) | 110 | undergraduate to graduate | 420 | Lang, *Algebra* Ch. V, VI; Milne, *Fields and Galois Theory* |
| V12 | Number theory | `NumberTheory` | 255 | undergraduate to graduate | 640 | Ireland-Rosen; Neukirch Ch. I, II; Diamond-Shurman (modular forms) |
| V13 | General topology | `Topology` (basic, order, separation, compactness, connected, bases, Baire, homotopy basics, continuous maps), `Order/Filter`, uniform, metric and emetric spaces | 340 | undergraduate | 640 | Munkres; Bourbaki, *General Topology* I, II, IX |
| V14 | Topological algebra and infinite sums | `Topology/Algebra`, `Topology/Instances`, `tsum` | 230 | graduate | 420 | Bourbaki, *General Topology* III, IV |
| V15 | Real analysis in one variable | `Analysis/SpecialFunctions` (exp, log, trig, powers), `Analysis/Real`, the one-variable parts of `Analysis/Calculus`, `Analysis/Asymptotics`, `Topology/Instances/Real` | 200 | undergraduate | 560 | Rudin, *Principles*; Tao, *Analysis I* and *II* |
| V16 | Normed spaces and functional analysis | `Analysis/Normed`, `InnerProductSpace`, `LocallyConvex`, `CStarAlgebra`, `Analysis/Convex`, `Analysis/RCLike`, spectrum | 380 | graduate | 680 | Brezis; Conway, *Functional Analysis*; Rudin, *Functional Analysis* |
| V17 | Differential calculus in normed spaces | `Analysis/Calculus` (Fréchet derivative, `ContDiff`, inverse and implicit functions, Taylor, mean value), `Analysis/Analytic`, ODE | 170 | graduate | 460 | Cartan, *Differential Calculus*; Dieudonné, *Foundations* |
| V18 | Measure and integration | `MeasureTheory` | 343 | graduate | 760 | Folland; Bogachev; Rudin, *Real and Complex Analysis* |
| V19 | Complex and harmonic analysis | `Analysis/Complex`, `Meromorphic`, `Fourier`, `Distribution`, `Analysis/SpecialFunctions` (Gamma, Beta, zeta, Gaussian) | 150 | graduate | 520 | Ahlfors; Stein-Shakarchi I to III; Hörmander I |
| V20 | Probability | `Probability` | 141 | graduate | 520 | Durrett; Kallenberg; Williams, *Probability with Martingales* |
| V21 | Dynamics, ergodic theory and information theory | `Dynamics`, `InformationTheory` | 46 | graduate | 220 | Walters; Einsiedler-Ward; Cover-Thomas |
| V22 | Affine, Euclidean and convex geometry | `Geometry/Euclidean`, `Geometry/Convex`, `LinearAlgebra/AffineSpace`, `Analysis/Convex` (geometry part) | 110 | undergraduate | 360 | Berger, *Geometry I, II*; Coxeter |
| V23 | Manifolds and bundles | `Geometry/Manifold`, `Topology/VectorBundle`, `FiberBundle`, `Geometry/Diffeology` | 100 | graduate | 440 | Lee, *Smooth Manifolds* |
| V24 | Category theory | `CategoryTheory` (categories, functors, Yoneda, limits, adjunctions, monoidal, comma, bicategories, monads) | 600 | graduate | 760 | Mac Lane; Riehl, *Category Theory in Context*; Borceux |
| V25 | Higher structures in categories | `CategoryTheory` (abelian, preadditive, triangulated, localization, shift, sites and sheaves, presentable, Galois categories, object and morphism properties) | 540 | research | 700 | Kashiwara-Schapira; Johnstone, *Sketches* (sites) |
| V26 | Homological algebra | `Algebra/Homology`, `Algebra/Category`, `RepresentationTheory/Homological` | 330 | graduate | 560 | Weibel; Gelfand-Manin |
| V27 | Algebraic topology and condensed mathematics | `AlgebraicTopology`, `Topology/Homotopy`, `CWComplex`, `Covering`, `Topology/Category`, `Condensed` | 270 | graduate to research | 540 | Hatcher; Goerss-Jardine; Riehl-Verity; Scholze, *Lectures on Condensed Mathematics* |
| V28 | Algebraic geometry | `AlgebraicGeometry`, `Topology/Sheaves`, `Geometry/RingedSpace` | 180 | graduate | 560 | Hartshorne Ch. II; Görtz-Wedhorn; Stacks; Silverman (elliptic curves) |
| V29 | Representation theory and Lie theory | `RepresentationTheory`, `Algebra/Lie`, `LinearAlgebra/RootSystem`, `GroupTheory/Coxeter` | 130 | graduate | 460 | Serre, *Linear Representations*; Humphreys, *Lie Algebras*; Bourbaki, *Lie* IV to VI |
| V30 | Combinatorics | `Combinatorics` | 192 | undergraduate to graduate | 520 | Diestel; Tao-Vu; Oxley; Bollobás |
| V31 | Set theory | `SetTheory` | 57 | graduate | 300 | Jech; Kunen |
| V32 | Logic, model theory and computability | `ModelTheory`, `Computability`, `Logic/Godel` | 65 | graduate | 320 | Marker; Cutland; Sipser |
| V33 | Data structures and computation | `Data` (List, Vector, Tree, Seq, WSeq, QPF, PFunctor, Ordmap, Num), `Control`, `Testing` | 180 | foundation | 320 | Okasaki; Bird, *Algebra of Programming* |
| V34 | The tactics of Mathlib | `Tactic` | 423 | every Lean reader | 380 | the Mathlib tactic docs; the Lean Language Reference §14 |
| | Total | | about 8,740 | | about 17,500 | |

The total is about 17,500 pages, about 500 per volume. The estimate rests on 04.7 with about 4% of the declarations at E3 and 12% at E2. M1 measures it on three volumes, and the plan is redone then (15).

## 6.3 The main theorems of each volume

The table fixes the E3 theorems that each volume must have, from Mathlib's curated lists and the module docstrings. Each name is a target that the planner role checks against the index at M0 (some may be in `Archive`, which the handbook treats as a pointer only, or missing). The full E3 list of a volume is in `blueprint/sections/<vol>.yaml`.

| Vol. | Main definitions and theorems (E3) | Required worked examples |
|---|---|---|
| V00 | reading a signature; `#check`, `#print axioms`; what a proof term is; how to find a declaration | the proof of $\sqrt 2 \notin \mathbb{Q}$ read line by line in Lean; the junk values $1/0$ and $3-5$ in ℕ |
| V01 | `Classical.choice` and decidability; `Set` as predicates; subtypes; `Function.Injective` and friends; `Equiv`; the class hierarchy; bundled homs and `FunLike`; coercions; `Nonempty`, `Inhabited`, `Unique`, `Subsingleton`; the junk value table (03.4); `to_additive`; the naming convention | the instance search that finds `Field ℚ`; one statement in its four forms (`Set`, subtype, `Finset`, `Fintype`) |
| V02 | Peano arithmetic in `Nat`; induction principles; `Nat.gcd`, Bézout, the fundamental theorem of arithmetic (`Nat.factorization`); `Int` division; `Rat` as a normalized fraction; `ZMod n` and the Chinese remainder theorem; the construction of `Real` by Cauchy sequences and its completeness; `ENNReal`, `NNReal`, `EReal` | $\gcd(240, 46)$ by `decide`; the order of $2$ in $\mathbb{Z}/101$; the least upper bound of $\{q : q^2 < 2\}$ |
| V03 | `Finset` operations; `Finset.sum` and `prod` with the Fubini, reindexing and telescoping lemmas; pigeonhole forms; `Fintype.card` of products, functions, subsets; binomial theorem; inclusion-exclusion; `Finsupp`; multisets | $\sum_{k=1}^n k^3 = (n(n+1)/2)^2$; the number of injections $[k]\to[n]$; $\sum \binom{n}{k} = 2^n$ |
| V04 | preorders, partial and linear orders; lattices, complete lattices, Boolean algebras; Knaster-Tarski; Galois connections and insertions; well-founded relations and Zorn; order isomorphisms; intervals; successor orders; `ConditionallyCompleteLattice` | the lattice of subgroups of $S_3$; the Galois connection of `Set.image` and `Set.preimage`; Zorn for maximal ideals (preview) |
| V05 | groups, subgroups, cosets, Lagrange; normal subgroups and quotients; the isomorphism theorems; actions, orbit-stabilizer, Burnside; class equation; Cauchy and Sylow; symmetric and alternating groups, sign; simplicity of $A_n$ (if in Mathlib, else a pointer); solvable and nilpotent groups; free groups and presentations; the structure of finite abelian groups; semidirect products | $S_3$ and $D_4$; Sylow subgroups of $S_4$; the number of necklaces by Burnside; $\mathbb{Z}/6 \cong \mathbb{Z}/2 \times \mathbb{Z}/3$ |
| V06 | rings, ideals (preview), units; integral domains and fields; characteristic and `CharP`; ordered rings and fields; the archimedean property; `LinearOrderedField`; star rings; algebras over a ring; continued fractions | $\mathbb{Z}[i]$; $\mathbb{Z}/p$ is a field; $\mathbb{Q}$ is archimedean and the surreal-like counterexample is not in Mathlib (note) |
| V07 | modules, submodules, quotients; linear maps; bases and dimension (`Module.rank`, `finrank`); rank-nullity; matrices and `LinearMap.toMatrix`; determinant and its multiplicativity; Cramer; eigenvalues and eigenspaces; the characteristic and minimal polynomials; Cayley-Hamilton; dual spaces; the structure theorem for finitely generated modules over a PID; Jordan-Chevalley (as in Mathlib) | rank of a $3\times 3$ matrix by computation; Cayley-Hamilton for a $2\times2$ matrix; $\mathbb{Z}^2/\langle(2,4),(6,8)\rangle$ by Smith form |
| V08 | tensor products of modules and their universal property; multilinear and alternating maps; exterior and Clifford algebras; bilinear forms, orthogonality, Sylvester's law of inertia; quadratic forms and the polar form; projective spaces | $\mathbb{R}^2 \otimes \mathbb{R}^3$; the Clifford algebra of $\mathbb{R}^{0,1}$ is $\mathbb{C}$; signature of $x^2 + y^2 - z^2$ |
| V09 | ideals, prime and maximal ideals, Krull's theorem; quotients and the correspondence; localization; Noetherian rings and Hilbert's basis theorem; Artinian rings; UFDs, PIDs, Euclidean domains; Gauss's lemma; polynomials in one and several variables, roots, division; Eisenstein; power series; Nullstellensatz | $\mathbb{Z}[\sqrt{-5}]$ is not a UFD; $x^4+1$ irreducible over $\mathbb{Q}$; $\mathbb{C}[x,y]/(xy)$ |
| V10 | integral extensions, going up; Dedekind domains and unique factorization of ideals; discrete valuation rings; valuations and valued fields; adic completion; local rings and Nakayama; Krull dimension; flat, smooth, étale and unramified maps; Kähler differentials; Witt vectors; trace and norm | the ring of integers of $\mathbb{Q}(\sqrt{-5})$ and the factorization of $(6)$; $\mathbb{Z}_p$ as $W(\mathbb{F}_p)$; $\Omega_{k[x]/k}$ |
| V11 | field extensions, degree, tower law; algebraic elements, minimal polynomials; splitting fields; normal and separable extensions; the fundamental theorem of Galois theory; finite fields; algebraic closure; primitive element theorem; perfect fields and purely inseparable extensions; Abel-Ruffini (as in Mathlib); cyclotomic fields (with V12) | the Galois group of $x^3 - 2$; $\mathbb{F}_8$; $\mathbb{Q}(\sqrt 2, \sqrt 3) = \mathbb{Q}(\sqrt 2 + \sqrt 3)$ |
| V12 | quadratic reciprocity; Legendre and Jacobi symbols; Fermat and Euler; Wilson; sums of two and four squares; Pell's equation; $p$-adic numbers and Hensel; number fields, rings of integers, the class group and its finiteness; Dirichlet's unit theorem; cyclotomic integers; arithmetic functions and Möbius inversion; Dirichlet characters and L-series; Dirichlet's theorem on primes in progressions; modular forms; FLT for $n = 3, 4$ (and regular primes, if present); transcendence of Liouville numbers | $\left(\frac{3}{101}\right)$; $x^2 - 2y^2 = 1$; $\mathbb{Z}_7$ has a square root of $2$; the class number of $\mathbb{Q}(\sqrt{-5})$ |
| V13 | topological spaces, bases, continuity; filters, `Tendsto`, `𝓝`; separation axioms; compactness, Tychonoff, Heine-Borel in metric spaces; connectedness; uniform spaces, completeness, completion; metric spaces, Baire; Urysohn and Tietze; Stone-Weierstrass (with V16); paracompactness; homotopy basics | the cofinite topology; $[0,1]$ is compact by the filter proof; $\mathbb{Q}$ is not complete and its completion is $\mathbb{R}$ |
| V14 | topological groups, rings, fields and modules; uniform structure of a topological group; infinite sums `tsum` and summability (unconditional); infinite products; completions of topological groups; Haar (pointer to V18) | $\sum 1/n^2$ is summable; the conditionally convergent $\sum (-1)^n/n$ is not summable in Mathlib's sense; $\mathbb{Q}_p$ as a topological field |
| V15 | limits of sequences and functions; the intermediate value theorem; extreme values; derivatives in one variable, Rolle, mean value, l'Hôpital; Taylor; `exp`, `log`, powers, trigonometric functions and $\pi$; the irrationality of $\pi$ and $e$; asymptotics `=O`, `=o`, `~`; Stirling | $\lim (1+1/n)^n = e$; $\pi > 3.14$ by Mathlib's bounds; $x^x$ has a minimum at $1/e$ |
| V16 | normed groups and spaces; Banach spaces; bounded linear maps; Hahn-Banach; open mapping, closed graph, Banach-Steinhaus; inner product spaces, orthogonal projection, Riesz representation; the spectral theorem for compact or finite-dimensional self-adjoint operators; spectrum and Gelfand; C*-algebras and continuous functional calculus; convexity and Krein-Milman; locally convex spaces; Stone-Weierstrass | $\ell^2$; the spectrum of a $2\times2$ matrix; a non-closed subspace of $C[0,1]$ |
| V17 | the Fréchet derivative and its rules; `ContDiff` and smoothness; the mean value inequality; the inverse and implicit function theorems; Taylor in Banach spaces; analytic functions and power series; Picard-Lindelöf; Gronwall | the derivative of $\det$ at $I$; the inverse of $(x,y)\mapsto(x+y^2, y)$; $y' = y$ |
| V18 | σ-algebras, measurable functions; outer measures and Carathéodory; Lebesgue measure; the Lebesgue integral and the Bochner integral; monotone and dominated convergence; Fatou; Fubini-Tonelli; $L^p$ spaces and completeness; Radon-Nikodym; Lebesgue differentiation; change of variables; Haar measure; the fundamental theorem of calculus | the integral of $e^{-x^2}$ by Fubini; a Vitali non-measurable set (if present); $1/x$ on $(0,1]$ is not integrable |
| V19 | holomorphic functions, Cauchy integral formula; Liouville; the fundamental theorem of algebra (with V09); maximum modulus; Schwarz lemma; meromorphic functions and residues (as in Mathlib); Fourier transform, Plancherel, Poisson summation; Riemann-Lebesgue; distributions (as in Mathlib); Gamma, Beta, the Riemann zeta function, its functional equation and special values | $\zeta(2) = \pi^2/6$; $\Gamma(1/2) = \sqrt\pi$; the Fourier transform of a Gaussian |
| V20 | probability spaces, independence; random variables and laws; expectation, variance, moments; the weak and strong law of large numbers; Borel-Cantelli; conditional expectation; martingales, optional stopping, Doob's convergence; Markov kernels; the central limit theorem (if present); Gaussian, Poisson, exponential distributions; Brownian motion (as in Mathlib) | the variance of a binomial variable; the gambler's ruin by optional stopping; the strong law for coin tosses |
| V21 | dynamical systems, fixed and periodic points; ergodic maps; Birkhoff's ergodic theorem (as in Mathlib); conservative systems and Poincaré recurrence; topological entropy; circle rotation number; Shannon entropy and KL divergence (as in Mathlib) | the doubling map; the irrational rotation is ergodic; the entropy of a fair die |
| V22 | affine spaces and maps; Euclidean spaces, angles, triangles, the law of cosines; Pythagoras; inscribed angles; spheres; Ptolemy; Euler's line; convex sets, convex hull, Carathéodory, Radon, Helly | $\angle$ sum of a triangle; Ptolemy for a square; Helly in the plane |
| V23 | model spaces and charts; smooth manifolds with corners; smooth maps; tangent bundle and `mfderiv`; vector bundles; Lie groups; partitions of unity; Whitney embedding (as in Mathlib); Riemannian metrics (as in Mathlib) | the sphere $S^n$; $\mathrm{GL}_n(\mathbb{R})$ as a Lie group; the tangent bundle of $S^1$ |
| V24 | categories, functors, natural transformations; Yoneda; limits and colimits, preservation and creation; adjunctions and the adjoint functor theorems; equivalences; monoidal categories and coherence; monads; comma and over categories; Kan extensions; bicategories | the limit of a pullback in `Type`; the free-forgetful adjunction for groups; the Yoneda embedding of a poset |
| V25 | preadditive, additive and abelian categories; the five and snake lemmas; triangulated categories; localization of categories; shifts; Grothendieck topologies, sites, sheaves and sheafification; presentable and accessible categories; Galois categories and the fundamental group | the snake lemma diagram for $\mathbb{Z}$-modules; the sheaf condition on a two-set cover |
| V26 | complexes, homology, quasi-isomorphisms; homotopy; long exact sequences; projective and injective resolutions; derived functors, Ext and Tor; the derived category; group cohomology and low degrees; spectral sequences (as in Mathlib) | $\mathrm{Tor}^{\mathbb{Z}}_1(\mathbb{Z}/m, \mathbb{Z}/n)$; $H^1(G, M)$ as crossed homomorphisms mod principal ones |
| V27 | simplicial sets and objects; the nerve; Kan complexes and quasicategories; the Dold-Kan correspondence; model categories; the fundamental groupoid; covering spaces; CW complexes; singular homology (as in Mathlib); condensed sets and light condensed abelian groups | the nerve of a poset; $\pi_1(S^1) \cong \mathbb{Z}$ (if in Mathlib, else a pointer); the condensed set of a profinite set |
| V28 | the prime spectrum and the Zariski topology; locally ringed spaces; schemes, affine schemes, gluing; morphisms: finite type, proper, separated, smooth, étale (as in Mathlib); `Proj`; fibre products; elliptic curves and the group law; the function field; Weil divisors (as in Mathlib) | $\mathrm{Spec}\,\mathbb{Z}$; $\mathbb{P}^1$ by gluing; the group law on $y^2 = x^3 - x$ |
| V29 | representations of groups; characters and orthogonality (as in Mathlib); Maschke; Lie algebras, ideals, solvable and nilpotent Lie algebras; Engel; Cartan subalgebras; Killing form; root systems and their classification data; Coxeter groups | the character table of $S_3$; $\mathfrak{sl}_2$; the root system $A_2$ |
| V30 | simple graphs, degree sum, trees, connectivity, colourings; Hall's marriage theorem; Turán and Ramsey (as in Mathlib); Szemerédi regularity; Cauchy-Davenport, Plünnecke-Ruzsa; Kneser; matroids; Catalan numbers and enumeration; set families, Sperner, Kruskal-Katona | the Petersen graph; Hall on a $3\times3$ example; the Catalan numbers to $n = 10$ |
| V31 | cardinals, cardinal arithmetic, Cantor, Schröder-Bernstein; König's theorem; ordinals, ordinal arithmetic, Cantor normal form; cofinality; the ZFC model `ZFSet`; the continuum hypothesis independence (pointer, if in Mathlib) | $\aleph_0 \cdot \aleph_0 = \aleph_0$; $\omega + 1 \ne 1 + \omega$ |
| V32 | first-order languages, structures, theories; Löwenheim-Skolem; compactness; ultraproducts and Łoś; Fraïssé limits; definable sets; Turing machines, partial recursive functions, the halting problem; regular languages and DFAs; Gödel (as in Mathlib) | the theory of dense linear orders; a DFA for multiples of 3 |
| V33 | lists, vectors, trees, streams and lazy sequences; QPF and polynomial functors; the `Num` binary representation; functors, applicatives, monads; `Plausible` testing | `List.mergeSort` correctness; the stream of Fibonacci numbers |
| V34 | `simp`, `ring`, `field_simp`, `linarith`, `nlinarith`, `positivity`, `norm_num`, `omega`, `decide`, `gcongr`, `fun_prop`, `continuity`, `measurability`, `aesop`, `exact?`, `polyrith`, `grind` (core, as Mathlib uses it), `push_cast`, `norm_cast`, `lift`, `choose`, `rcases`, `obtain`, `filter_upwards`, the `@[to_additive]` and `@[to_dual]` attributes, the linters | each tactic on a worked goal; what each cannot do |

## 6.4 The Catalogue

The Catalogue is the reference part of the handbook. `mlhb catalogue` generates it from the index and the informal records (09.3). It has one volume for each main volume, `C05` for V05 and so on. Each Catalogue volume lists every declaration whose home is in the main volume, in module order, with:
- the Lean name, the kind and the attributes;
- the E1 sentence or the E0 family;
- the home section and its page in the main volume.

The PDF is in small type in two columns, at about 60 rows a page, so the whole Catalogue is about 3,000 pages for about 330k declarations. The EPUB is a list. The Catalogue has no reviewed status of its own. Its release needs the E1 checks of 14.3. It is released with each edition, so it is always as fresh as the edition.

## 6.5 Dependencies between the volumes

| Volume | Needs |
|---|---|
| V00 | none |
| V01 | V00 |
| V02, V03, V04 | V01 |
| V05 | V03, V04 |
| V06 | V05 |
| V07 | V06 |
| V08 | V07 |
| V09 | V06, V07 |
| V10 | V09 |
| V11 | V09 |
| V12 | V10, V11; V19 for the analytic chapters |
| V13 | V04 |
| V14 | V05, V13 |
| V15 | V02, V13 |
| V16 | V07, V14, V15 |
| V17 | V16 |
| V18 | V13, V15 |
| V19 | V17, V18 |
| V20 | V18 |
| V21 | V18, V20 |
| V22 | V07, V16 |
| V23 | V17, V13 |
| V24 | V05, V07, V13 (for the examples) |
| V25 | V24 |
| V26 | V24, V25 Ch. 1, V09 |
| V27 | V24, V26, V13 |
| V28 | V10, V24, V25 |
| V29 | V08, V05 |
| V30 | V03 |
| V31 | V04 |
| V32 | V01, V31 |
| V33 | V01 |
| V34 | V00; read with any volume |

```
V00 ─► V01 ─┬─► V02 ─────────────────────────────► V15 ─┬─► V16 ─► V17 ─► V19
            ├─► V03 ─► V30                           ▲  │                  ▲
            │     │                                  │  └─► V18 ─► V20 ─► V21
            └─► V04 ─┬─► V13 ─► V14 ─────────────────┘        │
                     │     └────────────────► V23 ◄── V17     └─► V19
                     ├─► V31 ─► V32
                     └─► V05 ─► V06 ─► V07 ─► V08 ─► V29
                                  └─► V09 ─► V10 ─► V12 ◄── V11 ◄── V09
                                                     V10 ─► V28 ◄── V24, V25
            V24 ─► V25 ─► V26 ─► V27
            V33 ◄── V01;  V34 ◄── V00
```

## 6.6 Reading paths

The reading paths are the product for a learner (04.7). `mlhb paths` writes them from the `requires` edges, and the site shows them at `/learn/paths/`.

| Path | For | Volumes, with the chapters to skip |
|---|---|---|
| U | an undergraduate degree, as in Mathlib's `undergrad.yaml` | V00, V01, V02, V03, V04 Ch. 1 to 4, V05, V06, V07, V09 Ch. 1 to 6, V11, V13, V15, V18 Ch. 1 to 6, V20 Ch. 1 to 5, V22 |
| A | an algebraist | U, then V08, V09, V10, V11, V12, V24, V26, V29 |
| N | number theory | U, then V10, V11, V12, V14, V19 |
| G | analysis and probability | U, then V14, V16, V17, V18, V19, V20, V21 |
| T | geometry and topology | U, then V14, V17, V23, V24, V27 |
| C | categories and algebraic geometry | V24, V25, V26, V27, V28, after A |
| L | a Lean user who wants the library fast | V00, V01, V34, then the Mathlib boxes and the reference parts of any volume |
| F | a mathematician who wants the status of an area | the volume introduction, the "What Mathlib does not yet have" chapter (03.5), the Catalogue |

## 6.7 The order of writing

1. **First the volumes that every other volume uses**: V00, V01, V34 (M1). They fix the voice and the Mathlib box.
2. **Then the undergraduate core** (path U): V02 to V07, V13, V15 (M2 to M3).
3. **Then the first graduate year**: V09 to V12, V14, V16 to V18, V20 (M4 to M5). G3 of 02.3 is reached when V00 to V12 are released.
4. **Then the rest**, in the order of the reader demand of 11.5.

The Catalogue runs ahead of the text: the informalizer fills each area before the writer starts on it (11.5), so that the writer has the E1 sentences of all the declarations of a section.
