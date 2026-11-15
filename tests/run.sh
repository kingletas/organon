#!/usr/bin/env bash
#
# run.sh -- the checker's and the installer's tests, in both directions.
#
# Usage:
#   tests/run.sh
#
# Each case copies the passing fixture into a scratch folder, breaks one thing,
# and expects the checker to name it. The passing fixture itself must stay
# silent, because a check that fires on good input is as wrong as one that
# misses bad input.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHECK="$HERE/bin/organon-check"
INSTALL="$HERE/scripts/install"
GOOD="$HERE/tests/fixtures/good"
SCRATCH="$(mktemp -d)"
trap 'rm -rf "$SCRATCH"' EXIT

passed=0
failed=0

ok()   { passed=$((passed + 1)); }
fail() { failed=$((failed + 1)); echo "  FAIL  $1"; }

fresh() {
  rm -rf "$SCRATCH/kit"
  cp -R "$GOOD" "$SCRATCH/kit"
}

# expect_clean NAME: the checker says nothing and exits 0.
expect_clean() {
  local out
  if out="$("$CHECK" "$SCRATCH/kit" 2>&1)" && [ -z "$out" ]; then ok; else fail "$1: expected silence, got: $out"; fi
}

# expect_problem NAME TEXT: the checker exits 1 and its output contains TEXT.
expect_problem() {
  local out status=0
  out="$("$CHECK" "$SCRATCH/kit" 2>&1)" || status=$?
  if [ "$status" -eq 1 ] && grep -qF -- "$2" <<<"$out"; then ok; else fail "$1: expected '$2' and exit 1, got exit $status: $out"; fi
}

# --- the checker ------------------------------------------------------------

fresh
expect_clean "a conforming kit"

fresh
sed -i 's/^  - read$/  - Read/' "$SCRATCH/kit/agents/example-agent.md"
expect_problem "a capitalized tool" "tool 'Read' is capitalized"

fresh
sed -i 's/^tools:$/tools: Read, grep/; /^  - /d' "$SCRATCH/kit/agents/example-agent.md"
expect_problem "a capitalized tool written inline" "tool 'Read' is capitalized"

fresh
sed -i '/^tools:$/d; /^  - /d' "$SCRATCH/kit/agents/example-agent.md"
expect_problem "an agent with no tools" "no tools listed"

fresh
sed -i 's/^name: example-agent$/name: other-agent/' "$SCRATCH/kit/agents/example-agent.md"
expect_problem "an agent whose name is not its file" "the file is 'example-agent'"

fresh
sed -i 's/^name: example-skill$/name: other-skill/' "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "a skill whose name is not its folder" "the folder is 'example-skill'"

fresh
sed -i '/^description:/d' "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "a skill with no description" "no description"

fresh
rm -rf "$SCRATCH/kit/skills/example-base"
expect_problem "a skill whose core was left behind" "reads the core 'example-base'"

fresh
echo "Open /home/someone/notes/today.md first." >> "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "a Linux home directory" "names a Linux home directory"

fresh
echo "Keep it in ~/Projects/kit." >> "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "a path under someone's home" "names a path under someone's home"

fresh
echo 'See C:\Users\someone\kit.' >> "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "a Windows user folder" "names a Windows user folder"

fresh
printf 'Send the diff to %sreview-security%s first.\n' '`' '`' >>"$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "a review agent that was never carried over" "names the agent 'review-security'"

fresh
printf '%s\n' '> [!NOTE]' '> A plain note.' >> "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_clean "a GitHub alert alone on its line"

fresh
printf '%s\n' '> [!info] A title' '> A note.' >> "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "an alert GitHub does not render" "alert [!info] is not one GitHub renders"

fresh
printf '%s\n' '> [!NOTE] A title on the same line' >> "$SCRATCH/kit/skills/example-skill/SKILL.md"
expect_problem "an alert with text on its line" "alert [!NOTE] is not one GitHub renders"

# --- the installer ----------------------------------------------------------

export ORGANON_SOURCE="$GOOD"
dest="$SCRATCH/dest"
skill="$dest/skills/example-skill/SKILL.md"

if "$INSTALL" "$dest" >/dev/null 2>&1 && [ -f "$skill" ] && [ -f "$dest/agents/example-agent.md" ]; then ok; else fail "a first install copies the skills and the agents"; fi

if out="$("$INSTALL" "$dest" 2>&1)" && grep -qF "0 copied, 3 already current" <<<"$out"; then ok; else fail "a second install copies nothing: $out"; fi

echo "a person's own change" >> "$skill"
if ! "$INSTALL" "$dest" >/dev/null 2>&1 && grep -qF "a person's own change" "$skill"; then ok; else fail "install leaves a changed file alone and exits non-zero"; fi

if FORCE=1 "$INSTALL" "$dest" >/dev/null 2>&1 && ! grep -qF "a person's own change" "$skill"; then ok; else fail "FORCE=1 replaces a changed file"; fi

# A Cortex Code destination keeps the lower-case names; a Claude Code one gets
# the capitalized names in the front matter and nothing else changes.
agent="$dest/agents/example-agent.md"
if grep -qx '  - read' "$agent" && ! grep -q 'Read' "$agent"; then ok; else fail "a Cortex Code install keeps lower-case tool names"; fi

claude_dest="$SCRATCH/project/.claude"
claude_agent="$claude_dest/agents/example-agent.md"
"$INSTALL" "$claude_dest" >/dev/null 2>&1
if grep -qx '  - Read' "$claude_agent" && grep -qx '  - Grep' "$claude_agent" && grep -qx 'You review.' "$claude_agent"; then ok; else fail "a .claude install capitalizes the tool names and keeps the body"; fi

if "$INSTALL" "$claude_dest" 2>&1 | grep -qF "0 copied"; then ok; else fail "a second .claude install sees its own spelled copy as current"; fi

inline_src="$SCRATCH/inline"
cp -R "$GOOD" "$inline_src"
sed -i 's/^tools:$/tools: read, grep/; /^  - /d' "$inline_src/agents/example-agent.md"
ORGANON_SOURCE="$inline_src" TOOL_NAMES=claude "$INSTALL" "$SCRATCH/inline-dest" >/dev/null 2>&1
if grep -qx 'tools: Read, Grep' "$SCRATCH/inline-dest/agents/example-agent.md"; then ok; else fail "an inline tools list is capitalized too"; fi

if ! TOOL_NAMES=other "$INSTALL" "$SCRATCH/bad-dest" >/dev/null 2>&1; then ok; else fail "an unknown TOOL_NAMES is refused"; fi

echo "  tests: $passed passed, $failed failed"
[ "$failed" -eq 0 ]
