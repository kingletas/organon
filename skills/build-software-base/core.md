# The core: what every piece of software we build keeps

**Read this before the child skill's own rules, every time a child is worn.** The child adds its method; where a child says more, the child governs for its work.

## What decides a line, in this order

1. **The three contracts and the gate that checks them**: development, security and infrastructure, in `docs/contracts/development.md`, `docs/contracts/security.md` and `docs/contracts/infrastructure.md`, and in short form in `AGENTS.md`. Not negotiable.
2. **Current best practice for that language and tool.** Where the old code disagrees with it, the old code is out of date.
3. **The house voice**, the style of the person or team you work for, which decides everything the first two leave open: naming, shape and prose, never toolchain and never a standard.

**Shippable means anything that will run somewhere other than the session that wrote it**: application code, a command-line tool, a plugin, a playbook, a migration, a CI job, a git hook, and every command handed over to be pasted into a terminal. In doubt, it ships.

## Before a line

**Read the code before changing it or recommending a change to it, and read what calls it.** A filename, a changelog or a note about the code is not the code.

**The requested scope is the deliverable.** Do not quietly narrow it, widen it, or turn it into an adjacent thing. Where part of it is blocked, finish the rest and say what was left out and why.

## Where it runs, and on what

**Invented data only.** Every name, company, host, figure and date in a fixture, an example or a test is made up, with the same shape as the real one. A bug that only shows on real data is still reproduced on a fixture: ask for the shape that triggers it.

**Never against production, a live site or a real cloud account.** A step that reaches a real account is handed over, and the person you work for runs the real thing. What you deploy is tested in a test environment, by a person or a seat that has been given one, under that environment's own rules.

**A builder agent is laptop only.** A test that needs a shared server, a shared database or a deployed environment is not run by a builder: it says so, and leaves it for whoever sent it.

**A refusal ends the step.** A guard, a gate or a classifier that refuses is the guard working: report it and stop, never route around it.

## What is proven, and how it is said

**Prove both directions.** The failing path as well as the passing one: a regression test seen failing before the fix, a check seen silent on the ordinary day and loud on the bad one. A green result proves nothing about the path that was never run.

**Never report as passing what you did not watch pass.** Read each command's own exit code, not the last lines of output through a pipe. A run on this laptop is evidence about the laptop, not about CI.

**The reporting clause never breaks.** Work may ship with a gate unrun, as long as it is said in the same breath:

> *"Lint and the unit suite pass; the migration is not run against a real database and the cache layer is not verified locally"* is honest.
>
> *"Done, all tests pass"* is a different claim, and a false one.

**Gate what you report, too.** A wall of findings trains the reader to skim, and the one that mattered goes with the rest.

## Committing

**Commit as the person or seat that is doing the work**, author and committer both, under the name and email the brief or the repository gives you. **Stage by name and commit by pathspec**, every path quoted; never `git add -A`, `git add .` or a bare `git commit`. **The message describes the software**, never the process or the session, and holds nothing personal: no figure, name, date or quotation from anyone's life. **Whether AI help is credited follows the employer's or the project's policy**: where it asks for a disclosure, write the one it asks for.
