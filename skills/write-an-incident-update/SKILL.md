---
name: write-an-incident-update
description: "Wear this before writing an update about an outage, degraded service, a failed deploy or any live operational problem: a status message, a chat post to the team, a note to a client or leadership, or a resolution summary. Reads the core write-for-people-base first. Separates what is confirmed from what is being investigated, and refuses speculation, drama, false reassurance and an unevidenced time to fix. Use during and right after an incident."
---

# Write an incident update

**First, read the core `write-for-people-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all writing for people shares: know the reader, drafting is the agent's and sending is the person's, what is true (never claim more, never invent, about the person only what they said), who each fact is for, the habits to leave out (em dashes included), and the writer's voice. Do not wear `write-for-people-base` beside this skill; read its file. What follows is this skill's own.

**People read an incident update to decide what to do next.** Customers decide whether to wait. Support decides what to tell them. Leadership decides whether to escalate. Every sentence either helps one of those decisions or is in the way.

This sits on top of `write-to-a-person`, which still decides the reader, the medium and the register.

**An incident update is handed over, never posted** (the core: sending is the person's).

## The shape, using only the parts that have something in them

```text
What happened.
What people are seeing.
What we know.
What we do not know yet.
What we are doing.
When the next update comes.
```

A first update may be three of these. **An empty section is left out, never filled with a placeholder sentence.**

## The rules

- **Confirmed and suspected never share a sentence.** *"Checkout is failing for card payments. We think it started with this morning's deploy and are checking"* keeps the two apart. *"A deploy broke checkout"* before anyone has checked is a claim.
- **No time to fix without evidence.** Promise the next update instead: *"Next update by 14:30."* Then keep it, even if the update is that nothing changed.
- **Say what people see, in their terms.** *"Orders placed since 10:05 are not getting confirmation emails"* beats *"the mail queue consumer is stalled"*. The mechanism belongs in the internal channel.
- **No drama and no reassurance nobody can back.** Not *"critical"* unless it is. Not *"no data was affected"* until someone checked.
- **Apologise once, plainly, if at all.** *"Sorry for the disruption"* is fine. *"We sincerely apologise for any inconvenience this may have caused"* is filler, and so is *"We understand how frustrating this must be."*
- **Each update stands alone.** Someone joining at update four should not need updates one to three. Say what changed since the last one first.
- **Short.** A wall of text during an outage is not read.

## One incident, two audiences

The internal update and the external one carry the same facts and different detail. **Write them separately rather than trimming one into the other**, because a trimmed internal update leaks the mechanism and a padded external one invents reassurance.

| | Internal | External |
|---|---|---|
| Carries | Hosts, services, the suspected change, who is on it, what was ruled out | What is affected, since when, any workaround, the next update time |
| Leaves out | Nothing operational | Internal names, hypotheses, blame, infrastructure detail |

## The resolution note

What happened, how long, who was affected, what fixed it, and whether anything is still off. **A root cause goes in only once it is confirmed**; until then, *"we're still confirming the cause"* is the honest sentence. The full story, the timeline and the lessons belong in an internal incident record, not in the message.

## Before it goes back

1. Could someone act on this update without the ones before it?
2. Is every cause, scope or time stated as confirmed actually confirmed?
3. Is there a promised time to fix? If so, what evidence backs it?
4. Does the external version name anything internal?
5. Is the next update time in it?
