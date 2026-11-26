# 14. Quality: how the text is checked

In the research handbooks of the sibling projects the main risk is a Lean statement that does not mean what the paper means. Here every statement already exists in Mathlib and the kernel has checked it. The risk is in the other direction: **text that says something the library does not say**. A wrong hypothesis in a Mathlib box, an E1 sentence that drops a condition, an example whose Lean form proves something weaker than the text claims, a proof on paper with a gap. This document fixes the checks against these faults.

## 14.1 The faults

| Code | Fault | Example |
|---|---|---|
| T1 | the text states a theorem with a hypothesis that Mathlib does not need, and says that Mathlib needs it | "Mathlib proves this for $\mathbb{R}$" when it proves it for any `RCLike 𝕜` |
| T2 | the text drops a hypothesis that Mathlib needs | "every bounded sequence converges" for a monotone result |
| T3 | the text misstates a junk value or a convention | "`Real.log 0` is undefined" |
| T4 | an E1 sentence says something other than the type | the sentence of `Nat.sub_add_cancel` without `n ≤ m` |
| T5 | a proof on paper has a gap or an error | |
| T6 | an example's Lean form does not prove what the text says | the text says "for all $n$", the Lean says `n = 3` |
| T7 | a reference is wrong (book, theorem number, page) | |
| T8 | a name, a module or a family is wrong for the edition | caught by `mlhb check` |
| T9 | the text is stale: it was true at an older commit | caught by `mlib sync` (05.5) |
| T10 | style: a fault of ASD-STE100 or of the voice of 07.1 | |

T8 and T9 are mechanical. T6 is mostly mechanical. T1 to T5 and T7 need a reader.

## 14.2 The checks of a section

1. **Build.** The Lean files of the section build at the edition commit with no `sorry` and no extra axiom (10.2).
2. **Names.** `mlhb check` (12.3).
3. **Statement match.** For each Mathlib box, the checker role gets the signature from the index, not from the text, and answers: does the prose of the box state the same hypotheses and conclusion? It lists each difference. A difference that the box does not explain is a T1 or T2 fault.
4. **Example match.** For each example with a Lean form, the checker compares the claim of the text with the Lean statement (T6).
5. **Proof read.** The checker reads each E3 proof for gaps (T5). This is the weakest check, and the reason for the human review.
6. **References.** The checker compares each `reads_with` location and each cited theorem number with the book record, where the record has a table of contents. A person checks the rest at review.
7. **Style.** `scripts/style.py` and the banned words.
8. **Human review.** A person with knowledge of the area reads the section with the library open. The review form has one line for each of T1 to T7 and T10. The reviewer signs the section by adding a name to `reviewed_by`.

## 14.3 The checks of an E1 sentence

The E1 sentences are too many for a person to read all of them (04.7). Three checks run on them.

1. **Round trip.** For a random sample (10% of each module, and all E1 declarations of the curated lists), a second model that has not seen the Lean statement writes a Lean statement from the sentence and the names of the objects it uses. Lean then tries to prove `new ↔ old` or `new = old` as types, by `Iff.rfl`, `exact?`, `simp` and `aesop` with a time limit. A pass is evidence that the sentence carries the full statement. A failure goes to a person. Hard cases (statements about structures, definitions) use a weaker test: the second model states a known consequence, and Lean proves it from the declaration. The round-trip files are in `MathlibHandbook/Fidelity/` (10.1).
2. **Critic.** A model reads the sentence and the type side by side and lists each hypothesis of the type that the sentence omits, and each claim of the sentence that the type does not support. An empty list passes.
3. **Human sample.** A person reads 1% of the E1 sentences of each volume, chosen at random, before the volume is released. The fault rate of the sample is printed in the release notes. A rate above 3% stops the release and sends the volume's E1 records back to the informalizer with the faults as examples.

## 14.4 Trust in the library itself

The handbook does not check Mathlib. It relies on the Mathlib CI and the Lean kernel. Two facts are printed in Volume 0:
- Mathlib's main theorems use only the three standard axioms. The companion checks `#print axioms` on the E3 theorems of each volume at each edition, and the reference table marks any E3 theorem that uses another axiom.
- A theorem in Mathlib is proved, but its statement can still differ from the textbook statement. The Mathlib box is where the handbook says how.

## 14.5 Reviewers

- Each volume has at least one named reviewer before its first release. The letters of M0 (15) ask the Lean community and the area experts. The site lists the reviewers of each section.
- A reviewer can mark a section `reviewed` with a note "Mathlib box only", "mathematics only" or "full". A release needs "full" for every E3 section, or one reviewer of each kind.
- The owner reviews the guide volumes and the style.

## 14.6 Errors after release

Errors go to the issues of `tamnd/mathlib-handbook` with a template that asks for the section, the edition and the fault code. A confirmed fault in a released volume gets a patch release within 14 days. The release notes list the faults fixed, with their codes, so that the fault rate is public.
