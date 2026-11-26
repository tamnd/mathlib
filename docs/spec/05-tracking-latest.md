# 05. Tracking the latest Mathlib

The request is to base the handbook on the latest Mathlib and to keep it up to date. Mathlib does not stand still: about 800 commits a month, about 36k new lines a month, about 25 module paths gone each month, and a new Lean minor version each month (report A §1, §2, §5.5). A book that is right on the day of its release is wrong on some page within a week. This document fixes the mechanism that keeps the text true to the library, and that says which parts are not true at the moment and why.

The mechanism has four parts:
1. a companion package that follows Mathlib `master` each day, through the last commit known to build (05.3);
2. a diff of the library at each bump, in classes that the tools can act on (05.4);
3. a sync that turns the diff into `stale` marks and queue items (05.5);
4. a monthly edition at each stable Mathlib tag, which is the only thing that is printed (05.6).

## 5.1 How Mathlib releases

The facts of report A §1, as of 2026-11-26:

| Item | Value |
|---|---|
| Latest Lean stable | v4.36.0, 2026-11-16 |
| Latest Lean release candidate | v4.37.0-rc1, 2026-11-18 |
| Latest Mathlib stable tag | `v4.36.0` = `fc4f59e577` |
| Latest Mathlib RC tag | `v4.37.0-rc1` = `31ce06eaad` |
| Mathlib `master` | `b9019de30e`, toolchain v4.37.0-rc1, 263 commits after v4.36.0 |
| Mathlib `stable` branch | at `fc4f59e577` |
| Next bump branch | `bump/v4.38.0`, on `mathlib4` itself, on Lean nightly |
| Pin of the sibling projects | v4.35.0 = `56a005855e`, about 1,100 commits behind `master` |

The rules that the mechanism relies on:
1. Lean has one minor release a month. The stable release comes near the middle of the month, and the first RC of the next minor comes within about three days after it.
2. A Mathlib tag is the first `master` commit on the new toolchain. It is a snapshot of `master`, not a separate branch, and no fix goes back into it.
3. Every `master` commit and every tag has an olean cache, so `lake exe cache get` works at any of them.
4. RC tags can repeat (v4.29.0 had eight). Stable tags do not change.
5. Since November 2026 the legacy nightly-testing fork is retired. Lean adaptations come from `leanprover/downstream-lean4` into `bump/v4.X.0` on `mathlib4`. Tools that read `nightly-testing` tags must not be used (report A §1.4).

## 5.2 Two tracks: edge and edition

The project follows Mathlib on two tracks.

| Track | Follows | Cadence | Used by | Promise |
|---|---|---|---|---|
| **edge** | Mathlib `master`, at the last known good commit | daily | the companion's `main`, the map's index and drift records, the site at `/edge/` and the declaration pages | at most 7 days behind `master` (G5 of 02.3); sections that the drift touched are marked `stale` on the day |
| **edition** | a stable Mathlib tag `v4.X.0` | monthly | the companion's branch `edition/v4.X.0`, the PDF and EPUB releases, the site at `/` | every released volume is true at the tag, with C-fresh at least 95% (04.5) |

The two tracks share all the text. There is one `main` branch of the handbook, and it is always written against edge. An edition is a build of `main` at a tag, after the refresher has cleared the stale sections that the release rule needs (05.6).

The decisions behind the two tracks:
1. **The text follows `master`, not the stable tag.** The step from one stable tag to the next is about 835 commits, about 120 new modules and about 30 removed ones (report A §5.5, §7.2). A daily step is 0 to 2 breaks a week in the experience of FLT and PFR. Small steps keep each refresher item small and give the precise commit that broke a section.
2. **The print follows the stable tag, never an RC.** A stable tag is fixed and cached, and people can cite it. An RC can be followed by another RC. An edition is named by its tag: "the v4.36.0 edition".
3. **The map does not need to build.** `tamnd/mathlib` reads the index asset that the companion's bump wrote. It records the commit and the toolchain in every record, so the map, the site and the roles always see the same commit (11.2).

## 5.3 The daily bump

The bump is a workflow in `tamnd/mathlib-lean`. It moves the Mathlib dependency to the newest commit that is known to build with the companion, builds the companion, runs the extraction programs, and opens a pull request.

