# Changelog

Each release has a section. The newest release is first.

## Unreleased

## v0.6.5 - 2026-11-27

## v0.6.4 - 2026-11-27

## v0.6.3 - 2026-11-27

## v0.6.2 - 2026-11-27

## v0.6.1 - 2026-11-27

## v0.6.0 - 2026-11-27

## v0.5.1 - 2026-11-27

### Decided

The owner signed these recommendations of spec 16 on 2026-11-27.

- Q-14. The Lean of the companion stays Markdown and SubVerso. A Verso web edition is asked again after M5 only if readers ask for hovers that the site does not give.
- Q-22. The Catalogue keeps a PDF and an EPUB for each volume. The downloads are counted again at M6, and the Catalogue moves to the site only if its files then have fewer downloads than the volume files.
- Q-24. The volumes stay PDF and EPUB only. Print on demand for V00 to V12, at cost, opens when the first reader asks.

### Added

- `reports/m5-coverage.md` gives C-E3 for the whole library (6% of 8,225 E3 candidates) and sets again the plan for the rest: an E3 pass for each volume before its release, and C-E3 in two parts, the curated part and the docstring part.

### Changed

- `records/coverage.json` and `records/modules.json` now have C-home, C-depth and C-E3 from the front matter of the handbook at v0.5.0, and the home sections of each module.

## v0.5.0 - 2026-11-27

## v0.4.1 - 2026-11-27

### Changed

- `scripts/release.sh` accepts untracked files in the four clones, and the release commit takes only the tracked files. A patch release can now go out while a writer drafts a volume in a new folder.

## v0.4.0 - 2026-11-27

### Decided

The owner signed this recommendation of spec 16 on 2026-11-27.

- Q-16. Offer the reviewed E1 sentences of the declarations with no docstring to Mathlib, one area at a time, after M3 and only if the maintainers want it. The offer goes to the docstring work of the Mathlib Initiative (01.3). The project opens no bulk pull request.

### Added

- The file `blueprint/paths.yaml` gives the reading paths of spec 06.6: the paths U, A, N, G, T, C, L and F, with the volumes and the chapters of each step. The pages `/teach/` of the site read this file.
- The workflow `deploy` takes a checkout of tamnd/mathlib-handbook and gives it to `mlib site build -book`, for the exercises of the pages `/teach/`.

## v0.3.0 - 2026-11-27

### Decided

The owner signed these recommendations of spec 16 on 2026-11-27.

- Q-05. One edition for each stable tag of Mathlib, about one each month, while the refresher keeps C-fresh at 95% or more within 14 days (G5). Move to one edition for every second tag if the refresher cost is more than a third of the budget for three months in a row.
- Q-20. Write new exercises by default. Adapt an exercise with credit only from a source with an open licence, such as MIL (CC BY 4.0). Ask the authors before a section follows a closed book closely. Each adapted exercise has a credit line.

### Changed

