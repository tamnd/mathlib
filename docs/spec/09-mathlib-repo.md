# 09. tamnd/mathlib: the map

`tamnd/mathlib` is the map of the project. It holds what people decide (the volume map, the section plan, the families, the depth overrides) and what tools record (the index summaries, the drift, the coverage, the editions). It has no Lean code and no copy of Mathlib.

## 9.1 Layout

| Path | Content | Written by |
|---|---|---|
| `README.md` | first line: "A map of Mathlib for The Mathlib Handbook. This is not a fork of Mathlib." | people |
| `docs/spec/` | this spec | people |
| `blueprint/volumes.yaml` | the volume map: Mathlib path prefixes to volumes and chapters (9.2) | people |
| `blueprint/sections/<vol>.yaml` | the section plan of each volume: sections, their modules, their E3 lists | the planner role, then people |
| `blueprint/families.yaml` | the family patterns (9.4) | people and the family role |
| `blueprint/depth.yaml` | the depth overrides that are not in a section front matter, with reasons | people |
| `blueprint/milestones.yaml` | the milestones of 15 | people |
| `informal/<vol>.jsonl` | the E1 sentences, one record per declaration (9.3) | the informalizer role, then the checks of 14.3 |
| `books/` | one record for each textbook that the handbook cites: key, author, title, edition, the sections it reads with | people |
| `records/editions.json` | the editions (05.7) | `mlib edition` |
| `records/modules.json` | one row per module at the last sync: home volume, home sections, counts by kind and depth, coverage | `mlib sync` |
| `records/depth.json` | the computed depths | `mlib sync` |
| `records/coverage.json` | the numbers of 04.5 by volume and by edition | `mlib coverage` |
| `records/drift/<date>.json` | the drift record of each sync (05.4) | `mlib sync` |
| `records/runs/<id>/` | the run records of the roles | `mlib agent run` |
| `agent/ledger.jsonl` | the spend of each run | the runner |
| `site/` | the pages of the site that are not generated | people |
| `reports/` | the weekly and edition reports | `mlib report` |

## 9.2 The volume map

```yaml
# blueprint/volumes.yaml
volumes:
  - id: V13
    title: General topology
    prefixes:
      - Mathlib/Topology/Basic
      - Mathlib/Topology/Order        # except the IntermediateValue file, below
      - Mathlib/Topology/Separation
      - Mathlib/Topology/Compactness
      # ...
    chapters:
      - { id: C01, title: Topological spaces, prefixes: [Mathlib/Topology/Basic, Mathlib/Topology/Defs] }
      # ...
exceptions:
  Mathlib/Topology/Order/IntermediateValue: V09.C03
unmapped: fault          # a module with no home is a fault of mlib check
```

A module is mapped by its longest matching prefix. `mlib check` reports:
- a module with no home (a new folder of Mathlib);
- a prefix that matches no module (a folder that Mathlib removed or renamed);
- two volumes that claim the same prefix.

## 9.3 The index and the informal records

The **index** is the output of `scripts/Index.lean` in `tamnd/mathlib-lean` (10.5). One JSON line per declaration:

| Field | Meaning |
|---|---|
| `name` | the full Lean name |
| `kind` | `def`, `theorem`, `abbrev`, `opaque`, `axiom`, `inductive`, `structure`, `class`, `instance`, `ctor` |
| `module`, `line` | the module and the declaration range |
| `type` | the pretty-printed type, with `pp.fullNames false` |
| `typeHash` | a hash of the type expression with the universe names normalized (05.4) |
| `valueHash` | for a `def`, a hash of the value; for a theorem, empty |
| `doc` | the docstring, if any |
| `attrs` | the attributes that matter to a reader: `simp`, `ext`, `instance`, `class`, `to_additive` source or target, `deprecated` with its target and date, `reducible`, `irreducible`, `norm_cast`, `continuity`, `fun_prop`, `simps` |
| `uses` | the constants that the type and, for a definition, the value use, restricted to Mathlib |
| `proofUses` | for a theorem, the theorems of Mathlib that its proof uses. It is in the separate file `proofs.jsonl`, since it is large. The other constants of a proof are not in the list: a definition in a proof is almost always also in the type |
| `axioms` | only for declarations whose axioms are not the three standard ones |

The index of the module docstrings is a second file: one record per module with the docstring and the headings of it. `mlib` reads the "Main definitions" and "Main results" lists from it (04.4).

An **informal record** is one line of `informal/<vol>.jsonl`:

```json
{"name":"Metric.isCompact_iff_isClosed_bounded",
 "typeHash":"b3e1…",
 "text":"In a proper metric space, a set is compact if and only if it is closed and bounded.",
 "by":"informalizer@claude-sonnet-5-5","run":"r-20270114-0042",
 "checks":{"roundtrip":"pass","critic":"pass","human":null},
 "since":"3f1c2e9a7b"}
```

The record names the type hash it was written for. When the hash changes, the record is stale (05.5) and goes back to the informalizer queue.

## 9.4 Family records

A family is a pattern over names and types, with a sentence that explains all its members.

```yaml
# blueprint/families.yaml
- id: F-map-op
  pattern: { name: "map_{op}", typeHead: "FunLike" }
  ops: [add, zero, mul, one, sub, neg, sum, prod, pow, nsmul, zsmul, inv, div]
  text: "A bundled map of a class that preserves {op} sends {op} to {op}."
  depth: E0
- id: F-coe-mk
  pattern: { name: "*.coe_mk", attr: simp }
  text: "The coercion to a function of a structure built with its constructor is the function given to the constructor."
  depth: E0
```

`mlib family match` assigns each declaration to at most one family and writes the count per family. A family with many members and a short text is the best use of the E0 depth. A family pattern that changes meaning between editions (a member with a different shape of type) is a check fault.

## 9.5 The dependency graph and the ranks

`mlib graph` builds the graph of `uses` (types and definition values, not proofs) over the declarations of Mathlib, and the graph of `proofUses` for theorems. It computes:
- the number of uses of each declaration outside its own module;
- a PageRank on the type graph, to rank structures and classes for E3 (04.4);
- for each E3 theorem, the E2 and E3 declarations of its proof, for the "How Mathlib proves it" part of the Mathlib box (07.3).

The ranks are written to `records/depth.json` with the reason of each computed depth, so that a person can see why a declaration got E3.
