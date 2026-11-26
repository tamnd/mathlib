# Contributing

Thank you for your help. This file tells how to send a change.

## Before you start

1. Read `docs/spec/00-README.md`. It gives the plan and the decisions.
2. Find the milestone of your change. Each milestone has a tracking issue with the label `milestone`.
3. For a large change, open an issue first.

## A pull request

1. Make a branch from `main`.
2. Keep one subject in one pull request.
3. Give the pull request one `area/*` label, one `type/*` label and the milestone.
4. Run `python3 scripts/style.py`. It must print nothing.
5. Run `mlib check` when you change `blueprint/`.
6. Do not change a file in `records/` by hand. A tool writes it.

## The writing rules

The text follows ASD-STE100 technical English.

1. Write short sentences. Use one idea in one sentence.
2. Use the active voice. Do not use "we".
3. Do not use an em dash or an en dash. Use a comma, a colon or a new sentence.
4. Do not break a line in the middle of a sentence. Write each paragraph on one line.
5. Do not add a page break.
6. Write math in `$...$`.
