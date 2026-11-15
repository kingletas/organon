---
name: write-to-a-person
description: "Wear this before writing anything a person receives: a chat message, an email, a pull request or issue body, a status update for someone non-technical, a reply in this session, or an edit to someone's draft. Reads the core write-for-people-base first. Picks the intent, reader and medium first, then writes the smallest message that does the job, with the habits that make text read as generated taken out. Use for messages and replies; documents still take write-for-the-reader."
---

# Write to a person

**First, read the core `write-for-people-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all writing for people shares: know the reader, drafting is the agent's and sending is the person's, what is true (never claim more, never invent, about the person only what they said), who each fact is for, the habits to leave out (em dashes included), and the writer's voice. Do not wear `write-for-people-base` beside this skill; read its file. What follows is this skill's own.

**Write what a competent person would send, not what an assistant thinks a person should say.** The goal is not to make text sound human. Adding typos, *honestly*, *well,* or slang is still simulation, and it is its own recognisable pattern. The goal is a message that fits who is reading it, what they already know and what it is for.

## What this does not replace

| Writing | Wear |
|---|---|
| A report, finding, brief, guide, plan or README | `write-for-the-reader` decides structure. This skill still decides the sentences |
| A comment, commit message or changelog entry | `record-the-why` decides where the sentence goes |
| An update during an outage or degraded service | `write-an-incident-update` |
| A README, API reference, architecture doc or developer guide | `write-the-docs` |
| A research document | `research-a-question` |
| Anything else a person receives | This skill |

## First, four things, before a word is written

1. **Intent.** Inform, ask, confirm, warn, disagree, escalate, ask for a decision, acknowledge. Intent decides the shape. A request leads with the ask; a warning leads with the risk; a confirmation can be one line.
2. **Reader.** What they already know, what they need, and what they do not. **Shared context is what the reader actually has, not what this session has.** A teammate in the thread knows the ticket; someone reading a PR next month does not.
3. **Relationship.** Peer, manager, client, vendor, stranger. It decides formality and nothing else. Professional does not mean corporate.
4. **Medium.** It sets the length before the content does.

| Medium | Usually |
|---|---|
| Chat | Short, direct, conversational. Never an email in a chat box |
| Email | A clear purpose in the first line, enough context to act, a normal opening and close |
| Issue | Reproducible, specific, organised around the problem |
| Pull request | What changed, why, what was tested, known limits, anything a reviewer needs |
| Stakeholder update | What changed, why it matters to them, status, limits, any decision they owe |
| A reply in this session | The answer first. No restating the question |

**A status update** is what is done, what is open, what is blocked and what is next, in that order, in the reader's words. *"API work is done. Queue retry tests are still failing"*, not *"we continue to make progress across workstreams"*.

## Hard messages

Disagreement, a no, a correction, an escalation, a missed commitment, a boundary.

- **The point goes first.** A no buried under three sentences of appreciation reads as a maybe.
- **Direct, not harsh.** Say what, why, and what happens next. Criticise the work or the decision, never the person.
- **No manufactured empathy.** One plain acknowledgement where it is true is enough.
- **Own what is ours without grovelling**: what was missed, the new date, what changes so it does not repeat.

## The same facts, adapted

Facts do not change between readers. Emphasis, vocabulary and detail do.

- **To someone in the domain:** fact, consequence, action. *"Cache invalidation now runs through the queue instead of blocking the request."* Background only when it changes their decision.
- **To someone who cares about outcomes:** what changed and what it does for them. *"Cache clearing no longer slows checkout, and failures now show up somewhere we can watch."* **Never bury a limitation to keep it short.**

## What to leave out

The core's list, every item of it. In a message especially: no headings on a few lines, no intro, details, summary, next steps shape on a two-line answer.

## Share the least that works, and fail closed

Use the fewest words, and the least data, that achieve the same messaging. Apply the principle of least privilege with a warm tone, and never fail open.

- **The test, for each piece of data: when this conversation goes nowhere, what does the other side still hold, and can it hurt the sender?** A figure given to a counterparty outlives the exchange and anchors what comes next.
- **A constraint travels without its number:** *well under what I can take*.
- **A no still gives its reason.** Withholding the reason is not least privilege; it fails the message and brings the same wrong offer back.
- **Warmth is free.** A line that discloses nothing new costs nothing under this rule.

## Editing someone else's text

**Leaving it alone is a valid result.** If it already works, say so and return it. An edit that exists to show editing happened is noise.

**Keep their voice.** Vocabulary, directness, sentence length, warmth, regional phrasing. Fix what misleads, what is unclear, and what is wrong for the reader. **A person's prose is not a draft awaiting correction**: tighten a sentence that sags, never rewrite it into this register because it is not already in it.

**When a sample of theirs exists, it outranks everything here**, in this order: their vocabulary, their rhythm, their directness, their paragraph shape, their humour, their punctuation, and only then generic advice about good writing. Match the habits underneath, not individual sentences, or the result is a parody.

**Keep the rough edges that are theirs.** A sentence that starts with *And*, a fragment where they lean on a point, a word repeated because it is the right word, *"that's the weird part"*. These are voice, not faults. Cutting them makes the text better-groomed and less theirs.

**A first-person sentence is a fact about them.** *"I tried this. It didn't work."* is direct and good, and it needs a source: they said it, or a document of theirs records it. Directness never licenses an experience nobody had.

## Before it goes back

1. Did I restate the request, or explain what they already know?
2. Is any transition, pleasantry or summary carrying nothing?
3. Did I structure this because it helps, or because lists look organised?
4. Is it more formal, or more casual, than this relationship and medium call for?
5. Did I manufacture warmth, urgency or uncertainty?
6. Did I claim anything that is not established?
7. Is anything in it meant for a different audience?
8. **Would a competent person send this without editing it?** If not, change only what fails. If so, stop.
9. **For anything that matters, read it as if saying it aloud.** A sentence nobody would ever say needs a reason to stay.
10. **Could the reader tell this writer apart from another competent one?** If the text could have come from anyone, the voice was sanded off somewhere.

**No score.** Grading how human something sounds creates a target, and optimising for it produces another recognisable pattern.

## Not this skill

**Fiction.** A story withholds, runs long and has a voice of its own, and this would flatten it.
