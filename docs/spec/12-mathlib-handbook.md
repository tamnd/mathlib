# 12. tamnd/mathlib-handbook: the books and `mlhb`

`tamnd/mathlib-handbook` holds the text of the volumes of 06 and `mlhb`, the builder. The pipeline is that of the singularity and mmp handbooks: Markdown, then pandoc with a Lua filter, then LaTeX with `tex/handbook.sty`, then Tectonic for the PDF; pandoc to EPUB 3 with MathML for the EPUB; and the same Markdown to HTML for the site. `mlhb` starts as a copy of `mhb` and adds what a book about a library needs.

## 12.1 Layout

| Path | Content |
|---|---|
| `EDITION` | the version, the Mathlib tag and commit, and the commits of `tamnd/mathlib` and `tamnd/mathlib-lean` (12.6) |
| `content/<NN-slug>/volume.yaml` | number, title, subtitle, level, the prefixes it covers (a copy of `blueprint/volumes.yaml` that `mlhb check` compares) |
| `content/<NN-slug>/<NN-chapter>/NN-<slug>.md` | the sections, with the front matter of 07.7 |
| `content/<NN-slug>/solutions/` | the solutions appendix of the volume |
| `books/` | the book records, the same as in the map |
| `filters/mlhb.lua` | the pandoc filter: boxes, statements, numbers, directives |
| `tex/handbook.sty`, `tex/lean.sty`, `tex/epub.css` | the styles |
| `mlhb/` | the builder (Python) |
| `scripts/style.py` | the ASD-STE100 checks and the banned words |
| `tests/` | the tests of the builder, with a small fixture library |

## 12.2 Commands

```
mlhb new volume V13 "General topology"
mlhb new section V13/C05 compact-metric           # front matter from blueprint/sections/V13.yaml
mlhb number --write                               # statement numbers into the sources
mlhb check [--volume V13] [--edition]             # 12.3
mlhb resolve                                       # resolve <?decl?>, <?lean?>, <?reference?> against the index and the companion
mlhb build --volume V13 --formats pdf,epub,html [--edition v4.X.0 | --edge]
mlhb catalogue --volume V13 --formats pdf,epub     # the Catalogue volume of V13 (06.4)
mlhb paths                                         # reading paths → build/paths.json (06.6)
mlhb release --volume V13                          # only if the release rule of 12.6 holds
```

## 12.3 The checks

`mlhb check` faults:
1. a bad front matter, a missing part or a wrong order of parts (07.3, 07.4);
2. a Lean name in a Mathlib box, a `<?decl?>` or an `explains` list that is not in the index of the edition;
3. a deprecated name (with the new name in the message), unless the section is `stale` and in the refresher queue;
4. a `<?lean?>` anchor that is not in the companion at the edition commit;
5. a module in `modules` whose home volume is another volume;
6. a declaration at E3 or E2 in `explains` whose home section is another section;
7. a `requires` id that does not exist, or a cycle of `requires`;
8. a `reads_with` key that is not in `books/`;
9. an en dash, an em dash, "we" and the banned words;
10. with `--edition`, a coverage number of 04.5 below the release rule for the volumes asked.

It warns about an E3 definition with fewer than two examples, an E3 theorem with no example, and a section whose `mathlib` commit is older than the last drift of its declarations.

## 12.4 The directives

| Directive | Replaced by |
|---|---|
| `<?decl Name?>` | the highlighted signature of `Name` at the edition commit, from `scripts/Signatures.lean` |
| `<?lean path#anchor?>` | the highlighted Lean text between the anchors, from `scripts/Highlight.lean` |
| `<?reference?>` | the reference table of the section (07.6) |
| `<?missing?>` | the list of the standard results of the volume that Mathlib does not have (03.5) |
| `` `Name` `` inside a Mathlib box | a link to the declaration page of the site and to the Mathlib documentation of the edition |

A directive that cannot be resolved stops the build. There is no fallback text.

## 12.5 Lean in print

The Lean blocks are highlighted from the SubVerso JSON that the companion writes (report B §6). The filter turns each token into a LaTeX macro of `tex/lean.sty` (keyword, constant, variable, sorry, comment) and into a `<span>` with a class in the EPUB and the HTML. The PDF needs no shell escape and no Pygments, since Tectonic does not allow shell escape. On the site the HTML keeps the hover data: the type of each constant and a link to its declaration page.

The fonts: the text font of the sister handbooks, and a monospace font with full Unicode coverage of the Lean symbols (`→`, `∀`, `∃`, `⟨⟩`, `ᶠ`, `𝓝`, `∑`). `mlhb fonts` checks that every character in the Lean blocks of a volume has a glyph, and the build fails if one does not. The candidate is JuliaMono [U, Q-08].

The PDF puts the Mathlib boxes in a shaded frame, so that a reader who skips them can see where they are. The EPUB uses a bordered `aside`.

## 12.6 Editions and releases

`EDITION`:

```
version 0.3.0
mathlib-tag v4.38.0
mathlib 9c1d…
mathlib-map 41ab…
mathlib-lean 77e0…
built 2027-02-03
```

- An **edition** is the whole set of books built against one Mathlib tag. It is named by that tag: "the v4.38.0 edition".
- The **version** of the handbook is semantic: a patch release fixes text, a minor release adds volumes or chapters, and a major release changes the volume plan.
- A **volume release** is a GitHub release of the repository with the tag `v<version>`, with one PDF and one EPUB per volume that passes the release rule, and the Catalogue volumes. The files are named `mathlib-handbook-<NN-slug>-<version>+mathlib-<tag>.pdf` and `.epub`.
- **The release rule of a volume**: every chapter `reviewed`; C-home, C-depth and C-lean at 100% for the volume's modules; C-fresh at least 95%; `mlhb check --edition` clean. A volume that fails the rule is built as a draft with a Draft mark on the first page and the coverage numbers on the copyright page, and attached to the release as `-draft`.
- **The edge build** is built each day against the Mathlib commit of the companion's `main`. It goes to the site only (13.4), never to a release.

The release workflow does not cache the Tectonic bundle, as in the sibling repositories, so that the books of a release do not come from a cache that another run wrote. Each release has the SHA-256 sums of its files and a build provenance attestation.

## 12.7 The front and back matter of each volume

- The copyright page gives the edition, the Mathlib commit, the coverage numbers of the volume and the date, and says: "The Lean statements in this volume are those of Mathlib at the commit above. Later versions of Mathlib may differ. The site gives the current text."
- The introduction gives the prerequisites (the `requires` of the chapters) and the reading paths through the volume.
- Each chapter ends with its notes and history and a list of the books it reads with.
- The back matter has the solutions appendix, the index of notation, the index of Lean names (each name with the page of its home section), and the general index.

## 12.8 Licence

The text is CC BY 4.0. The quoted Mathlib signatures and docstrings come from Mathlib under Apache-2.0. Report B §7 discusses the terms: the copyright page of each volume names Mathlib, its licence and the commit, and the repository has a `NOTICE` file with the Mathlib licence notice. Q-09 asks the Mathlib maintainers whether they want a different form of attribution.
