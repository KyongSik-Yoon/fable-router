#!/bin/sh
# fable-router auto mode: while the flag file exists, tell the parent turn to
# route through the skill. No flag means auto mode is off, so exit silently and
# inject nothing — the hook costs one stat() per prompt in that case.
[ -f "${HOME}/.claude/fable-router-auto" ] || exit 0

# Keep additionalContext to a couple of lines: it is a fixed per-turn cost, and
# the routing policy itself lives in SKILL.md, loaded only once the skill runs.
cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "fable-router auto mode is ON. Treat this turn as an explicit /fable-router invocation and invoke the fable-router skill to route it. Exception: if the turn is trivial or conversational — a question about earlier context, an acknowledgement, a single small edit, anything one Fable turn finishes sooner than building a route would — answer directly without routing and without mentioning the router."
  },
  "suppressOutput": true
}
JSON
