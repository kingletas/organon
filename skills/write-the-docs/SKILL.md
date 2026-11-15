---
name: write-the-docs
description: "Wear this before writing documentation for code: a README, an API or endpoint reference, a docblock, an architecture document, a developer guide or setup guide, or a configuration reference. Reads the core write-for-people-base first. Documents behaviour, intent, constraints and consequences from evidence, flags what cannot be established instead of guessing, and keeps each document to the job its reader came for. Use when adding or rewriting documentation in a repository."
---

# Write the docs

**First, read the core `write-for-people-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all writing for people shares: know the reader, drafting is the agent's and sending is the person's, what is true (never claim more, never invent, about the person only what they said), who each fact is for, the habits to leave out (em dashes included), and the writer's voice. Do not wear `write-for-people-base` beside this skill; read its file. What follows is this skill's own.

**Documentation exists so someone else can use, maintain, debug or safely change the software.** Document behaviour, intent, constraints and consequences. Do not narrate the code.

This sits beside `record-the-why`, which decides **where** a sentence goes: comment, commit message, changelog, README or a note outside the repository. This skill decides **what each document contains**. A public repository also keeps machine paths, internal names and real data out of the tree.

## Evidence first

**Never document behaviour that cannot be established from the code, a test, a run or a spec.** Read the code before describing it; run `--help` or the example before printing it. Where behaviour is unclear, write it as unclear and say what would settle it. An invented parameter, endpoint, default or error code is worse than a gap, because it is believed.

## Each document has one job

| Document | Its reader is trying to | Carries | Leaves out |
|---|---|---|---|
| README | Get from *what is this* to *I ran it* | What it is, requirements, the install command, basic use, configuration, testing, troubleshooting. **Only the sections this project needs** | Marketing intros, feature walls, fake badges, empty *Getting Started* sections, architecture restated |
| API reference | Call it correctly | Per endpoint or method: purpose, auth, parameters (required, optional, types), response shape, errors, side effects, established limits, one example. **The request format near the top** | Conceptual background ahead of the request, anything not in the code |
| Docblock | Use or change this unit | One sentence on what it does or guards against, then the annotations the tooling reads | A restatement of the name, a narration of the lines, history |
| Architecture | Hold a model of the system no single file gives | Components and their responsibilities, data flow, external systems, boundaries, failure domains, security boundaries, the decisions that shaped them | Every class, the codebase re-told in prose |
| Developer guide | Do a real task | Ordered steps for setup, testing, adding or extending something, debugging, deploying; the likely mistake; how to check it worked | *How much we know about this system* |
| Configuration | Set it safely | Every key a deployment can set, its default, what happens when it is absent | Keys nothing reads |

**The test for each section: what would the reader do differently for having read it?** If nothing, cut it.

## Docblocks and comments

A useful comment explains **why something unusual exists, why the simpler approach is unsafe, a business rule, an invariant, an external limit, a compatibility requirement, or a side effect nobody would guess.** It does not explain syntax, repeat the name, or say what the next line does.

*"This method gets the user ID from the user object"* narrates. *"Returns the external customer ID the fulfilment service expects"* documents.

**One sentence, two at the outside, and no history.** That rule and its gate are `record-the-why`'s. A standalone script with no README beside it is the exception: its header block is the manual and is written generously.

## Internal and external

A repository's documentation is read by someone who is not here. **Deployment mechanics, internal hosts and URLs, review notes, unreleased plans, customer details and internal test limitations stay out**, and so does the story of how the work was done. A limitation a user needs stays in, written for them: *"Not yet tested against version 2.4.8 of the platform"* rather than *"no plan or apply ran against a real account"*.

## Stop when it is enough

A small tool needs a small README. **Sufficient documentation is finished**; more sections do not make it better.

## Before it goes back

1. Is every behaviour, flag, default and example backed by something I read or ran?
2. Is anything unclear written as unclear rather than guessed?
3. Does each section serve the reader this document is for?
4. Is anything internal, historical or about the process in it?
5. After a change: does `review-docs` have anything to find?
