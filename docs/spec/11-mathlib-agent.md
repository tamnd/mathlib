# 11. tamnd/mathlib-agent: `mlib`

`mlib` is one Go binary, built like `mmp` and `sing`. It:
- reads the index and the records, and computes the depths, the families, the coverage and the drift;
- ranks the work of each role and runs one role at a time;
- builds the site;
- writes the reports.

`mlib` decides nothing about mathematics. Lean decides what builds, the checks of 14 decide what passes, and people decide what is reviewed.

## 11.1 Commands

```
mlib help | version
mlib index fetch  [-commit C]                 # download the index asset of a commit (08.4)
mlib sync         -lean ../mathlib-lean        # new index vs last → records/drift/<date>.json, depth, modules (05.5)
mlib coverage     [-volume V13] [-module M]    # the numbers of 04.5 → records/coverage.json
mlib depth        show <Name> | explain <Name> # the computed depth and its reason
mlib family       match | list | show F-map-op # 09.4
mlib volumes      check | orphans              # 09.2: modules with no home, prefixes with no module
mlib plan         -volume V13                  # the planner role: a section plan → blueprint/sections/V13.yaml
mlib informal     status [-volume V13] | stale | sample -n 200   # the E1 records and their checks
mlib queue        -role writer [-n 20]         # the work queue of a role, with the reason of each rank
mlib agent run    <role> [-item ID] [-budget 5] [-dry-run]
mlib rename       -from <commit> -to <commit> [-apply]   # rewrite deprecated names in the handbook and the companion (05.4)
mlib edition      new -tag v4.X.0 | list | show v4.X.0     # 05.6
mlib report       -week 2027-W03 | -edition v4.X.0
mlib site         build -out public | check -dir public | serve -dir public
mlib check                                     # the map: volume map, families, records, books
```

The exit codes are those of the sibling tools: 0 success, 1 a failed check, 2 a usage error, 3 not written yet (with the milestone).

## 11.2 Lean access

1. **Index.** `mlib` never runs Lean to read Mathlib. It reads the index asset that the bump workflow of `tamnd/mathlib-lean` wrote. So the map, the site and the roles all see the same commit.
2. **Check a file.** For the exampler, exerciser and refresher roles, `mlib` runs `lake env lean <file>` in a fresh worktree of `tamnd/mathlib-lean`, with the JSON message output, and gives the errors back to the role.
3. **Interactive.** For a hard (L) solution, a long-lived REPL (the `repl` of leanprover-community or Pantograph) in a sandbox with no network and a read-only Mathlib.
4. **Search.** The roles get the index search of `mlib` (by name, by type head, by module) and, as a tool, Loogle on the local index (report B §4). They do not call an outside search service with project data.

## 11.3 The roles

Each role has a prompt in `prompts/<role>.md` with `role` and `version` in its front matter, a Go driver in `agent/<role>.go`, and a test with a fake model.

| Role | Input | Output | Checked by |
|---|---|---|---|
| `planner` | a volume of 06 and the modules of its prefixes | the section plan: sections, the modules of each, the E3 list from the curated lists and the module docstrings, the requires edges | a person accepts the plan |
| `informalizer` | one module: its declarations with types, docstrings and the module docstring | one E1 sentence per declaration that has no record or a stale one | the round trip and the critic (14.3); a person samples |
| `family` | the declarations with no family and depth E1, in groups by name shape | proposed family patterns and texts | a person accepts each family |
| `writer` | a section plan, the declarations with their types and docstrings, the module docstrings, the E1 records, the `reads_with` locations, the model section of 07.9 | the section text, parts 1 to 7 | `mlhb check`; the checker; a person |
| `exampler` | a drafted section | the Lean examples with anchors, in `Examples.lean` | `lake build` |
| `exerciser` | a drafted section | the exercises, the (L) statement and solution files, the solutions appendix text | `lake build`; the statement hash check of 10.4 |
| `checker` | a section, with its declarations at the edition commit | a list of faults: a claim that does not match a Lean type, a missing hypothesis, a proof gap, a wrong reference, a style fault | a person reads the list; the writer fixes |
| `refresher` | a stale section and its drift items | a minimal diff that makes the section true at the new commit | `mlhb check`; the checker; a person for a `breaking` item |
| `porter` | a failing bump of the companion | fixes to the examples and solutions | `lake build` |

The writer and the checker never use the same model in one item. The checker gets the Lean types, not the writer's view of them. The model table is in `agent.yaml` of the map, as in the sibling projects. The default: a large model for `writer`, `checker` and `planner`; a smaller model for `informalizer`, `family`, `exampler` and `porter`, with escalation to the large model after two failed tries.

## 11.4 The prompts

The writer prompt quotes:
- the rules of 07 in full;
- the model section of 07.9 and the bad draft with its faults;
- the junk value table of 03.4;
- the banned word list.

Text from Mathlib (docstrings, module docs) goes in a marked data block. The prompt says that instructions in a data block are ignored, as in the sibling projects.

## 11.5 The queue

The rank of an item is

rank = weight of the volume × (1 + readers that wait on it) × level factor / (1 + failed runs) × age factor

- The weight of a volume comes from `blueprint/milestones.yaml`: the volumes of the current milestone have weight 1, the next one 0.5, the rest 0.2.
- "Readers that wait on it" is the number of planned sections whose `requires` include the item's chapter.
- The level factor is 2 for a `stale` section of a released volume, so that releases stay true before new text is written.
- The failed runs and the age factor are those of mmp-agent.

The informalizer queue is ranked by module, in the order of the volumes, so that a volume's reference tables fill before its text is reviewed.

## 11.6 Budget

Report B §8 and 04.7 give the size. A rough cost for the first full pass, at the prices of 2026-11 [U, checked at M1 on three volumes]:

| Work | Units | Tokens per unit | Total tokens |
|---|---|---|---|
| E1 sentences | about 8,740 modules | about 40k in, 8k out | about 380M |
| Round trip on a 10% sample | about 40k declarations | about 6k | about 240M |
| Section drafts | about 4,000 sections | about 150k in, 15k out, with two revisions | about 2,000M |
| Checker | about 4,000 sections | about 120k | about 480M |
| Examples and exercises | about 4,000 sections | about 80k with Lean errors | about 320M |

The total is in the order of 3 to 4 billion tokens for the first pass, spread over the milestones of 15. The daily budget starts at 200 dollars, as in the sibling projects, and the owner changes it when the M1 measurements are in.

## 11.7 Evaluation

Before a prompt version is used at scale, it runs on a fixed evaluation set:
- 300 declarations with a reference E1 sentence written by a person (from five areas);
- 10 sections with a reference text, reviewed;
- 50 drift items with a known right fix.

The scores (round-trip pass rate, checker faults per page, refresher diffs accepted without change) are written to `records/eval/<role>-<version>.json`, and a new prompt version must not score lower than the old one.
