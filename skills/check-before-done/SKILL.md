---
name: check-before-done
description: "Wear this before calling any piece of work finished or reporting a result. Reads the core build-software-base first. Runs the five questions every shippable thing owes, and enforces the reporting clause: say which gate did not run rather than rounding it up to done. Use at the end of a task, before a handover, and before writing 'all tests pass'."
---

# Check before done

**First, read the core `build-software-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all software built with this kit shares: the order of authority (the contracts, best practice, the house voice), read the code first, scope is the deliverable, invented data, never production or a real cloud account and builders laptop only, a refusal ends the step, prove both directions, never report a pass you did not watch, the reporting clause, and how a commit is made. Do not wear `build-software-base` beside this skill; read its file. What follows is this skill's own.

**Shippable is the core's word** (in doubt, it ships), and a scratch probe deleted in the same session is not shippable.

## The five questions. Answering *no* is allowed; answering silently is not.

1. **Reason.** What problem this solves, why it belongs here, why this implementation.
2. **Boundary.** Every input crossing into trusted scope is validated where it crosses, and **treated as attacker-controlled** rather than merely malformed.
3. **Failure.** Every failing operation has a named behaviour, nothing is swallowed, and anything security-relevant **fails closed**.
4. **Verification.** The gate for that lane ran and passed, **or the report names exactly which part is unverified and why**.
5. **Record.** Public behaviour documented, no credential in the tree **or the history**, changelog written as part of the work.

## The clause that must never break

**The core states it, with its example: code may ship with a gate unrun, as long as it is said out loud in the same breath.**

**Valid configuration, green unit tests and a green linter prove nothing about the assembled application.** Where the step that assembles it (a build, a compile, a deploy to a test environment) did not run, the change is not runtime-verified. Say it every time it applies.

## What actually ran

List what the change owes, from the contracts and the repository's own check, without running anything. Compare that to what you ran.

**Never report a test as passing that you did not watch pass** (the core). Not one you expect to pass, not one that passed before your last edit: if you did not see the output, it is unverified and it goes in the list.

**A gate only runs inside its own scope.** Before saying something is covered, check that the gate reaches the file: a gate for shell scripts may cover one folder only, a gate for one configuration tree does not cover another, and **a linter never runs `terraform plan`**. Never describe a contract as enforced by a gate that does not run.

## Scope, which is the other half of done

**The requested scope is the deliverable.** Do not quietly narrow it, widen it, or transform it into an adjacent thing.

- **Narrowing** is the common one and the hardest to see from inside: the four asks became three, and the three that shipped are finished so the fourth left no trace. **Enumerate the request and tick each item off.**
- **Widening** counts too. A refactor that rode along is a scope change.
- **Where part of it is blocked, finish everything else in full and say explicitly what you left out and why.** Scaling the work down is the requester's call, not yours.
- **Where an ambiguity was resolved by choosing, say what you assumed.** A silent assumption is a decision taken on someone else's behalf.

## Before you write the summary

- Did every claim in it come from something you actually ran or read?
- Is every unverified thing named, in the same breath as the thing that passed?
- Is anything described as gated that the gate does not reach?
- Did you say what you left out?
- **Is the summary itself gated?** Volume is a signal too. A wall of findings trains the reader to skim, and the one that mattered goes with the rest.
- Did an edit by string match fail loudly when the pattern was absent? Print what was verified, not what was attempted, and never report an edit in the same batch of tool calls that makes it.
- Is every "tests pass" backed by each test file's own exit code (`python3 "$t" >/dev/null 2>&1; echo "$t exit $?"`), not by the last lines of output through a pipe? For a change that removes a default, did the run happen where the default's replacement is absent?
- After a push, was the CI run read to its end (`gh run list -R OWNER/REPO --limit 1`)? "In progress when checked" is an open item with an owner, not a closing line. A local `make check` exit 0 is evidence about the laptop, not about the runner.

**This is the produce-time half of two agents.** `review-scope` judges scope against the verbatim request, and `review-release` returns a ship verdict with the unverified list. Both are independent and grade finished work. This is what you run on yourself first, so neither of them is the thing that discovers you never ran the suite.
