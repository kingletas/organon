# Changelog

## Unreleased

**The first kit for Cortex Code and Claude Code: three engineering contracts, the skills that apply them, review agents and work seats.**

- **The contracts.** Development, security and infrastructure, in `docs/contracts/`, with every rule numbered so a review or a commit can cite it. `AGENTS.md` holds the short form both tools read.
- **Skills** on three cores: debugging, signals, done-checks, house style, screens, delegation and research for building software; documents, messages, docs, comments and commits, incident updates and handoffs for writing.
- **Review agents**, each read-only but the test writer, and each with its own verdict.
- **Work seats** for the day-to-day work on a platform: reading it, planning, its data, security review, incident updates, and changes on request.
- **Agents load with their tools in both tools.** Every agent is written with Cortex Code's lower-case tool names, which it needs because it skips an unrecognised name without an error. The installer writes Claude Code's capitalized names into a copy for a `.claude` folder.
- **`make install` needs no administrator rights** and never overwrites a file of yours that differs.
- **`make check` refuses a kit that would load wrong**: a capitalized tool name, a name that does not match its file, a core or review agent that is not there, an alert GitHub does not render, or a path on someone's machine.