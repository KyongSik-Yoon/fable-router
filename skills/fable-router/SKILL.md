---
name: fable-router
description: Save Fable 5 usage by routing explicitly requested work across Claude models (Fable 5, Opus, Sonnet, Haiku) via the Agent tool's model override, using a user-selected PERFORMANCE, BALANCED, or TOKEN_SAVER profile. Fable owns design direction, architecture, adversarial review, and final judgment; cheaper models do capability-matched stages. Use only when the user explicitly invokes /fable-router or directly asks for the Fable 5 model router. Do not invoke implicitly for ordinary tasks.
---

# Fable 5 Model Router

Exploit each Claude model's strengths so Fable 5 (the parent, most expensive tier) spends tokens only where its judgment is irreplaceable. The parent stays orchestrator and integrator; subagents perform only capability-matched stages that justify their overhead.

## Activation

Activate only on explicit invocation. Before the first user selection, use only the request and existing conversation context — no file reads, commands, or agents.

## Gate 1: Choose An Objective

Present these profiles with a task-specific one-line tradeoff, using AskUserQuestion:

1. **PERFORMANCE** — maximize correctness, depth, independent validation; may use more tokens/time.
2. **BALANCED** — preserve required quality while minimizing duplicate context and unnecessary agents. Recommend by default.
3. **TOKEN_SAVER** — minimize non-required Fable output: delegate every delegable stage to the cheapest capable model, keep parent turns short, preserve Fable-owned design/judgment and safety floors.

Alongside the choices, state the minimum read-only discovery needed to route accurately. Profile selection authorizes only that discovery. If the task is fully specified and discovery is unnecessary, say so.

## Read-Only Discovery

After Gate 1, inspect only the approved evidence to identify: independent vs coupled stages; ambiguity, consequence of error, repetition, verification burden; available deterministic validators (tests, linters, typecheckers); likely context duplication vs orchestration overhead.

Use Explore/cavecrew-investigator subagents (model: haiku or sonnet) for this discovery so raw file dumps never enter the parent context. No writes, no implementation agents.

## Build The Adaptive Route

1. Express the task as a small dependency graph: analysis, research, design, implementation, deterministic transformation, verification, final judgment — as applicable.
2. For any user-facing product/UI work, decide whether a design stage exists. If so, assign design direction and subjective design acceptance to Fable (the parent, in-context — never a subagent's guess).
3. Assign the lowest-cost model that satisfies each remaining stage's capability and risk floor.
4. The parent Fable is already an active capability — do not duplicate its planning or integration in a subagent unless independent review has explicit value.
5. Prefer one agent. Add agents only for: independent evidence, disjoint parallel work, deterministic volume, or consequential independent review.
6. Keep context packets narrow: each subagent gets only its role contract, objective, required evidence (file paths, not dumps), allowed write surface, non-goals, validation command, and output shape.
7. Escalate Haiku → Sonnet → Opus → Fable when ambiguity, failed validation, conflicting evidence, or higher consequence appears. One escalation retry per stage before pulling the stage back into the parent.
8. Compare the route with Fable-direct. If delegation lacks a credible advantage for the selected profile, recommend Fable-direct and say why.

Mechanics: spawn via the Agent tool with an explicit `model` parameter (`haiku`, `sonnet`, `opus`; omit = inherit Fable — never omit for a routed stage). Use `subagent_type` that fits the stage: `Explore` for search, `general-purpose` for implementation, `caveman:cavecrew-*` when their scope fits (their compressed output further cuts parent input tokens). Parallel independent stages go in one message. Use `isolation: "worktree"` only when agents mutate files in parallel.

## Capability Floors

- **Fable (parent)**: design/UX/art direction and subjective acceptance, ambiguous planning, architecture, high-consequence changes, adversarial review, final judgment, integration.
- **Opus**: complex implementation, cross-file refactors, tricky debugging, independent second-opinion review when consequence is high.
- **Sonnet**: standard implementation of an approved plan, exploration/research synthesis, test writing, evidence gathering, moderate-difficulty fixes.
- **Haiku**: deterministic extraction, normalization, mechanical renames/conversions, repetitive transformation with objective checks, bulk file scanning.

Never assign Haiku: source-of-truth selection, design decisions, architecture, ambiguity resolution, destructive decisions, or final sufficiency review. Profiles may reduce context or duplicate review — never the Fable design/judgment floor.

## Estimate Effects Honestly

Report Fable-direct-relative estimates for output quality, elapsed time, token cost, and regression risk using directional values (`lower`/`similar`/`higher`) plus evidence and uncertainty. Use numbers only from measured history or deterministic workload counts. If usage is not observable, say `not observable` — never invent savings.

## Gate 2: Approve Execution

Present one recommended route (compact alternative only if it has a genuinely different tradeoff):

- selected profile;
- stages: role, model, subagent_type, order, expected deliverable, validation per stage;
- Fable-direct comparison and estimate confidence;
- external/destructive actions that remain separately approval-gated.

Wait for explicit approval (AskUserQuestion). Profile selection is not execution approval. After approval, spawn only the approved roles; tactical changes within approved scope/models/risk need no reapproval, but model, scope, permission, or risk changes do.

## Safety Invariants

- Routing approval does not bypass normal permission prompts.
- Delegation depth stays at one; subagents must not spawn descendants.
- Never silently substitute a model; pause and reapprove.
- Do not expose secrets in plans, handoffs, or subagent prompts.

## Completion

The parent integrates all results and reports: actual route taken, validation results, deviations from the approved route, and residual risk. Subagent completion alone is not task completion.
