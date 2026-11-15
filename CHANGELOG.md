# Changelog

## Unreleased

**The first kit: three contracts, sixteen skills, twenty-two review agents and six work seats, for Cortex Code and Claude Code.**

- **The contracts.** Development, security and infrastructure, in `docs/contracts/`, with every rule numbered so a review or a commit can cite it. `AGENTS.md` holds the short form both tools read.
- **Sixteen skills** on three cores: debugging, signals, done-checks, house style, screens, delegation and research for building software; documents, messages, docs, comments and commits, incident updates and handoffs for writing.
- **Twenty-two review agents**, each read-only but the test writer, and each with its own verdict.
- **Six work seats** for a lead learning a platform and then leading the work on it, the reading ones first, each a role and never a colleague.
- **Agents load with their tools in both tools.** Every agent is written with Cortex Code's lower-case tool names, which it needs because it skips an unrecognised name without an error. The installer writes Claude Code's capitalized names into a copy for a `.claude` folder.
- **`make install` needs no administrator rights** and never overwrites a file of yours that differs.
- **`make check` refuses a kit that would load wrong**: a capitalized tool name, a name that does not match its file, a core or review agent that is not there, an alert GitHub does not render, or a path on someone's machine.

Not verified: nothing here has run inside Cortex Code yet, and whether Claude Code accepts lower-case tool names is not documented, which is why the installer converts them.