### The source of the commit

The preferred source is the `leanprover-community/downstream-reports` service (report A §5.2). It builds each registered downstream project against the newest Mathlib `master` twice a day. When a build fails, it bisects and records the last known good (LKG) and the first known bad (FKB) commits. The project:
1. registers `tamnd/mathlib-lean` by a pull request to `ci/inventory/downstreams.json` of downstream-reports, after a person on the project agrees to keep the package up to date [Q-11];
2. copies the workflow of PFR: the composite action `track-incompatibility` with `open-pr: true`, on a cron every 6 hours. It moves to the LKG, and while an FKB regression is active it keeps one issue open with the FKB commit.

The fallback, if the project does not register or until the registration is accepted, is `leanprover-community/mathlib-update-action` with `intermediate_releases: latest`, run daily. It moves to the newest tag and then to `master`, builds, and opens a pull request or an issue. It does not bisect, so a failure gives a range of commits, not one.

### The steps

```
on: schedule: "17 */6 * * *"           # every 6 hours; the 17 avoids the top of the hour
1. track-incompatibility (or mathlib-update-action) → new lake-manifest.json, lean-toolchain
2. lake exe cache get
3. lake build MathlibHandbook             # examples, exercises, solutions, fidelity files
4. if the build fails: run the porter role (11.3) on the errors; stop here
5. lake env lean --run scripts/Index.lean <commit> <date>  → index.jsonl, modules.jsonl, proofuses.jsonl
6. lake env lean --run scripts/Highlight.lean              → the SubVerso JSON of the anchors
7. upload the index asset to tamnd/mathlib as release index-<date>-<commit> (08.4)
8. mlib sync -lean . -from <last commit> -to <commit>      → the drift summary (05.4, 05.5)
9. open a pull request "bump Mathlib to <commit>" with the manifest and the drift summary
```

- The toolchain comes from Mathlib's `lean-toolchain` at the commit, through `lake update`. Nobody writes it by hand (report A §7.1).
- Steps 5 and 6 run only once a day, on the first bump after 00:00 UTC, since the index program takes 20 to 60 minutes on a large machine (10.5). The other bumps check only that the companion still builds.
- The pull request merges by itself when the build is green and the drift has no `breaking` item (05.4). Otherwise it waits for a person, and the refresher and porter roles work on it.
- A failure of the build that the porter cannot fix in two runs opens an issue with the FKB commit and the title and body of the Mathlib pull request at that commit. This is the record that FLT keeps by hand (report A §5.3).

### The pins

| Ref of `tamnd/mathlib-lean` | Mathlib |
|---|---|
| `main` | the LKG of `master`, moved by the bump |
| `edition/v4.X.0` | the tag `v4.X.0`, made by the edition workflow (05.6), never moved after the edition is released, except for a patch tag of Lean (`v4.X.1`) |

At M0 the edge starts at the LKG of `master` on that day (on v4.37.0-rc1), and the first edition is the v4.36.0 edition, at `fc4f59e577`. The project does not start at the v4.35.0 pin of the sibling projects (10.7).

### The limit of falling behind

Mathlib deletes deprecated aliases and `deprecated_module` shims after about 6 months. The workflow `remove_deprecated_decls.yml` runs on the 15th of each month and deletes what was deprecated more than 6 months before (report A §5.4). After that, a rename is a hard break with no hint of the new name. So:
1. **The edge must never fall more than 5 months behind `master`.** If the bump fails for 30 days in a row, `mlib report` raises an alert on the weekly report and on the site's `/drift/` page, and the porter work goes to the top of the queue.
2. The harvest of 05.4 keeps every alias it has seen, with the date, in `records/renames.json` of the map, so the project can still rewrite an old name after Mathlib has deleted the alias.

## 5.4 The drift

`mlib sync` compares the index of the new commit with the index of the last sync. It writes `records/drift/<date>.json` to the map. The drift is a list of items. Each item has a class, the declarations or modules it is about, the sections that use them, and a severity.

### The classes

