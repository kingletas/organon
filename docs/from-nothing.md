# From nothing to a working organon

By the end of this, an engineer who has never seen organon has it loaded in Cortex Code, has checked that its agents can actually use their tools, and has had a first session with a work seat.

## Contents

- [What this is](#what-this-is)
- [Step 0: what you need](#step-0-what-you-need)
- [Step 1: install it](#step-1-install-it)
- [Step 2: check the agents can see](#step-2-check-the-agents-can-see)
- [Step 3: a first session](#step-3-a-first-session)
- [What you get for free](#what-you-get-for-free)
- [Where to go next](#where-to-go-next)

## What this is

A set of written working rules, review roles and job roles that an AI coding agent loads and follows.

Without it, every session starts from the agent's defaults: it guesses at your standards, reports "done" without saying what it did not check, and reviews code with no particular angle. With it, the agent works to three named contracts, says plainly what it did not verify, and has a specialist reviewer for each kind of change.

## Step 0: what you need

- **Cortex Code's CLI or Desktop app.** Both read local skill files. **Cortex Code in Snowsight does not**: it takes skills an account administrator shares through Snowflake's catalog.
- **Access to GitHub**, to clone the repository.

## Step 1: install it

```bash
git clone https://github.com/kingletas/organon && cd organon && make install
```

A first run copies every skill and agent into Cortex Code's own folder and says how many files it copied. A second run copies nothing, because everything is already current.

**If a file of yours with the same name already exists and differs, it is left alone** and the run says so and exits non-zero. `FORCE=1 make install` replaces it.

No administrator rights are needed: everything goes under your own home folder.

## Step 2: check the agents can see

Start Cortex Code and run:

```text
/skill list
/agents
```

Every skill and agent in the repository should be listed. **Then ask one agent to read a file**, for example:

```text
Use the platform-reader agent to read README.md and tell me what this repository is.
```

If it answers that it cannot read files, its tool names did not resolve. Cortex Code skips a tool name it does not recognise without an error, which is why every agent here writes them in lower case. Check the agent's `tools:` list in `~/.snowflake/cortex/agents/`, and report it as a bug.

## Step 3: a first session

Start with the seats that read and explain:

```text
Use the platform-reader agent to map this repository: what calls what, where it is fragile, and what nobody wrote down.
```

```text
Use the chief-of-staff agent to draft a plan for this quarter from these notes.
```

Neither changes anything. `platform-engineer` is the one seat that edits code, and only when you ask it to.

For a change someone else wrote, ask `review-triage` which reviews it needs, then run those.

## What you get for free

- **The reporting clause**: every result says what was not verified, in the same sentence.
- **A refusal ends the step**: a guard or permission that says no is reported, never routed around.
- **A reviewer for each angle**, and `review-synthesis` to turn their reports into one ranked review without losing a dissent.
- **Contract IDs** (`DEV-C12`, `SEC-C8`) to cite in a review or a commit message, so a finding points at a rule rather than at taste.

## Where to go next

- [AGENTS.md](../AGENTS.md): the rules every agent follows, and the work-seat guard rails
- [The contracts](contracts/)
- [README](../README.md)
- [CONTRIBUTING.md](../CONTRIBUTING.md)
