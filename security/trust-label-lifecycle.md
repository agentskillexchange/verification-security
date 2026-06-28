# Trust Label Lifecycle

Agent Skill Exchange uses two public trust labels:

- **Published** means the skill is listed in the catalog and passed basic publishing checks.
- **Security Reviewed** means the skill also passed additional review for scope, data handling, prompt-injection risk, permissions, and destructive actions.

Use this page when assigning, keeping, or downgrading a public label. Older internal terms such as `listed` or `verified_metadata` should be mapped to **Published** in public-facing docs and UI.

## Label Flow

| Stage | Result | Evidence expected |
|-------|--------|-------------------|
| New submission | No public label yet | Skill source path, author or source repo, and intended use case. |
| Publishing review passed | **Published** | Completed Published readiness checklist, no hardcoded secrets, clear scope, and catalog fit. |
| Security review passed | **Security Reviewed** | Scanner result, manual review notes, risky-flow test notes when practical, and final reviewer decision. |
| Material change | Recheck label | Diff or PR link, changed files, and reviewer note explaining whether the current label still applies. |
| Risk found after publishing | Downgrade or remove label | Issue or PR link, affected skill version, reason, and required remediation. |

## When to Keep a Label

Keep **Published** when the skill remains clear, scoped, catalog-ready, and free of obvious secrets or broken instructions.

Keep **Security Reviewed** only when changes do not weaken the reviewed assumptions. Recheck the label after any change to tool access, external services, prompt-injection handling, destructive actions, authentication, or data flow.

## Downgrade Reasons

Downgrade **Security Reviewed** to **Published** when:

- A new tool, API, browser, file, email, messaging, or network action has not been reviewed.
- Prompt-injection controls are weakened or removed.
- Data sent to external services is no longer disclosed clearly.
- Destructive or public actions no longer require explicit confirmation.
- Reviewer evidence is missing for a material change.

Remove or withhold **Published** when:

- The skill is too vague to review.
- Required setup, secrets, side effects, or external dependencies are hidden.
- Hardcoded credentials, tokens, private URLs, cookies, or personal paths are present.
- The skill's purpose does not match its category, description, or trigger conditions.

## Evidence Format

Record enough detail for another reviewer to reproduce the decision:

```text
Skill:
Version or PR:
Scanner command:
Scanner result:
Manual checks:
Risky-flow test:
Decision:
Follow-up:
```

If a field is not applicable, write `not applicable` and explain why. Do not paste secrets, raw tokens, cookies, or private user data into review evidence.