| Class | How it is found | Severity |
|---|---|---|
| `added` | a name in the new index and not in the old one | `info`; the declaration gets a computed depth and a home (05.5) |
| `removed` | a name in the old index, not in the new one, and not the source of an alias | `breaking` if a section names it, else `info` |
| `renamed` | the old name is now a `@[deprecated]` alias whose target is the new name, or the old name is gone and a new name has the same `typeHash` in the same or a nearby module | `rename`; fixed by `mlib rename` (below) |
| `deprecated` | the declaration now has `@[deprecated]` with no new name | `breaking` if a section names it |
| `type-changed` | same name, different `typeHash` | `breaking` if the declaration is at E3 or E2, or a Mathlib box quotes it; `minor` otherwise |
| `value-changed` | same name and type, different `valueHash` for a `def` | `minor`; a section that explains the definition by its formula is marked for a check |
| `attr-changed` | a reader-facing attribute (09.3) is added or removed, such as `simp` or `instance` | `minor`; the Mathlib box may say "this is a `simp` lemma" |
| `doc-changed` | the docstring changed | `info`; the informalizer reads it at the next E1 refresh |
| `moved` | same name and `typeHash`, different module | `move`; the section front matter and the `modules` list are fixed by `mlib rename`, the text is not touched |
| `module-renamed` | a module path is gone and a `deprecated_module` shim names its new locations | `move` |
| `module-removed` | a module path is gone with no shim | `breaking` if a section lists the module |
| `visibility` | a declaration is no longer visible from `import Mathlib`, or an `import` of the companion no longer gives it, after a `public import` was made private (report A §6.1) | caught by the build; `breaking` |
| `silent` | a change that the index cannot classify: a structure field removed with no alias, an instance that changes which lemma `simp` uses | caught by the build failure and the FKB commit; `breaking` |
| `curated` | an entry of `overview.yaml`, `undergrad.yaml`, `100.yaml` or `1000.yaml` is added, removed, or points to another name; a `proof_wanted` in `Wanted/` is added or gone | `info`; the planner re-reads the E3 list of the volume (04.4) |

A change to the proof of a theorem is not drift. The handbook proves its E3 theorems on paper, and its Lean blocks quote statements, not proofs (07.5). The `proofUses` record changes, and the "proof in Mathlib" line of an E3 Mathlib box is checked at the next edition only.

### The type hash

The `typeHash` of 09.3 is the hash of the type expression after the universe parameter names are replaced by their positions and the metadata is removed (10.5). Two facts follow:
1. A rename of a bound variable or a universe does not change the hash, so it is not drift.
2. A change of notation or of the pretty printer does not change the hash, so a new `pp` option of Lean does not mark the whole library as changed. The printed signature in the book is made again at each build from the index, so it is always that of the commit.

A change of the name of a constant inside the type changes the hash. When the only change is that a used constant was renamed, `mlib sync` sees the rename of the used constant first, rewrites the old type with the rename table, and compares again. A match gives the class `renamed-dependency`, severity `minor`, and no stale mark.

### The harvest of renames

`mlib sync` builds the rename table from three sources, in this order:
1. the `deprecated` attribute in the index: the target and the `since` date of each alias (10.5);
2. the `deprecated_module` shims: the old module and its replacement imports. The index program reads them from the module data. The `hopscotch` tool of the community gives the same table, and `mlib` can run `hopscotch fix apply` on the companion's imports (report A §5.2);
3. the `typeHash` match of the `renamed` class, for a rename with no alias. This is a proposal only, and a person accepts it in the bump pull request.

Each entry of `records/renames.json` has the old name, the new name, the kind (`decl` or `module`), the commit, the `since` date, and the expected deletion date (the `since` date plus 6 months, at the next 15th).

### `mlib rename`

```
mlib rename -from <commit> -to <commit>           # list the renames that touch the handbook and the companion
mlib rename -from <commit> -to <commit> -apply    # rewrite them and open pull requests
```

`-apply` rewrites:
- the Lean names in the Mathlib boxes, in `<?decl?>` directives, in inline code that is a Lean name, and in the `explains` lists of the front matter;
- the `modules` lists of the front matter;
- the imports and the names in `MathlibHandbook/**/*.lean`;
- the `name` field of the informal records, keeping the old name in a `formerly` list.

