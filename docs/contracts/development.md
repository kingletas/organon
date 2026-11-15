# Development maxims and engineering contracts

> **The rule, in one line.** Every piece of shippable code abides by the twenty contracts below. A contract is never broken quietly, and never broken without saying so in the same breath. A maxim can be argued with. A contract can only be met, or explicitly declared unmet before the code ships.

**Three layers, and the difference between them is the whole point.** A **maxim** guides judgment and admits exceptions. A **contract** states a requirement and admits none, only a declared, visible failure to meet it. A **gate** is the command that decides, so that neither one depends on anybody remembering.

**Items are citable.** A maxim is `DEV-M3`, a contract is `DEV-C12`. Cite them in reviews, commit messages and reports the same way `INF-C9` cites the infrastructure side and `SEC-C2` the security side.

Its companions are [security](security.md), for what the code does when someone is trying to make it do something else, and [infrastructure](infrastructure.md), which governs everything this document treats as an external system: cloud, networking, containers, provisioning, CI/CD, secrets and operations. The three are one standard split by subject, and code that crosses a line answers to both sides.

## The engineering philosophy

**Code exists to preserve and enforce intent.**

Everything else follows from this. A good codebase makes it:

- Difficult to accidentally do the wrong thing.
- Easy to intentionally do the right thing.
- Easy to understand, to test, to operate.
- Easy to change safely.
- Easy to remove when no longer needed.

The last one is the one people forget. Code that cannot be deleted is code that has to be maintained forever, and nothing in this document is worth more than a subtraction.

## Part I: development maxims

Twenty statements about judgment. Each one is a default, and a default can be departed from with a reason, written down where the next reader will find it.

### DEV-M1. Correctness before cleverness

> Code that is easy to understand is worth more than code that is impressive.

Prefer the obvious implementation. The clever one has to be re-derived by every person who meets it, including the one who wrote it, six months later.

### DEV-M2. Make invalid states unrepresentable

> Push correctness into types, schemas, validation and interfaces rather than into developer discipline.

If something should never happen, design the system so that it cannot happen, or so that it is rejected as early as possible. Discipline does not survive a deadline; a type does.

### DEV-M3. Explicit beats implicit

> Dependencies, configuration, behaviour, side effects and assumptions should all be visible.

```text
explicit dependency
    -> explicit configuration
    -> explicit behaviour
    -> explicit result
```

Magic and implicit coupling read as elegance right up until something breaks and there is nowhere to look.

### DEV-M4. Fail fast, fail loud

> Detect errors as close to their source as possible, and never let invalid state propagate.

When something cannot continue safely: detect it, preserve the context, report it, then stop or recover deliberately.

### DEV-M5. Small things compose

> Prefer small focused components that compose over large components that attempt everything.

This applies identically to functions, classes, modules, services, infrastructure modules, automation roles, orchestrator resources, CLI commands and shell scripts.

### DEV-M6. One source of truth

> A piece of knowledge has one authoritative representation.

Duplication of knowledge is far more dangerous than duplication of syntax, because the copies drift silently and both look right.

### DEV-M7. Duplication is a liability, not a sin

> Eliminate duplicated knowledge, not merely duplicated characters.

Ask whether these implementations are coincidentally similar or are the same concept. Only the second has to be consolidated. Merging the first produces an abstraction with two masters.

### DEV-M8. Boring is a feature

> Prefer established, predictable solutions over novel abstractions unless the novelty buys something measurable.

The best production code is boring: predictable, familiar, testable, maintainable, and easy to replace.

### DEV-M9. Dependencies are debt

> Every dependency carries maintenance, security, compatibility and operational cost.

Before adding one, ask: do we need it, can the standard library do it, can an existing dependency do it, is it maintained, what is its security posture, and what happens the day it disappears?

### DEV-M10. Configuration is not code

> Environment-specific behaviour belongs in configuration, not in conditionals scattered through the implementation.

```text
code + configuration = environment-specific behaviour
```

An `if production:` branch buried three calls deep is a configuration value wearing a disguise.

