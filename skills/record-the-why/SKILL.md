---
name: record-the-why
description: "Wear this when writing a comment, a commit message, a changelog entry, a README section or a note about work that happened. Reads the core write-for-people-base first. Decides which of those a given sentence belongs in, since they are not interchangeable. Use whenever you are about to explain something in writing near code."
---

# Record the why

**First, read the core `write-for-people-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all writing for people shares: know the reader, drafting is the agent's and sending is the person's, what is true (never claim more, never invent, about the person only what they said), who each fact is for, the habits to leave out (em dashes included), and the writer's voice. Do not wear `write-for-people-base` beside this skill; read its file. What follows is this skill's own.

Five places explain things, and **a sentence in the wrong one is worse than no sentence**, because it will be read as a statement about the current code.

| The question | Where it is answered |
|---|---|
| Why does this line exist, why not the obvious alternative | the comment |
| Why was this change made, what did it replace | the commit message |
| What changed that a user of this thing would notice | the changelog |
| What it does and how to run it | the README |
| The story: the incident, the measurement, the decision | a decision record or note kept outside the code |

## A comment describes the code in front of it, now

**One sentence, two at the outside.** No dates, no author names, no ticket numbers, no *changed from X to Y*, no *previously this used A but that broke*, no paragraph recounting the incident that produced the line. A function or property docblock is a comment and this binds it too.

**The reason is that a comment has no diff and no timestamp, and git has both.** A commit message is attached to its change forever and cannot desynchronise from it. A comment describing that change is a copy of the diff in the one place nothing will ever check it. It survives the refactor that makes it false, it is duplicated when the function is split, and the next person reads it as a statement about the *current* code.

**The test is whether it stays true after the next refactor.** A constraint, a reason, a non-obvious consequence, a warning about a trap: those stay true.

**A live constraint that came out of a past failure is not history and it stays. Write the constraint, not the anecdote.** *"Grade the swap rate, not occupancy: on a small swap file against a large amount of RAM, 99% full is the resting state"* is a comment. *"This fired constantly, so it was changed from occupancy to rate"* is a changelog entry that wandered into the source.

**The tell is a blank `*` line in a docblock.** A second paragraph means the first sentence was not the point, or the point is buried under its own reasoning.

**Annotations are not prose and always stay**: `@param`, `@return`, `@see`, `@var`, `phpcs:disable`, `@SuppressWarnings`, `eslint-disable`. Cutting one is a broken build, not a tidier file.

**A standalone script is the whole-file exception, and it is about verbosity only.** A tool installed on its own has no README beside it: no directory to put one in, no package page, and the person reaching for it is at a prompt. So its comments *are* its documentation: the header block that `-h` reprints, plus as much inline instruction as the next operator needs. **Write those generously.** It is still shippable in every other sense: the contracts, the five questions and its gate all bind it exactly as before. It gets to be verbose, not unverified.

## A commit message describes the software, not the process

Short: two to seven body lines. What the change does and who it affects. **Never how it was produced**, never the session, never the tooling that helped.

**Nothing carries attribution to the tool that helped.** Not a commit trailer, not a pull request body, not an issue, a review comment or a release note, in any repository.

**And nothing personal ever reaches a commit message.** No figure, no name, no date, no balance, no quotation from a real person's life. A repository exists to be published and a commit outlives the file it touched. If a real number would make the message better, the message is written without it.

**A pull request or issue body is a message, not a commit message.** What changed, why, what was tested, the known limits. `write-to-a-person` decides how it reads; the attribution and personal-data rules above bind it all the same.

**What a README, an API reference or a guide contains** is `write-the-docs`'s question; this skill only decides that the sentence belongs there.

## Where the story goes

A changelog entry says what a user of the thing would notice, and **writing it is part of the work** rather than a follow-up. A README says what it does and how to run it, for someone who has never seen it.

**The narrative goes in a record kept outside the published repository**: what was tried, what was measured, what was decided and why. That is where the full account belongs.

## What a gate already refuses

Where a repository's gate fails a docblock with a second prose paragraph, a run of line comments, or a `TODO`, `FIXME`, `HACK` or `XXX` left in a comment, **those are shape, and this skill is about whether the sentence is in the right place**, which no pattern decides.
