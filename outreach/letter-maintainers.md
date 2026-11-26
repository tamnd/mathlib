# Draft: letter to the Mathlib maintainers

To: the Mathlib maintainers. Send it as a direct message on the Lean Zulip, or as a letter, after the post in `#mathlib4`.

Subject: The Mathlib Handbook, questions about the name, the attribution and the bump

---

Dear Mathlib maintainers,

I write about The Mathlib Handbook, a project that I posted about in `#mathlib4` on [the date of the post]. The aim of the project is a textbook of the mathematics in Mathlib. The text follows Mathlib `master`, and each stable tag gives an edition with PDF and EPUB books. The site is https://mathlib.tamnd.com.

The project does not change Mathlib, and it does not need a review from you to go on. But some decisions are yours, and I do not want to make them without you. I have these questions:

1. **The name.** The map of the library is in the repository `tamnd/mathlib`. Its README starts with "This is not a fork of Mathlib". Is the name a problem? If you prefer another name, for example `tamnd/mathlib-map`, I will change it.
2. **The attribution.** The handbook quotes the signatures and the docstrings of Mathlib, which are under the Apache 2.0 licence. My proposal is a copyright page and a `NOTICE` file in each book, and a list of the authors of the modules that each volume quotes, from the file headers. Do you want a different form?
3. **downstream-reports.** May the companion `tamnd/mathlib-lean` register in `downstream-reports`? It has examples and exercises and no new mathematics. I will keep it up to date. Until then, it uses its own bump workflow every 6 hours.
4. **Fixes to Mathlib.** When the project finds a missing simple lemma, a wrong docstring or a name that does not follow the naming rules, which kinds of small pull requests do you welcome? A person writes and reads each one. The project never sends a batch that a model made.
5. **Docstrings.** Later, the project will have reviewed sentences in words for declarations that have no docstring. Do you want them as docstrings, one area at a time?
6. **Other efforts.** Is a textbook of Mathlib planned, for example by the Mathlib Initiative? If so, I would like to join it and not compete with it.
7. **Hard areas.** Which areas have a design that a textbook reader often gets wrong? The Mathlib boxes of these areas will need the most care.

Models write the first drafts of the text. People review each section before a release, and each section records who drafted it and who reviewed it.

Thank you for your time and for Mathlib.

[the name of the owner] (https://github.com/tamnd)