- The notes of each release of the four repositories have the part "The books", with the link to the PDF and EPUB files of the release of tamnd/mathlib-handbook.
- The workflow `index` uploads a third asset, `proofs-<date>-<commit>.jsonl.gz`, with the theorems that each proof uses (tamnd/mathlib-lean#15). Spec 09.3 says that `proofUses` keeps only the theorems.
- Spec 07.7 gives the fields `stale_since` and `stale_from` of a stale section, and spec 09 gives the file `records/stale.json` of the refresher queue items (tamnd/mathlib-agent#19).

## v0.2.0 - 2026-11-27

### Decided

The owner signed these recommendations of spec 16 on 2026-11-27.

- Q-03. The volume plan is the 35 volumes of 06.2. The plan changes only at the M1 report, from the measured pages.
- Q-04. About 4% of the declarations are at E3 and 12% at E2, as in 04.7, with the measurement of M1. If the pages are more than 1.5 times the plan, cut E2 first, then E3 outside the curated lists.
- Q-07. Keep the index assets of the last 90 days and one for each edition. An edition index stays for as long as the edition is on the site.
- Q-08. The monospace font is JuliaMono. The glyph check passed: JuliaMono Regular and Bold have a glyph for each of the 130 characters in the Lean blocks and the inline code of V00, V01 and V34. tamnd/mathlib-handbook#8 applies the decision.
- Q-10. The LeanSearch v2 corpus is an input to the informalizer for the first pass only, with attribution in `NOTICE`. New declarations get no seed. A seed sentence never becomes an E1 record.
- Q-12. `Archive` and `Counterexamples` get pointers only, from the volume of each result. The Mathlib box says that the result is not part of the library and cannot be imported.
- Q-15. Send the three kinds of fix of 10.6, as a small number of pull requests that a person has read and signs as the author. First ask on the Lean Zulip which kinds the maintainers welcome. The project sends no pull request before that answer, and it never blocks a section on a Mathlib review.
- Q-18. Graduate students review each section for `reviewed`, and an area expert signs the volume. A course that uses a draft volume is welcome when a teacher offers.
- Q-19. Both: a line on the copyright page of each volume and on `/about/`, and the roles and models of each section in `drafted_by` and `reviewed_by`.
- Q-23. The budget stays at 200 dollars a day until the M1 report. After M1, it is set from the measured cost of a section and of an E1 record.

## v0.1.1 - 2026-11-26

### Added

- `blueprint/milestones.yaml` gives the date when M0 closed and the volumes of each milestone, from the exit criteria of spec 15. The work queue of `mlib queue` uses them for the weight of a volume (spec 11.5).
- The draft section plans `blueprint/sections/<vol>.yaml` of V01 to V07, V13 and V34, made by `mlib plan` from the index of Mathlib e54979a532. Each plan has the status `proposed` until a person accepts it. V00 is a guide volume, and its plan is written by hand.
- `blueprint/families.yaml` with 20 family records of depth E0: deprecated aliases, the `map_{op}` lemmas of bundled maps, `coe_mk`, `ext` and `ext_iff`, auxiliary declarations, instances, constructors, six groups of simp lemmas, `_def` lemmas, the additive and the order dual twins, and the other simp lemmas.
- `records/families.json`, the result of `mlib family match` on Mathlib e54979a532: 129,514 of 342,368 declarations (37.8%) are in a family.

## v0.1.0 - 2026-11-26

## v0.0.2 - 2026-11-26

### Added

- The workflow index. It moves here from tamnd/mathlib-lean. Each day at 05:40 UTC it checks out mathlib-lean, writes the index of Mathlib at the commit of its `lake-manifest.json` and uploads it to the release `index` of this repository with `GITHUB_TOKEN`. It keeps the newest 30 indexes.
- The edition log `records/editions.json`, with the v4.36.0 edition in the state open. The edition is at Mathlib `fc4f59e577`, and the branch `edition/v4.36.0` of mathlib-lean is at `529587fcca`.
- The drafts of the post on the Lean Zulip and the letters to the Mathlib maintainers and to the area reviewers, in `outreach/`. Nobody sent them. The owner sends them.
- The first records of the tools: `records/coverage.json` and `records/modules.json` from `mlib coverage` at Mathlib `e54979a532`, and `records/drift/2026-11-26.json` from the first `mlib sync`, from `4472534b60` to `e54979a532`, with 19 drift items.

### Changed

- The release script writes the new pins of `EDITION` to the CHANGELOG of mathlib-handbook, so that its release notes are not empty.

## v0.0.1 - 2026-11-26

### Added

- The spec of the project in `docs/spec/`, with the research reports A and B.
- The milestones M0 to M9 in `blueprint/milestones.yaml`.
- The style check `scripts/style.py` and the workflows lint and scorecard.
- The volume map `blueprint/volumes.yaml` of spec 06.2. It gives each module of `Mathlib/` a home volume.
- The Worker of https://mathlib.tamnd.com in `wrangler.jsonc`, and the deploy workflow. The workflow builds the site each day at 07:30 UTC and at each push to main.
- The release `index`, with the first index of Mathlib at commit `4472534b60`.
- The release script `scripts/release.sh`. It releases one version of the four repositories in sync.