It does not touch the prose. A rename that changes the meaning of a sentence, for example when `Nat.sub_le` becomes `Nat.sub_le_self`, is a type change too, and the refresher handles it. The rewrite uses the warning format "`old` has been deprecated … Use `new` instead" as Mathlib's own `scripts/fix_deprecations.py` does, so that the rewrite of the companion and the rewrite of the text agree (report A §5.4).

### The changes Mathlib is making now

Report A §6 names the large changes of 2025 and 2026. Each has a rule in the mechanism.

| Change | Rule |
|---|---|
| The module system (#31786, `requiresModuleSystem` since #41950) | the companion is written as `module` files with `public import` of the exact Mathlib modules it needs (10.2); a demotion of a `public import` is a `visibility` item |
| The `Basic/` folder: about 1,000 files may move from `Data/` and `Logic/` (#39703) | sections are keyed by declaration names and concept ids, not by file paths; the volume map (09.2) lists `Basic/` prefixes from the start; a move is a `move` item and changes no text |
| File splits by the 1,500-line linter | the same: a `move` item |
| `grind` replaces long proofs | not drift (proofs are not quoted); the V34 chapter on `grind` follows the Lean release notes of each edition |
| `@[to_dual]` next to `@[to_additive]` | the family role adds a family for each pair, as for `to_additive` (09.4) |
| Verso docstrings in 1,352 files (#45031) | the index program reads both Markdown and Verso docstrings and writes Markdown (10.5) |
| The `Wanted/` folder for `proof_wanted` (#42284) | read at each sync as part of the `curated` class; it feeds the `<?missing?>` lists (03.5) |
| `irreducible_def` deprecated (#46365) | the V01 chapter on definitions explains the current form at each edition |

### Concept ids

A section is about mathematics, and its names can change. So each E3 item of a section plan (09.2) has a concept id that does not depend on the Lean name:
1. the key of the entry in `docs/overview.yaml` or `docs/undergrad.yaml`, if there is one;
2. else the Wikidata Q-id of the entry in `docs/1000.yaml`, if there is one;
3. else an id of the project, `mh:<volume>.<slug>`.

When an E3 name is removed with no alias, the planner role looks for the new declaration of the same concept: first in the curated yaml files at the new commit, whose names Mathlib's CI checks (`scripts/yaml_check.py`), then by `typeHash`, then by search. A person accepts the match.

## 5.5 The sync and the stale marks

After the drift record, `mlib sync`:
1. computes the depth of each new declaration (04.3) and gives it a home: the home volume from the volume map, the home section from the section plan, or the queue of the planner if no section takes its module;
2. marks an informal record stale when its `typeHash` is not the one of the declaration, and puts the declaration in the informalizer queue (09.3);
3. marks a section `stale` (07.8) when the drift has a `breaking` or `minor` item about a declaration of its `explains` list or a name in its text, or a module of its `modules` list. A `rename` or `move` item does not mark the section stale; `mlib rename -apply` fixes it;
4. writes the drift items of each stale section into its refresher queue item, with the commit at which each happened;
5. recomputes the coverage numbers of 04.5 and writes them to `records/coverage.json`;
6. opens a pull request to `tamnd/mathlib-handbook` that sets the `stale` status and the `stale_since` commit in the front matter of the affected sections.

The refresher role (11.3) takes a stale section and its drift items, and writes the smallest change that makes the section true at the new commit. A `breaking` item needs a person to accept the change. When the section is fixed, its `mathlib` commit in the front matter moves to the new commit and its status goes back to what it was before (`checked` or `reviewed`). A change by the refresher to an E3 proof or statement sets a `reviewed` section back to `checked`, and the section needs a new review.

The level factor of the queue (11.5) puts the stale sections of released volumes first. So a release stays true before new text is written.

## 5.6 The edition

An edition is a build of the whole handbook at one stable Mathlib tag.

### The workflow

The edition workflow of `tamnd/mathlib-handbook` starts when a new tag `v4.X.0` appears on `mathlib4` (a daily check of the tags API, with the filter `^v4\.\d+\.\d+$`, report A §7.4):

```
day 0      the tag v4.X.0 appears
           mlib edition new -tag v4.X.0
             → branch edition/v4.X.0 of tamnd/mathlib-lean at the tag; lake build
             → index-<date>-<tag commit> asset; mlib sync against the last edge sync
             → records/editions.json: a new edition in state "open"
day 0 to 10  the refresher clears the stale sections of the volumes to release
           the porter fixes the companion on the edition branch if needed
day 10     mlhb check --edition for each volume
           mlhb build --edition v4.X.0 for every volume
           the volumes that pass the release rule (12.6) are released
           the others are attached as -draft
           the site's edition build moves to v4.X.0
day ≤ 14   the edition state goes to "released"; the edition report (mlib report -edition v4.X.0)
```

- The target is 10 days from the tag. The limit is 14 days, which is G5 of 02.3.
- An edition that misses 14 days is released with the volumes that pass, and the edition log records the miss.
- If a new tag appears before the last edition is released, the old edition closes as "skipped" and the new one opens. Lean has had gaps of two months between minors (v4.29 to v4.30), and the mechanism does not depend on a monthly beat.
- A Lean patch tag (`v4.X.1`) does not open a new edition. The edition branch moves to the patch tag only if the companion does not build at the old tag with the toolchain that people can install.

### The name and the version

The edition is named by the tag. The handbook version is semantic and is separate (12.6). A file name has both: `mathlib-handbook-05-groups-0.3.0+mathlib-v4.36.0.pdf`. The copyright page gives the edition, the Mathlib commit and the date (12.7).

### What a reader gets

| Reader wants | Use |
|---|---|
| a book that matches a Mathlib they can install | the PDF or EPUB of the edition of their Mathlib tag, and the branch `edition/v4.X.0` of the companion |
| the current text | the site at `/edge/` |
| to know what changed | the edition report and the `/drift/` page: the renames, the new results, the sections rewritten |
| an old edition | every edition stays on the GitHub releases and at `/editions/v4.X.0/` on the site |

## 5.7 The edition log

`records/editions.json` in the map has one record per edition:

```json
{"edition":"v4.36.0",
 "mathlib":"fc4f59e577feb1a4956671bc04ac18aaaf8cd842",
 "lean":"v4.36.0",
 "tag_date":"2026-11-16",
 "opened":"2026-11-27", "released":"2026-12-07",
 "days_from_tag":21,
 "handbook_version":"0.1.0",
 "mathlib_map":"41ab…", "mathlib_lean":"77e0…",
 "volumes":{"V00":"released","V01":"draft","V34":"draft"},
 "coverage":{"C-home":0.91,"C-depth":0.34,"C-fresh":1.0,"C-review":0.02},
 "drift_since_last":{"added":0,"removed":0,"renamed":0,"type-changed":0},
 "state":"released",
 "notes":"first edition; started 11 days after the tag"}
```

The numbers in the example are placeholders. The log is the evidence for G5: the site's `/editions/` page shows, for each edition, the days from the tag and C-fresh, and `/about/levels/` counts the months in a row that meet G5.

## 5.8 What can go wrong

| Risk | Sign | Response |
|---|---|---|
| The bump fails for days | the bump issue stays open; the edge falls behind | the porter first; after 7 days a person; after 30 days the alert of 05.3 |
| Too many sections go stale at once (a large refactor) | more than 10% of the E3 sections of a volume are stale in one sync | the volume is left out of the next edition as `-draft`; the refresher works on it as one item per chapter; see 02.6 |
| A rename with no alias in a section of a released volume | a `removed` item on an E3 name | the concept id of 05.4; the patch release of 14.6 if the edition is out |
| The downstream-reports service changes or stops | the action fails, not the build | the fallback to `mathlib-update-action`; then a plain `lake update` with a bisect by `hopscotch` |
| Mathlib changes its tag or deprecation rules | a tag with a new form, or deprecations deleted sooner | the tag filter and the horizon are settings in `agent.yaml`, not constants in code; the weekly report shows the oldest alias still in use |
| The index program runs out of memory | step 5 of the bump fails | the bump still merges if the build passes; the sync waits for the next run; the doc-gen4 data (08.4) gives a reduced drift (names and modules, no hashes) for that day |
