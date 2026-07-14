# fable-router

[README.ko.md](README.ko.md)

Inspired by [gpt-5.6-router](https://github.com/volition79/gpt-5.6-router), ported to Claude Code. Saves Fable 5 (parent) tokens by routing delegable work stages to Opus/Sonnet/Haiku via the Agent tool's `model` override.

## Flow

1. **Gate 1** — pick a PERFORMANCE / BALANCED / TOKEN_SAVER profile (AskUserQuestion)
2. **Read-only discovery** — Haiku/Sonnet subagents gather only the minimum evidence needed to route
3. **Route design** — assign the lowest-cost capable model per stage, compare against Fable-direct
4. **Gate 2** — explicit route approval, then execution
5. **Completion report** — actual route, validation results, deviations, residual risk

## Changes from the original

- Sol/Terra/Luna remapped to Fable / Opus·Sonnet / Haiku capability floors
- Removed `spawn_agent` runtime classification (A/B/C) and Codex troubleshooting — the Claude Code Agent tool always supports the `model` parameter
- Merged references/assets docs into a single SKILL.md

## Install

```bash
ln -s "$(pwd)" ~/.claude/skills/fable-router
```

Then invoke with `/fable-router`. Activates only on explicit invocation.
