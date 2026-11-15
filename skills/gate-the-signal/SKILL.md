---
name: gate-the-signal
description: Wear this before writing anything that emits. A check, an alert, a log line, a health probe, a report, a commit message, or a reply. Reads the core build-software-base first. Applies a gating rule to your own output, so a signal fires when something is wrong and is silent when it is not. Use when adding monitoring or observability, writing a threshold, or deciding what a tool prints.
---

# Gate the signal

**First, read the core `build-software-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all software built with this kit shares: the order of authority (the contracts, best practice, the house voice), read the code first, scope is the deliverable, invented data, never production or a real cloud account and builders laptop only, a refusal ends the step, prove both directions, never report a pass you did not watch, the reporting clause, and how a commit is made. Do not wear `build-software-base` beside this skill; read its file. What follows is this skill's own.

An ungated signal is worse than none, because at least no signal leaves someone looking. A check that fires when nothing is wrong does not waste attention, it **trains the person to ignore the channel, and it takes the real alert down with it.**

This is a rule you already know. **The point of wearing it is that knowing it has not been enough.** Run your output past it deliberately.

## Before anything is allowed to emit

Answer all five. Answering *no* is allowed. Answering silently is not.

1. **What must it be silent for?** A check with no silent case is not a check, it is a status line pretending to be one. Name the ordinary day, and say what the tool prints on it. If the answer is "nothing", good.
2. **Does it gate on what predicts harm, or on what is easy to measure?** Occupancy is easy and means nothing; a rate means something. Load average is easy and lags; pressure-stall information leads. A percentage of a thing whose size nobody chose is almost always the easy answer, not the right one.
3. **Does a repeating condition back off?** Even a true alert repeated sixty times an hour is noise by the fifth.
4. **Was the quiet path tested, not just the loud one?** A green verdict proves nothing about the alarm, and a firing alarm proves nothing about the quiet. **Both directions, every time, before you call it done.**
5. **If it is already noisy, is the answer to condition it, or to demote it?** Usually to demote it. See below.

## The shape you will repeat

A swap check that grades swap **occupancy** fires all day: on a small swap file against a large amount of RAM, 99% full is the resting state, so the alert can never clear, while memory stall is 0% and plenty of memory is free. The rate was the better signal than the percentage.

**When a comment above a threshold says one signal is better than another, check that the line beneath it grades that signal.** Writing the insight down is not implementing it, and nothing mechanical catches a comment that disagrees with the line beneath it.

## Conditioning relocates a false positive. It rarely removes one.

Gating that same check on *"only while free memory is below 30%"* still alarms with memory stall at 0% and swap-in at 0. **A static number gated on another static number is still not a measurement of harm**, and twice is a design error rather than a tuning miss.

**When a signal cannot indicate harm on its own, demote it to context on a signal that can.** A nearly full swap file is a clause on the memory alert, not an alert. Reach for demotion before you reach for another condition.

## A threshold that flaps defeats everything built on top of it

A check that sits exactly on its gate clears and re-fires constantly, and every re-entry reads as a fresh escalation. The backoff resets each time and never engages.

**Recovery has to hold before it counts.** Without hysteresis or a dwell time, every mechanism downstream of the threshold is decorative.

## When a gate already judges what you write

**A tool that writes files another tool checks takes the checker's numbers.** Look for an existing gate on the same property before choosing a threshold. Take its thresholds verbatim with the same comparison operator, keep the producer at or inside the gate's warning line, copy its measuring function and say in a comment that it is a copy and must move together, and write the test that fails on drift. Two calibrations of one measure drift apart, and a producer calibrated on its own output writes files its own gate then flags.

**Measure the whole population the gate covers, not the slice the producer writes**, and count the way the gate counts. A heading count that ignores code fences disagrees with one that respects them, and a limit tuned on the wrong count splits files that load perfectly well, with nothing ever reporting it.

## This is not only about monitoring

The rule governs anything that emits, and the two people usually forget:

- **A commit message, a changelog line, a report.** If everything is flagged, nothing is. A report that marks every row as needing attention has not finished its job.
- **The volume of what you send back to a person.** That is a signal too, and it needs gating like any other. A wall of findings trains the reader to skim, and the one that mattered goes with the rest.

## Before you call it done

- The ordinary day produces nothing. You ran it and saw nothing.
- The bad day produces exactly one thing, and you ran it and saw that too.
- The threshold measures harm, not convenience, and you can say why in one line.
- A condition that persists backs off; a condition that recovers has to stay recovered before the backoff resets.
- The comment above the threshold says what the code below it actually does.
- A producer's limit is its gate's own number, measured the same way.
