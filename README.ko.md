# fable-router

[README.md](README.md)

[gpt-5.6-router](https://github.com/volition79/gpt-5.6-router)에서 영감을 받아(inspired by) Claude Code용으로 이식한 스킬. Fable 5(부모)의 토큰을 아끼기 위해 위임 가능한 작업 단계를 Agent 도구의 `model` 오버라이드로 Opus/Sonnet/Haiku에 배정한다.

## 흐름

1. **Gate 1** — PERFORMANCE / BALANCED / TOKEN_SAVER 프로파일 선택 (AskUserQuestion)
2. **읽기 전용 탐색** — Haiku/Sonnet 서브에이전트로 라우팅에 필요한 최소 근거만 수집
3. **라우트 설계** — 단계별 최저 비용 모델 배정, Fable-direct와 비교
4. **Gate 2** — 라우트 명시 승인 후 실행
5. **완료 보고** — 실제 라우트, 검증 결과, 편차, 잔여 리스크

## 원본 대비 변경점

- Sol/Terra/Luna → Fable/Opus·Sonnet/Haiku 역량 플로어로 재매핑
- `spawn_agent` 런타임 분류(A/B/C)·Codex 트러블슈팅 제거 — Claude Code Agent 도구는 `model` 파라미터를 항상 지원
- references/assets 문서를 SKILL.md 하나로 통합

## 설치

```bash
ln -s "$(pwd)" ~/.claude/skills/fable-router
```

이후 `/fable-router`로 호출. 명시 호출 시에만 활성화된다.
