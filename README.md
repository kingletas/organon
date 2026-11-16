# organon

Skills, review agents and work seats for [Cortex Code](https://docs.snowflake.com/en/user-guide/cortex-code/cortex-code) and Claude Code: one engineer's way of working, written down so an agent can follow it.

It carries three engineering contracts (development, security, infrastructure), the skills that apply them, read-only review agents, and work seats for the day-to-day work on a platform. The rules every agent follows are in [AGENTS.md](AGENTS.md).

## What is in it

**[The contracts](docs/contracts/)**, cited by ID everywhere else: [development](docs/contracts/development.md) (`DEV-C1` to `DEV-C20`), [security](docs/contracts/security.md) (`SEC-C1` to `SEC-C23`) and [infrastructure](docs/contracts/infrastructure.md) (`INF-C1` to `INF-C24`), each with the maxims behind it.

**[Skills](skills/)**, on three shared cores that a skill reads first:

| Core | Skills that read it |
|---|---|
| `build-software-base` | `find-the-cause`, `gate-the-signal`, `check-before-done`, `match-the-house-style`, `design-a-screen` |
| `evidence-base` | `delegate-the-io`, `research-a-question`, `hand-over-the-work` |
| `write-for-people-base` | `write-for-the-reader`, `write-to-a-person`, `write-the-docs`, `record-the-why`, `write-an-incident-update` |

**[Review agents](agents/)**, each read-only and each with its own verdict:

- **To decide which reviews a change needs, and to bring them together:** `review-triage`, `review-synthesis`, `review-verify`, `review-senior`
- **A quorum, three independent angles on one hard question:** `quorum-code`, `quorum-design`, `quorum-risk`
- **Specialists:** `review-security`, `review-database`, `review-perf`, `review-infra`, `review-api`, `review-compat`, `review-docs`, `review-release`, `review-scope`, `review-ui`, `review-accessibility`
- **Before a decision or a message:** `review-decision`, `review-communication`
- **Workers:** `write-tests`, which writes test files only, and `bulk-reader`, which reads a large corpus and returns bullets

**Work seats**, roles for the job rather than reviewers:

| Seat | For | Changes things? |
|---|---|---|
| `platform-reader` | Reading and explaining the platform's code, infrastructure and history | No |
| `chief-of-staff` | Plans, 1:1 prep, status for leadership | Writes notes and drafts |
| `data-hand` | The Snowflake side: what the warehouse holds, queries, semantic models | Reads and queries |
| `security-reviewer` | The skeptic on changes touching payments, authentication or customer data | No |
| `incident-voice` | Updates during an outage and the review after it | Drafts, never sends |
| `platform-engineer` | Fixes and reliability work, on an explicit request | Yes |

## Why it works in both tools

Cortex Code reads the same folders Claude Code does: skills from `.claude/skills/`, agents from `.claude/agents/`, hooks from `.claude/settings.json`, and the project's rules from `AGENTS.md` ([CoCo CLI extensibility](https://docs.snowflake.com/en/user-guide/cortex-code/extensibility)). So one copy serves both.

**One difference bites.** Cortex Code matches an agent's tool names case-sensitively and skips a name it does not recognise without an error, so an agent whose tools are written `Read, Grep` starts with no tools at all. Claude Code's documentation uses the capitalized names. So every agent here is written with Cortex Code's lower-case names, `make check` refuses a capitalized one, and the installer writes the capitalized names into any copy it puts in a `.claude` folder.

## Install

```bash
git clone https://github.com/kingletas/organon && cd organon && make install
```

That copies the skills and agents into `~/.snowflake/cortex/`, which Cortex Code's CLI and Desktop app both read. It needs no administrator rights, and it never overwrites a file of yours that differs; `FORCE=1` does.

Cortex Code can also take the skills straight from Git:

```text
/skill add https://github.com/kingletas/organon.git
```

For Claude Code, or for one project:

```bash
make install DEST="$HOME/.claude"
```

A `.claude` destination gets Claude Code's capitalized tool names. **Cortex Code reads `.claude/agents/` too**, and there those names mean nothing to it, so on a machine that runs both tools, give Cortex Code its own copy in `~/.snowflake/cortex/` and check with `/agents` which one it loads.

**Cortex Code in Snowsight, the web version, does not read local skill files.** It takes skills an account administrator shares through Snowflake's catalog.

Start with [From nothing to a working organon](docs/from-nothing.md).

## What it does not carry

- **A design system.** `review-ui` and `review-accessibility` judge against one only where a repository has adopted it (a tokens file and a rules file at its root), and say so when it has not.
- **A visual design skill.** `design-a-screen` covers the states every view owes; for aesthetic direction, pair it with one such as Anthropic's [`frontend-design`](https://github.com/anthropics/skills/tree/main/skills/frontend-design).

## The gate

```bash
make check
```

The scripts' lint, the checker's own tests in both directions, and the checker over the whole kit: lower-case tool names, names that match their files, cores and review agents that exist, alerts GitHub renders, and no path on anyone's machine. It needs Python 3.9 or newer and nothing else.

## Licence

MIT. See [LICENSE](LICENSE).
