# Chapter pattern

All 28 chapters share the same structure so that readers can orient themselves immediately and the course can link
to the same sections.

| Section | Anchor | Content |
|---|---|---|
| At a glance | – | guiding question, readers, prerequisites, course workshop, data status, reading time |
| Case and decision | `#sec-bNN-case` | 100–150 words: a person or role, a question, an action with consequences |
| Core reading | `#sec-bNN-core` | 800–1,200 words, marked; figure or table with unit, independent denominator and data status; key assumption; question for the workshop |
| Lab or decision exercise | `#sec-bNN-lab` / `#sec-bNN-exercise` | R from inputs to result with target values; in legal and communication chapters primary sources, role and decision |
| Counter-check | `#sec-bNN-countercheck` | change a parameter, assumption or target population; predict the direction, then check |
| Consequences for patients and operations | `#sec-bNN-consequences` | ethics, regulation, data protection and security, ordered by relevance |
| Look up and transfer | `#sec-bNN-lookup` | reviewer question, self-test with answer, annotated sources |
| Further reading | `#sec-bNN-further` | related chapters, companion books, CTTIR courses and tutorials |

## Figures

- Axes with units; the caption states the independent sample size (for example “n = 4 animals”) and the data status.
- Colours from the Okabe–Ito palette (`R/style.R`), plus line type or point shape for black-and-white print.
- Every figure has full alternative text (`fig-alt`).

## Data status

*synthetic* · *published* (with source) · *assumption* · *open*. No real patient data and no unpublished project
results.
