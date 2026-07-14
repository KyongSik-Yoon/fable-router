# fable-router

[README.md](README.md)

[gpt-5.6-router](https://github.com/volition79/gpt-5.6-router)에서 영감을 받아(inspired by) Claude Code용으로 이식한 스킬. Fable 5(부모)의 토큰을 아끼기 위해 위임 가능한 작업 단계를 Agent 도구의 `model` 오버라이드로 Opus/Sonnet/Haiku에 배정한다.

## 흐름

1. **Gate 1** — PERFORMANCE / BALANCED / TOKEN_SAVER 프로파일 선택 (AskUserQuestion)
2. **읽기 전용 탐색** — Haiku/Sonnet 서브에이전트로 라우팅에 필요한 최소 근거만 수집
3. **라우트 설계** — 단계별 최저 비용 모델과 안전한 최저 reasoning effort 배정, Fable-direct와 비교
4. **Gate 2** — 라우트 명시 승인 후 실행
5. **완료 보고** — 실제 라우트, 검증 결과, 편차, 잔여 리스크

## 원본 대비 변경점

- Sol/Terra/Luna → Fable/Opus·Sonnet/Haiku 역량 플로어로 재매핑
- `spawn_agent` 런타임 분류(A/B/C)·Codex 트러블슈팅 제거 — Claude Code Agent 도구는 `model` 파라미터를 항상 지원
- references/assets 문서를 SKILL.md 하나로 통합
- effort 라우팅 추가: Agent 도구에는 호출별 effort 파라미터가 없어, 플러그인이 `worker-low` / `worker-medium` / `worker-high` 에이전트 정의(`agents/`)를 제공하고 `subagent_type`으로 effort를, `model` 오버라이드로 모델을 조합해 라우팅

## 설치

### Claude Code (플러그인 마켓플레이스)

```
/plugin marketplace add KyongSik-Yoon/fable-router
/plugin install fable-router@fable-router
```

### 수동 설치

```bash
git clone https://github.com/KyongSik-Yoon/fable-router
ln -s "$(pwd)/fable-router/skills/fable-router" ~/.claude/skills/fable-router
# effort 변형 워커 에이전트 (모델 라우팅만 쓸 거면 생략 가능)
for f in fable-router/agents/*.md; do ln -s "$(pwd)/$f" ~/.claude/agents/; done
```

참고: 수동 설치 시 워커는 `fable-router:` 접두사 없이 `worker-low` 등으로 등록된다. 플러그인 설치가 문서화된 기본 경로.

### Claude Desktop / claude.ai

설정 → Capabilities → Skills에서 `skills/fable-router` 폴더(또는 zip)를 업로드.

이후 `/fable-router`로 호출. 명시 호출 시에만 활성화된다.
