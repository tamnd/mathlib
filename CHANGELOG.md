# Changelog

Each release has a section. The newest release is first.

## Unreleased

### Added

- The workflow index. It moves here from tamnd/mathlib-lean. Each day at 05:40 UTC it checks out mathlib-lean, writes the index of Mathlib at the commit of its `lake-manifest.json` and uploads it to the release `index` of this repository with `GITHUB_TOKEN`. It keeps the newest 30 indexes.

## v0.0.1 - 2026-11-26

### Added

- The spec of the project in `docs/spec/`, with the research reports A and B.
- The milestones M0 to M9 in `blueprint/milestones.yaml`.
- The style check `scripts/style.py` and the workflows lint and scorecard.
- The volume map `blueprint/volumes.yaml` of spec 06.2. It gives each module of `Mathlib/` a home volume.
- The Worker of https://mathlib.tamnd.com in `wrangler.jsonc`, and the deploy workflow. The workflow builds the site each day at 07:30 UTC and at each push to main.
- The release `index`, with the first index of Mathlib at commit `4472534b60`.
- The release script `scripts/release.sh`. It releases one version of the four repositories in sync.
