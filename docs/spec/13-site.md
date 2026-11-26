# 13. The site: mathlib.tamnd.com

The site has the same text as the books, and three things the books cannot have: a page for every declaration, the drift of the library over time, and the edge text that follows Mathlib `master` each day. `mlib site build` makes it from the map, the index and the HTML of `mlhb`. It is served by a Cloudflare Worker, like the sibling sites.

## 13.1 Pages

| Path | Content |
|---|---|
| `/` | what the project is, the current edition, the coverage numbers, where to start |
| `/learn/` | the volumes, the reading paths of 06.6, the HTML of each section |
| `/learn/<vol>/<chapter>/<section>/` | a section, with the Lean hover data and the folded solutions |
| `/decl/<Name>/` | a declaration page (13.3) |
| `/module/<Module>/` | a module: its docstring, its home volume and sections, its declarations by depth, its coverage |
| `/area/<vol>/` | the map of a volume: chapters, modules, coverage, status of each section |
| `/families/` | the E0 families, with their members |
| `/drift/` | the drift records: new, removed, renamed and changed declarations each day, and the sections they touched |
| `/editions/` | the editions, with their books and their numbers |
| `/coverage/` | the numbers of 04.5 by volume, over time |
| `/missing/` | the standard results that Mathlib does not have, by volume (03.5) |
| `/teach/` | for teachers: the reading paths as courses, the exercises by grade |
| `/about/` | how the text is written and checked (14), who reviewed what, the licences |

## 13.2 The levels page

`/about/levels/` reports the levels of 02.3 with the numbers that measure them: C-home and C-depth for G1 and G2, the released volumes for G3 and G4, the edition log for G5.

## 13.3 The declaration page

For each declaration of the index:
- the name, the kind, the module, the line, and a link to the Mathlib documentation and to the source at the commit;
- the signature, highlighted;
- the E1 sentence, with its check states;
- the home section, with its depth (E3 and E2 link to the numbered statement);
- the other sections that mention it;
- the family, for E0;
- the uses (what it needs) and the used-by count;
- the history: the editions in which it exists, the renames (from the deprecation records), the changes of type.

A renamed declaration's old name has a page that says "renamed to `New` on <date>" and links to it. A removed declaration's page stays, with the last edition that has it.

## 13.4 Edge and edition

The site has two builds:
- **edition** at `/`, built from the last edition;
- **edge** at `/edge/`, built each day from the companion's `main`, with a banner that gives the Mathlib commit and says that the text may be `stale` for some sections.

The declaration pages are always from the edge index, with a note of the edition state where it differs.

## 13.5 Rules

1. No status is written by hand. The section status, the coverage and the check states come from the records.
2. A section that is `stale` shows the drift items that made it stale, at the top.
3. The site sends no data of readers to outside services. Search runs in the browser on a static index (as in the sibling sites).
4. Every page gives the Mathlib commit it describes.