The process that produces a result stays the same; only the configuration differs. When code needs a value that would differ between two real users or environments (a path, a threshold, a list, a marker, a person's figures), it reads configuration and ships no personal default. Do not add a setting nobody has needed yet: YAGNI and KISS bound this.

### DEV-M11. Boundaries matter

> Validate data at system boundaries.

Boundaries include HTTP requests, APIs, databases, files, environment variables, CLI arguments, message queues, cloud services and anything a human typed.

### DEV-M12. Every side effect has a cost

> I/O, network calls, database mutations, filesystem operations and global state are explicit and controlled.

Side effects should be isolated, observable, testable and deliberate, in that order.

**A destructive action on data somebody entered by hand needs both a confirmation and a way back.** Clear labelling is not a substitute for either. Destructive commands move rather than delete (a dated folder under the application's own state directory, structure preserved, each run in its own folder so a second mistake cannot bury the recovery from the first). Every removal confirms through one shared helper, the confirmation names the thing, and a test asserts every remove handler goes through it. A "Start over" action that shipped without an undo emptied a user's reports and settings, and the feature worked exactly as written.

### DEV-M13. Design for failure

> Assume everything external can fail, because it does.

Networks fail. Disks fill. APIs disappear. Credentials expire. Certificates expire. Processes crash. DNS breaks. Failure is not an exceptional design consideration; it is part of normal operation.

### DEV-M14. Observability is part of correctness

> If we cannot determine what the system did and why, the system is not operationally complete.

Logs, metrics, traces, health checks, error reporting and audit trails are features of the change, not follow-ups to it.

**A surface that fails to render must say so on the surface**, with a way to try again, and never return silently. A blank panel reads as "you have no data", and a view that rendered nothing while every test passed went unnoticed for three releases.

### DEV-M15. Delete before you abstract

> Before creating an abstraction, ask whether the underlying complexity can simply be removed.

The best abstraction is frequently no abstraction and forty fewer lines.

### DEV-M16. YAGNI has teeth, and KISS is its twin

> Do not implement hypothetical requirements.

Build what is required today, and design today's implementation so tomorrow's requirement is not needlessly blocked. Those are compatible; only the first is negotiable.

**Simple is best.** YAGNI decides what to build; KISS decides how. Of two designs that both work, choose the one the reader debugging it at 2am understands first: a 60-line function with no indirection is simpler than six 10-line classes wired through a container. Simple is not easy: say what the simple version still requires.

### DEV-M17. Local reasoning

> A developer should understand what a component does without tracing the whole system.

Clear inputs, clear outputs, clear responsibility, clear dependencies, clear failure behaviour.

### DEV-M18. Automation is documentation

> If a rule matters enough to repeat, automate it whenever practical.

"Remember to run the formatter" is a rule that will be broken. A CI job that runs the formatter is a rule that cannot be.

### DEV-M19. Reproducibility is a requirement

> A build, test, deployment or development environment produces predictable results from known inputs.

No undocumented manual steps, no hidden machine dependencies, no unpinned critical dependencies, no environment-specific hacks, no "works on my machine".

### DEV-M20. Leave it better

> Every change leaves the codebase at least as maintainable as it found it.

Debt may be taken on deliberately and recorded. It may not be taken on accidentally. This is the Boy Scout rule.

### Named laws to work by

Unnumbered, so no maxim or contract moves.

- **Gall's law.** A complex system that works evolved from a simple system that worked. Start with the smallest version that works, and grow it one measured step at a time, each with a known good and bad point, the way `git bisect` narrows a fault. A complex system designed from scratch does not work and cannot be patched into working.
- **Chesterton's fence.** Do not remove something until you know why it is there. A check, a flag, a strange file or an odd branch may be load-bearing. Read the history (`git log`, the ticket, the decision record) before deleting or "simplifying" it; if nobody can say why it exists, find out before it goes.
- **Hyrum's law.** With enough users, every observable behaviour of a system will be depended on by somebody. Once something is public, its output format, error text, timing and defaults are an interface whether documented or not. Change them as deliberately as an API, and say so in the changelog.
- **Small batches.** Short-lived branches, merged often, one change at a time. A small change is easy to review, easy to reverse and easy to bisect; a large one hides its defects inside its size. It is the practice the DORA research ties most closely to delivery that is both fast and stable.
- **Make it work, make it right, make it fast, in that order.** Correct first, then clear, then quick, and no optimisation without a measurement that shows where the time goes. An optimisation nobody measured is complexity with a guess attached.

## Part II: universal development contracts

These are stronger than the maxims above. A maxim guides judgment; a contract establishes an expectation that shippable code meets. Each says what decides it, and where nothing mechanical decides it, that is stated plainly rather than implied.

### DEV-C1. Every change must have a reason

Every change answers three questions: what problem does this solve, why does it belong here, and why is this implementation the right one? No speculative code.

**Enforced by** review and the commit message. No mechanical gate exists, and none can; this is the contract that depends entirely on the person.

### DEV-C2. Every input is untrusted

Anything originating outside the current trusted scope is treated as potentially invalid: user input, API responses, files, environment variables, configuration, database rows, CLI arguments, network responses, external services. Validate at the boundary, once, where the data enters.

**Enforced by** a type checker or static analyser for the type-level cases, where the stack has one. Semantic validation is review-only.

### DEV-C3. Every failure must have defined behaviour

For every operation that can fail, decide which of these is correct: retry, fall back, roll back, propagate, terminate, or ignore on purpose.

> **Forbidden reasoning.** "It probably won't fail" is not a failure strategy. Neither is a `try` block whose `except` was written to make a stack trace go away.

**Enforced by** review. Name the strategy in the code or its docblock so a reader can tell a deliberate ignore from an oversight.

### DEV-C4. No silent failure

```python
try:
    do_something()
except Exception:
    pass
```

is forbidden unless ignoring the failure is explicitly intentional and documented on the spot. Errors do not disappear.

**Enforced by** a linter or static analyser that catches the empty-catch shape, where the stack has one. Shell scripts get it from `set -euo pipefail`, because the shell's default is the opposite. A batch tool that must survive a single item's failure runs `set -uo pipefail` with a comment saying why `-e` is off, and tallies failures by hand.

### DEV-C5. Errors must preserve context

An error answers what failed, where, and why. Do not destroy exception context to produce a tidier-looking message; a clean error that says nothing costs an hour later.

**Enforced by** review. Re-raise with the cause attached, and log the object a handler was handed rather than interpolating it into a sentence.

### DEV-C6. Functions have one job

If describing a function requires "first it does X, then Y, except when Z, and afterwards A", it holds several responsibilities and should be several functions.

**Enforced by** complexity, length and parameter-count rules in a linter, where the stack has one. Elsewhere, review.

### DEV-C7. Interfaces must be smaller than implementations

Expose the minimum necessary API and keep the rest private.

> Small interfaces reduce coupling and make replacement possible. The interface is the promise; everything else is an implementation detail you are still free to change.

**Enforced by** review, or by a check that a class implementing an interface declares no public methods outside it, where a project has written one.

### DEV-C8. Dependencies must be directional

Architecture has an intentional dependency direction. Higher-level business logic does not acquire incidental coupling to databases, frameworks, cloud providers, HTTP libraries, CLI frameworks, filesystem layouts or infrastructure providers, unless that coupling is a decision someone made on purpose.

**Enforced by** a coupling metric where the stack has one. Direction itself is review-only: the metric counts edges, not arrows.

### DEV-C9. No hidden global state

Avoid mutable global state unless it is explicitly part of the architecture. Be most suspicious of global caches, singletons, environment mutation, implicit registries, global configuration and mutable module-level variables.

**Enforced by** review. Static analysis sees the declaration, not the mutation pattern.

### DEV-C10. Tests are contracts

A test establishes behaviour that someone actually cares about. It is not a coverage instrument.

> **Coverage is a metric. Correct behaviour is the goal.** A suite that is green because it asserts nothing is worse than no suite, because it produces confidence.

**Enforced by** the test suite running in CI, and a check that each source class has a test where a project requires it. Whether a test asserts anything worth asserting is review-only, always.

### DEV-C11. Determinism where possible

Given the same inputs and environment, the system produces the same result. Randomness, timestamps, concurrency, network calls and environment-dependent behaviour are isolated behind a seam so a test can pin them.

**Enforced by** review, plus any suite that would flake without it. A flaky test is this contract failing, not the test being unlucky.

### DEV-C12. Security is a default

Never commit secrets, credentials, private keys, tokens or production data. Never assume something is safe because it is internal.

> **A working tree is not the thing that gets published.** Removing a secret in a later commit does not remove it from the repository, and a push publishes every commit rather than the tip.

**Enforced by** a secret scanner that runs on the working tree and on the full history, installed as a pre-commit hook, plus a dependency check against known vulnerabilities. Scan the full history before a first push and after any rewrite. A key that reached a commit is rotated, not merely removed.

### DEV-C13. Logs are not a database

Logs explain behaviour. They are not the primary store for application state, and a log line is not a substitute for a record with a schema.

**Enforced by** review.

### DEV-C14. No magic

Unexplained values with semantic meaning (`42`, `"foo"`, `/some/path`, `us-east-1`, `timeout = 17`) become named constants or configuration:

```php
private const int DEFAULT_TIMEOUT_SECONDS = 17;
```

**Enforced by** a linter that flags several magic-value shapes, where the stack has one; the rest is review. Large data goes in a data file beside the script rather than inline, which is the same rule in work clothes.

### DEV-C15. Public behaviour requires documentation

If another developer or system is expected to depend on it, its contract is documented: APIs, CLI commands, configuration, modules, infrastructure modules, infrastructure interfaces, schemas, events, environment variables.

**Enforced by** house rules with teeth where a team sets them: a module is not complete without its README, and a command-line tool documents itself in its header, with its purpose, usage, flags and environment overrides.

### DEV-C16. Breaking changes must be deliberate

Never break an interface by accident. When one must change: identify the affected consumers, document the change, provide migration behaviour where appropriate, and remove the old interface deliberately.

> **Typing a constant is a breaking change.** For example, in PHP 8.4 a typed constant on a parent or interface makes every child that redeclares it untyped a fatal error, and a child may not widen the parent's type. Types flow safely upward from leaves only, so before typing a constant on a base class, search every subclass that redeclares it, including the ones in vendored or shared packages that this repository's diff will never show you, and type them in the same change.

**Enforced by** a static analyser for a subset. Consumer discovery is a search you run, and the search has to reach outside the repository you are editing.

### DEV-C17. Infrastructure is code

Terraform, Kubernetes, Ansible, Docker, CI/CD, IAM and configuration are held to the same standard as application code: version controlled, reviewable, reproducible, validated, tested where practical, documented, and idempotent where applicable.

**Enforced by** the infrastructure checks, and in full by the [infrastructure contracts](infrastructure.md).

### DEV-C18. Local development must reflect production

Production architecture is reproducible locally rather than replaced by a different architecture for development. Local may be smaller, cheaper, less redundant and slower. Its interfaces, dependencies, configuration model and operational assumptions stay compatible.

**Enforced by** review, and by the pain of every bug that only exists in one of the two.

### DEV-C19. Automation must be idempotent

Running automation twice does not produce a different state the second time. This binds Terraform, Ansible, deployment scripts, provisioning, database migrations and setup scripts alike.

**Enforced by** a dry-run with a diff (for example `ansible-playbook --check --diff`) followed by a second real run, and a `terraform plan` that returns no changes after an apply. See `INF-C5` in the [infrastructure contracts](infrastructure.md).

### DEV-C20. Every abstraction must earn its existence

Before introducing an abstraction, name at least one benefit it delivers: removes duplicated complexity, reduces coupling, enforces an invariant, stabilises an interface, enables testing, or solves an operational problem.

Otherwise: don't add it.

**Enforced by** review, and by `DEV-C1`. An abstraction with no named benefit is speculative code with better manners.

## Part III: the enforcement hierarchy

Every standard here operates at four levels, and the work of codifying a standard is the work of moving it down this ladder.

| Level | What it is | Example |
|---|---|---|
| Principle | How we think | "Correctness before cleverness" |
| Contract | What we require | "Every source class has a unit test" |
| Automation | Makes it easy | pre-commit hook, formatter, linter, tests |
| CI enforcement | Makes it unavoidable | the gate fails, the merge does not happen |

**The codification rule.** If a standard can be mechanically enforced, it must be. Until it is, it is honestly labelled as review-only rather than described as though a machine were watching. A contract listed as enforced by a gate that does not run is worse than no contract, because it buys confidence it has not earned.

A rule sitting at Principle is a preference. The same rule at CI enforcement is a property of the system. Where a contract above says "where the stack has one", the expectation is that a linter or CI check enforces it when the stack provides one, and that a team without one says so rather than implying the check exists. `DEV-C1` and `DEV-C18` are judgements about the world outside the file, and no linter will decide them.

## Part IV: the shipping gate

### What counts as shippable code

Anything that will run somewhere other than the session that wrote it. That is the whole test, and it is deliberately broad:

- Application code, in any language.
- A command-line tool, and the data files beside it.
- A plugin, a browser extension, or anything else a runtime loads from a directory.
- A playbook, a role, a Terraform module, a Kubernetes manifest, a `Dockerfile`, a compose file.
- A database migration, a CI job, a cron entry, a git hook.
- **A command handed over to be pasted into a terminal**, including every cloud command, which is handed over precisely because it will be run.

Not shippable: a scratch probe deleted in the same session, a one-off diagnostic query, or a fragment quoted in prose to explain something. If in doubt, it ships. The cost of applying the contracts to a throwaway is a few minutes; the cost of the reverse is a review-only contract failing quietly.

### The five questions

Before shippable code is called done, all five are answered. Answering "no" is allowed. Answering silently is not.

1. **Reason.** What problem this solves, why it belongs here, why this implementation. (`DEV-C1`)
2. **Boundary.** Every input that crosses into trusted scope is validated where it crosses. (`DEV-C2`)
3. **Failure.** Every failing operation has a named behaviour, and nothing is swallowed. (`DEV-C3`, `DEV-C4`, `DEV-C5`)
4. **Verification.** The gate for that kind of code ran and passed, or the report says exactly which part is unverified and why.
5. **Record.** Public behaviour documented, no credential anywhere in the tree or the history, changelog written as part of the work rather than offered afterwards. (`DEV-C12`, `DEV-C15`)

### Declaring a contract unmet

The contract that must never be broken is the reporting one. Code may ship with a gate unrun, and that is survivable exactly as long as it is said out loud.

> **Good:** "The linter and the unit suite pass. Generated dependency-injection code is stale and cannot be compiled in this environment, so the new plugin is inert until it is recompiled: the interceptor change is not runtime-verified locally." (For example, in a PHP web application.)
>
> **A broken contract:** "Done, all tests pass."
>
> The second sentence is not a smaller version of the first. It is a different claim, and it is false.

Valid configuration, green unit tests and a green linter prove nothing about the assembled application. When a change touches dependency wiring, access control, message-queue topics or interceptors, verify against the running application, or say plainly that you could not.

## The universal engineering standard

**We build software that is correct, explicit, observable, reproducible, secure, testable, maintainable and deliberately simple.**

We treat application code, infrastructure, automation, configuration and operational tooling as one discipline.

We prefer enforceable standards over tribal knowledge, and automated verification over manual discipline.

We do not add complexity without justification, hide failures, duplicate knowledge, or rely on undocumented assumptions.

Every change has a reason, every failure has defined behaviour, and every abstraction earns its existence.

## The ultimate maxim

**Make the right thing easy, the wrong thing difficult, and the consequences of failure obvious.**
