---
name: match-the-house-style
description: "Wear this before writing code in any language. Reads the core build-software-base first. Sets the naming, shape and structure conventions of the house, and names the superseded habits so they are not copied forward. Use when adding a class, a module, a script, a playbook or a tool."
---

# Match the house style

**First, read the core `build-software-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all software built with this kit shares: the order of authority (the contracts, best practice, the house voice), read the code first, scope is the deliverable, invented data, never production or a real cloud account and builders laptop only, a refusal ends the step, prove both directions, never report a pass you did not watch, the reporting clause, and how a commit is made. Do not wear `build-software-base` beside this skill; read its file. What follows is this skill's own.

**The core's order decides how a line gets written**, and here it is applied: where an existing habit in the code disagrees with best practice, the habit is out of date. The house voice decides what the first two leave open, and that is most of what a file looks like.

**Voice is naming, shape and prose. It is never toolchain and never a standard.** A package manager, a formatter, a linter, a test framework and a language version are rung two, not rung three, and a measurement of old code may not hold a tool at the version it happened to be at.

## The six habits that hold in every language

**A name is a verb phrase saying what the thing does.** `ListOpenInvoices`, `WarmProductCaches`, `RefreshCacheOnSave`, `can_notify`, `send_notifications`. **Then a suffix carries the role**: `*Interface`, `*Plugin`, `*Collection`, `*Provider`, `*Config`, `*Repository`, and invent one when none fits. Single responsibility should be visible in the filename before anything is opened.

**A file holding a class is PascalCase; a file holding functions is lowercase.** `NotificationManager.py` beside `utils.py`. Keep it, and do not export it to a package a stranger will import.

**Every knob is a named constant or an environment variable with a default, never a literal at the point of use.** A console command's name, a config section id, a retry ceiling, a queue topic: each is a decision a deployment is allowed to make, and a literal takes that decision away and puts it where a rename cannot reach.

**A batch survives its items and returns the tally.** `try`/`catch` per element, log the failure, keep going, hand back a count. **The tally is what makes it correct rather than a swallow**: the failure count has to leave the function, reach a caller and decide an exit status. A `catch` whose only effect is a debug log is not this pattern.

**An outcome is an object, never a tuple or a loose array.** `SyncResult`, `HealthResult`, `NotificationMessage`. Getters, no setters, constructed once.

**A docstring is one sentence, third person, saying what the code does.** *"Cache-warmer configuration provider."* Zero `Args:`, `Returns:` or `:param:` blocks. Where it goes longer, it states a live constraint.

## Shape

**One unit does one job and says so in its name.** A class or file needing the word *and* to describe it is two things. Things that change together live together.

**Depth beats breadth**: a small object with a real name beats an array of loose fields passed through four layers. Where a constructor has grown long, **bundle collaborators into a Context and operational data into a configuration object the container builds**. The Context carries services, the config carries values, the class carries the work.

**Object calisthenics as pressure, not law.** Three bend against Magento and none outranks readability: **getters and setters are mandatory on a Magento data interface** because reflection and REST read them; **one dot per line yields to a builder chain**; **no `else` is worth taking literally**, since a guard clause and an early return is nearly always the version that reads better.

**Boy scout, bounded by the change you came to make.** Fix what is in the way, rename what misled you, delete what is dead. Do not embark on the unrelated refactor while a bug is open.

**When two designs are both correct, the one someone else understands faster wins.**

## Per language

- **PHP and Magento is the reference dialect** where a repository has no settled style of its own. `declare(strict_types=1)` always and without spaces. **`private readonly` promoted in the constructor, one parameter per line, empty body** (`protected` is the superseded habit, not the convention). No `final`, because the framework generates subclasses. `@inheritDoc` on an implementing method. `createMock()`, never a hand-written fake. `$this->assertX()`, not `self::`. Descriptive test method names.
- **Python**: f-strings, module-level functions over classes, `print()` in a CLI and `logger.` in a service, a `@dataclass` for a shape, bare `assert` in tests with a `#` line narrating each block. **The stack is `uv` and `ruff`**, not Poetry, black, pylint or tox.
- **TypeScript**: single quotes, two spaces, no semicolons, `interface` for a data shape, a class declared at the top and one instance exported at the bottom so callers import a lowercase noun. **`??` not `!` with a `||` fallback**, and never `any`.
- **Ansible**: task names are imperative sentences in sentence case with no trailing period. `become: true`. `cacheable:` stated on every `set_fact`. **`changed_when:` on every `shell` and `command`**, or the changed count carries no information.
- **Bash**: `#!/usr/bin/env bash`, `set -euo pipefail`, quoted expansions, `exit 1` rather than a bare `exit`, which returns the previous command's status.
- **Makefiles**: `.DEFAULT_GOAL := help`, a target documented by a trailing `## description` on its own line, `.PHONY` immediately before each target, `?=` for overridable settings. **Recipes hold no logic** and delegate to a script.

## Superseded, so never copy it forward

A bare `exit` in a guard. A `shell:` task with no `changed_when`. A `stat` then `fail` then `touch` used as a lock. `env python` on a shebang. `process.env.X! || 'default'`. `: any`. `protected readonly` in Magento. An undescribed Terraform variable. A `catch` that decides a branch. **And a typo in a name is not a convention**: copy the shape of a name, never its spelling errors.

## When editing an existing file

**The surrounding file wins on style, and never on a superseded habit.** Matching a neighbour's naming is consistency. Matching its unquoted expansion is a second bug.

**When nothing above settles it, follow the repository's own most consistent code**, and where it has none, write it the way the PHP above does.
