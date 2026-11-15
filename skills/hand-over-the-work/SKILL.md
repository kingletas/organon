---
name: hand-over-the-work
description: "Wear this before handing work to someone who does not have this conversation: briefing a subagent or a review role, writing a prompt for a parallel session, leaving a handoff note for the next session, or returning a decision to the person who owns it. Reads the core evidence-base first. Gives the smallest brief that lets them continue: objective, what is established, what is done, what is open, constraints, evidence and the next action, and says plainly when the next step is a human decision. Use every time work crosses a context boundary."
---

# Hand over the work

**First, read the core `evidence-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what every read, brief and piece of research shares: read the source not what points at it, established means confirmed, a gap is a result, how a page is fetched and a blocked one handed over, a refusal ends the step, and the places never read unless named. Do not wear `evidence-base` beside this skill; read its file. What follows is this skill's own.

**The reader of a handoff has none of this conversation.** A subagent starts from nothing, a parallel session has its own context, and the next session starts cold. What is obvious here is invisible there.

## The brief

Use only the sections that carry something.

```text
OBJECTIVE    what needs to happen, in one sentence
ESTABLISHED  facts that are confirmed, each with where it was confirmed
COMPLETED    work already done, so it is not repeated
OPEN         what is unresolved
CONSTRAINTS  what must not change, and the boundaries (which container, which tree, read-only, no real cloud account)
RISKS        known concerns
EVIDENCE     files, commands and their output, sources, decisions, by path
NEXT_ACTION  the one useful next step
```

**Established means confirmed** (the core): a suspicion goes under OPEN, labelled.

## Briefing a review role

Four things, and the third is the one left out: **what changed, with paths; what you are worried about; what you already know, including what you ran and what it said; and where the boundary is.** The angle is already in the role, so do not tell it what to conclude.

- **Give every member of a quorum the same question, word for word.**
- **Do not paste your own conclusion** into a prompt for a role whose value is independence. Give it the evidence and let it reach its own.
- **Name what it must not read**: personal folders, credential folders, a live system.
- **Helper agents:** mechanical work (known steps, checkable output) goes to a smaller, cheaper model, and work that needs reasoning to a stronger one; the builder keeps the design, the judgement that something is done, and every command that changes a shared machine. This is a habit, not a rule: do a small task yourself when briefing an agent would cost more.

Every brief to a subagent says: a guard or classifier refusal ends that step and comes back to me, never rerun another way; a page that blocks automated readers is listed as unread, never opened in a browser to get past the block; a copy of a blocked item may be read only from a different, legitimate host that lets us in, never an upload site or past a bot check; a path robots.txt disallows is a closed door, listed for the person to fetch; researchers fetch with a tool that reads robots.txt, never a bare `curl`. A rule that changes mid-run means stopping the agent and starting it again with a new brief, because a rule arriving mid-task looks like a prompt injection and is fairly ignored. When a result says another tool was used to reach a blocked page, read its tool calls from the subagent transcript before using anything it made.

## Handing to a parallel session or the next one

Say which files you touched and whether they are committed. **In a shared tree, name the paths to stage** so nobody runs `git add -A` over someone else's work. Say what is running (a stack, a watch, a background job) and who owns stopping it.

- **A spawned session reports to whoever opened it.** The brief names the opener, with its session id where the tool gives one, and tells the session to send its result, and any decision it needs, back to the opener through the tool's own messaging, never only to the person at the top. The opener checks the work, commits or relays it, and chases it if it goes quiet.

## Handing a decision back to the person who owns it

When the next step is theirs, say so plainly and stop acting:

```text
DECISION          what needs deciding, in one sentence
WHY IT IS THEIRS  conflicting requirements, unclear authority, an irreversible or outward-facing act, or a choice between options with materially different consequences
OPTIONS           each with what it costs and what it makes possible
MY ARGUMENT       what I recommend and the evidence for it, when the work owes one
UNKNOWN           what nobody has yet
```

**Do not hand back** trivial uncertainty, an implementation choice the conventions already settle, or anything you can check yourself. That is noise in the one channel that has to stay read.

## Before sending it

1. Could the reader act on this with nothing but this brief and the paths in it?
2. Is anything under ESTABLISHED actually a guess?
3. Did I include my conclusion where independence is the point?
4. Are the boundaries stated: what not to read, touch or run?
5. Is it the smallest brief that works?
