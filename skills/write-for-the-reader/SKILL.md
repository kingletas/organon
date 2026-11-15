---
name: write-for-the-reader
description: "Wear this before writing prose a person will read: a report, a finding, a brief, a guide, a plan, a recommendation, a README, or a long reply. Reads the core write-for-people-base first. Sets the structure a document needs and the register its sentences are written in. Use when producing any written deliverable, and when editing one."
---

# Write for the reader

**First, read the core `write-for-people-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all writing for people shares: know the reader, drafting is the agent's and sending is the person's, what is true (never claim more, never invent, about the person only what they said), who each fact is for, the habits to leave out (em dashes included), and the writer's voice. Do not wear `write-for-people-base` beside this skill; read its file. What follows is this skill's own.

Three rules govern this, and they answer different questions. **Structure** decides what the document is made of. **Plainness** decides the words. **Voice** decides the sentences. A document can pass one and fail the others, and the common failure here is exactly that: good structure, opaque language.

## First, who is reading it

This decides everything after it.

| Reader | What they need | What kills it |
|---|---|---|
| A decision-maker | What is true now, what is at stake, what they must decide | History, method, tasks, your own caveats |
| An analyst reproducing the work | The working, the method, the corrections, the uncertainty | Vagueness dressed as confidence |
| Someone doing the thing | Ordered steps, the likely mistake, how to check they got it right | Background they do not need yet |
| A specialist in the subject | The precise terms, because the terms are the content | Translation that drops a distinction |

**Plain English is the default, and the gate is *when appropriate*.** It is the default for briefs, findings, recommendations and anything sent to a person. It is not the default where the reader is the specialist and the terms are the content: a SQL protocol, a schema note, an architecture decision record. **Their summaries still get it.**

## Structure a document earns

- **Open with the verdict**, in a framing block (a callout or admonition, where the format has one), with the two or three numbers that matter, before any table.
- **Framing blocks for framing**: a summary, the method, recommendations, caveats and blockers each get their own, so the reader can see which is which. Collapse a bulky one where the format allows.
- **A table of contents** with links to the headings for anything longer than a screen.
- **Visualise magnitudes inline** with block-character bars in backticks so they render monospaced. A table cell is not monospace otherwise.
- **A `mermaid` diagram where there is a flow.** Stroke colours only, never fills, so it survives both themes.
- **Give numbers meaning**: a verdict column against a stated budget, a percentage, a cumulative total. Say when a budget is a convention rather than a measurement.
- **One sentence of interpretation before each table.** A bare stack of tables gets rejected.

## The sentences

- **Lead with what happened in the world, not what the document found.** *"You sell garden tools online, orders are down 80%, and it is two unrelated things"*, not *"the investigation identifies two decline vectors"*.
- **Say who is affected, in human terms.** *412 people have paid for orders that haven't shipped* beats *unshipped order backlog of 412*. The second is the same fact with the person removed.
- **Translate a term at first use, or do not use it.**
- **Short declarative sentences, one idea each.** Every number keeps a meaning attached.
- **End with what is not known**, in a sentence, rather than buried in a method section.
- **Every sentence does one of four things**: clarifies an idea, says what to do, warns about a likely mistake, or helps the reader check they understood. Cut the rest.
- **Read it aloud.** Rewrite whatever sounds unnatural or like a specification.

**Banned unless the subject genuinely requires them**: leverage, utilize, facilitate, stakeholders, deliverables, learning modality, knowledge acquisition.

**Plain sentences, never vague terms.** A simplification that drops a distinction is wrong, not readable. *Cancellations* meant cancelled orders in one document and cancelled units in another; collapsing them into one plain word produces a confident contradiction. **Precision in the noun, plainness in the sentence around it.**

## A brief carries the current picture and nothing else

No *previously this said*, no *reopened*, no struck-through item marked closed, no *when this was written*. **Rewrite the passage so it states only what is true now.** The correction, the superseded figure and the method go in the research document, where the reader is the analyst and the working is the point.

**A brief carries findings and decisions, never tasks.** The test is whether the reader is being asked to decide something or to do something. The second one is not theirs.

**Correcting a fact in a brief is where the analyst detail tries to ride back in.** Correct the fact; leave the nuance behind. Coverage percentages, sample composition and caveats on our own method belong in the research document, every time.

## Messages are not documents

**This skill's structure is for documents.** A chat message, an email, a PR or issue body, or a short reply takes `write-to-a-person` instead, where headings and bullets on a few lines are a defect. The core's list of generated habits (restating the request, empty openers, manufactured warmth, symmetry) applies to the sentences inside a document too.

## What this does not govern

**Fiction is exempt**, and applying these rules to it would do real damage. A story is allowed to withhold, run long, and leave a thing unexplained for two hundred pages. Only four things carry over: no filler, every sentence earns its place, nothing in a generic voice, read it aloud.

## Before you call it finished

- Could someone outside the conversation act on this?
- Does each heading say what the reader will actually do or learn?
- Is the detail concentrated where mistakes are likely?
- Does any section fail to serve the promised outcome?
- Does it sound like one person helping another?
