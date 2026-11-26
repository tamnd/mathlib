# Draft: post on the Lean Zulip

Channel: `#mathlib4`. Topic: "The Mathlib Handbook".

---

Hello. I started a project called The Mathlib Handbook. Its aim is a textbook of the mathematics in Mathlib, written for a student who knows the mathematics from books and wants to read and use the library. The text follows Mathlib `master`. Each stable tag gives an edition with PDF and EPUB books. The first edition is the v4.36.0 edition.

The project has four repositories:

- [tamnd/mathlib](https://github.com/tamnd/mathlib): the map of the library for the handbook. It is not a fork of Mathlib, and it has no copy of Mathlib.
- [tamnd/mathlib-lean](https://github.com/tamnd/mathlib-lean): a Lean package with the examples and exercises. It follows `master` with a bump every 6 hours.
- [tamnd/mathlib-agent](https://github.com/tamnd/mathlib-agent): the tools that read the index of Mathlib and compute the coverage and the drift.
- [tamnd/mathlib-handbook](https://github.com/tamnd/mathlib-handbook): the text of 35 volumes, from the guide volume V00 to the tactics volume V34.

The site https://mathlib.tamnd.com has one page for each module of Mathlib, with each declaration and its docstring. The index at `e54979a532` has 342,368 declarations in 8,738 modules. Each declaration gets a depth: E3 for the main results, which get a full textbook section, then E2, E1 and E0 for the rest. The site shows the coverage of each area and the drift of the library from day to day.

Models write the first drafts of the text, and people review each section before a release. Each section records who drafted it and who reviewed it. Lean checks every example and every exercise against the Mathlib commit.

I have some questions for the community:

1. The repository name `tamnd/mathlib` is for the map of the library. Is this name a problem, because people can think that it is a fork?
2. What form of attribution do you want when the handbook quotes the signatures and docstrings of Mathlib?
3. May the companion package register in `downstream-reports`? It has examples and exercises, and no new mathematics.
4. Does a plan for a textbook of Mathlib exist that this project must join instead?
5. Which areas have designs that a reader of textbooks often gets wrong?

I also look for reviewers, one or more for each volume. A reviewer can read the mathematics, the Mathlib boxes, or both. If you know an area well and want to read one chapter, please write to me here.

Thank you.

[the name of the owner]
