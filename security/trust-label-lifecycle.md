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

## Classify a Change Before Reusing a Label

Use this small decision table before copying a prior label into a new version.
It distinguishes an editorial update from a change that can alter what an
agent does, what it can access, or which evidence supports the decision.

| Change in the submitted skill or its references | Recheck action | Label handling |
|---|---|---|
| Spelling, formatting, or a documentation link that does not support a behavior claim | Record the reviewed diff; no repeated scanner or manual pass is normally needed. | Keep the prior label if the reviewer confirms the operational instructions did not change. |
| Trigger, anti-trigger, instruction, confirmation wording, or declared permission changes | Rerun the scanner and repeat the manual checks affected by the changed behavior. | Keep **Security Reviewed** only when the new boundary is supported by the recheck evidence. |
| Helper, package, model, API, endpoint, credential scope, or external-service configuration changes | Inspect the resolved version or configuration, refresh decision-critical source evidence, and repeat a bounded non-production test when the change can affect external state or private data. | Downgrade to **Published** while evidence is incomplete; use **Needs changes** if the changed behavior is unsafe or undisclosed. |
| A decision-critical provider document, policy, release, registry record, or hosted helper changes while the skill text does not | Compare the current source with the reviewed source and record the effect on the claim. | Do not rely on an unchanged skill version alone; recheck or temporarily downgrade until the claim remains supported. |
| The reviewer cannot determine whether a referenced artifact or source changed | Request the resolved artifact, version, or source snapshot needed to compare it. | Keep **Published** only for an otherwise clear, safely listable skill; use **Needs changes** when the unknown blocks a required safeguard. |

When the table calls for a recheck, use the evidence fields below and link the
resulting decision note. A clean scanner alone is not enough to keep
**Security Reviewed** after a behavior, dependency, source, or data-boundary
change.

## Recheck Evidence

When a material change keeps a skill at **Security Reviewed**, record evidence that compares the new version to the reviewed version:

- Changed files or PR diff reviewed.
- Scanner command and result from the changed version.
- Manual checks repeated for any changed tool, API, browser, file, email, messaging, network, authentication, data-flow, prompt-injection, or destructive-action behavior.
- Source-backed checks refreshed for any changed API, model, package, platform, permission, or security-control claim that affects the label decision.
- Risky-flow test repeated in a sandbox or non-production context when the changed behavior can affect external systems, private data, money, publishing, deployment, deletion, or account state.
- Decision note explaining why the prior label still applies, or why the skill is downgraded to **Published** until evidence is complete; use the copyable [Recheck Example](../examples/review-decision-note.md#recheck-example) when the change affects manual-risk evidence.

If the change removes or weakens prior review evidence, downgrade first and restore **Security Reviewed** only after the missing evidence is replaced.

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

## Temporary Downgrade or Remediation

Use **Published** for a temporary downgrade when the skill remains clear and
suitable for catalog use, but a material change has incomplete recheck
evidence. Record the missing scanner, manual, source-backed, or
non-production-test evidence and request a fresh **Security Reviewed**
decision after it is supplied.

Use **Needs changes** instead when the changed skill itself is unclear, unsafe,
or missing a required safeguard, disclosure, correction, or reviewable
provenance. In that case, name the remediation in the review record before the
skill can pass again. For copyable record shapes, use the
[Downgrade To Recheck Example](../examples/review-decision-note.md#downgrade-to-recheck-example)
for the first case and the
[Needs Changes Follow-up Example](../examples/review-decision-note.md#needs-changes-follow-up-example)
for the second.

## Evidence Format

Record enough detail for another reviewer to reproduce the decision:

```text
Skill:
Version or PR:
Scanner command:
Scanner result:
Manual checks:
Source-backed claim recheck:
Risky-flow test:
Decision:
Follow-up:
```

If a field is not applicable, write `not applicable` and explain why. Do not paste secrets, raw tokens, cookies, or private user data into review evidence.
