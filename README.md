# fable-router

[README.ko.md](README.ko.md)

Inspired by [gpt-5.6-router](https://github.com/volition79/gpt-5.6-router), ported to Claude Code. Saves Fable 5 (parent) tokens by routing delegable work stages to Opus/Sonnet/Haiku via the Agent tool's `model` override.

## Flow

1. **Gate 1** — pick a PERFORMANCE / BALANCED / TOKEN_SAVER profile (AskUserQuestion)
2. **Read-only discovery** — Haiku/Sonnet subagents gather only the minimum evidence needed to route
3. **Route design** — assign the lowest-cost capable model and lowest safe reasoning effort per stage, compare against Fable-direct
4. **Gate 2** — explicit route approval, then execution
5. **Completion report** — actual route, validation results, deviations, residual risk

## Changes from the original

- Sol/Terra/Luna remapped to Fable / Opus·Sonnet / Haiku capability floors
- Removed `spawn_agent` runtime classification (A/B/C) and Codex troubleshooting — the Claude Code Agent tool always supports the `model` parameter
- Merged references/assets docs into a single SKILL.md
- Added effort routing: the Agent tool has no per-call effort parameter, so the plugin ships `worker-low` / `worker-medium` / `worker-high` agent definitions (`agents/`) and routes effort by `subagent_type`, composing freely with the `model` override

## Install

### Claude Code (plugin marketplace)

```
/plugin marketplace add KyongSik-Yoon/fable-router
/plugin install fable-router@fable-router
```

### Manual (any Claude Code checkout)

```bash
git clone https://github.com/KyongSik-Yoon/fable-router
ln -s "$(pwd)/fable-router/skills/fable-router" ~/.claude/skills/fable-router
# effort-variant worker agents (skip if you only want model routing)
for f in fable-router/agents/*.md; do ln -s "$(pwd)/$f" ~/.claude/agents/; done
```

Note: the manual install registers workers as `worker-low` etc. (no `fable-router:` prefix); the plugin install is the documented path.

### Claude Desktop / claude.ai

Upload the `skills/fable-router` folder (or a zip of it) in Settings → Capabilities → Skills.

Then invoke with `/fable-router`. Activates only on explicit invocation.
