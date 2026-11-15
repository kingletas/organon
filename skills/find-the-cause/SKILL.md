---
name: find-the-cause
description: "Wear this before debugging anything: a failing test, a production symptom, a regression, a slow page, a check that fires wrongly, or an isolation that has to say which change broke something. Reads the core build-software-base first. Moves from symptom to reproduction to competing hypotheses to a test that can tell them apart, and refuses to name a root cause the evidence has not earned. Use from the first symptom until a regression test proves the fix."
---

# Find the cause

**First, read the core `build-software-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all software built with this kit shares: the order of authority (the contracts, best practice, the house voice), read the code first, scope is the deliverable, invented data, never production or a real cloud account and builders laptop only, a refusal ends the step, prove both directions, never report a pass you did not watch, the reporting clause, and how a commit is made. Do not wear `build-software-base` beside this skill; read its file. What follows is this skill's own.

**The first plausible cause is the most dangerous one**, because everything after it becomes confirmation. A fix aimed at the wrong cause can pass its own test and leave the defect in place.

When the cause is genuinely in doubt and being wrong is expensive, this is a quorum instead: `quorum-code`, `quorum-design` and `quorum-risk`, independently.

## The order

```text
symptom → reproduction → observation → hypotheses → a test that separates them → cause → fix → regression test
```

**Skipping a step is allowed only when you say which one and why.**

## 1. Pin the symptom

What happens, what should happen, where, since when, for whom. **Exact output, not a paraphrase.** A symptom described from memory is a hypothesis already.

## 2. Reproduce it

Locally, in a container, or against a fixture of the same shape. **Never against production, never against a real cloud account.** If it cannot be reproduced, say so, and say what differs between where it happens and where you tried: data, version, configuration, load, timing.

**A bug that only shows on real data is still reproduced on invented data**: ask for the shape that triggers it.

## 3. Observe before explaining

Logs, query counts, timings, the actual state. **Measure the surface the change could reach**, not just the one you expected. A page diff cannot see cost.

## 4. At least two hypotheses

Write them down before testing either. For each: what it predicts that the others do not. **If every hypothesis predicts the same observation, the test cannot tell them apart**, and running it proves nothing.

## 5. Test to separate them

Change one thing. Revert it and confirm the symptom returns. **An isolation that turns several switches at once and blames one has not isolated anything**: bisect instead, one change at a time, both directions.

## 6. Name the cause only when the evidence earns it

State it with its evidence: *"the symptom appears with X and disappears without it, with Y held constant"*. Label anything short of that:

```text
CONFIRMED   reproduced, separated, reverted, and it came back
SUPPORTED   consistent with every observation, not yet separated
SUSPECTED   plausible, untested
```

**A suspected cause said as confirmed is the failure this skill exists to stop.** If the first isolation blamed the wrong thing, the record says what the real cause was, plainly.

## 7. Fix, and prove it

**A regression test that fails before the fix and passes after.** Show it failing first; a test written after the fix that only ever passed proves nothing about the defect. `write-tests` can write it.

## Before calling it found

1. Did I reproduce it, or reason about it?
2. Did I have more than one hypothesis, and a test that could tell them apart?
3. Did reverting the fix bring the symptom back?
4. Is the cause labelled confirmed, supported or suspected, honestly?
5. Is there a test that failed before the fix?
