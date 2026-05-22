# Agent Skill Verification Checklist

Use this checklist before submitting a skill to Agent Skill Exchange or requesting security review.

Public trust labels are limited to **Published** and **Security Reviewed**. This checklist separates basic publishing readiness from the additional security review required for the Security Reviewed label.

## Published Readiness

### Identity and Description

- [ ] Skill has a clear, specific name, not a generic name such as "Helper Skill".
- [ ] `description` explains when the AI model should use the skill.
- [ ] The description is trigger-oriented and concise.
- [ ] The skill has at least one concrete use case.

### SKILL.md Structure

- [ ] File is valid Markdown.
- [ ] Trigger conditions are explicit.
- [ ] Anti-triggers or out-of-scope cases are explicit.
- [ ] Gotchas, limitations, or failure modes are documented.
- [ ] Instructions are clear enough for an agent to follow without guessing.

### Operational Requirements

- [ ] Required tools, API keys, services, or environment variables are listed.
- [ ] Setup steps are documented or linked.
- [ ] Expected inputs and outputs are clear.
- [ ] The skill has a single primary responsibility.
- [ ] No hardcoded credentials or personal environment paths are present.

### Catalog Fit

- [ ] Category and tags match the skill's actual purpose.
- [ ] The skill does not duplicate an existing catalog skill without a clear reason.
- [ ] Source or upstream links are included when available.

## Security Reviewed

Security Reviewed skills must satisfy the Published readiness checks plus the items below. See [`../security/review-guide.md`](../security/review-guide.md) for reviewer workflow.

### Prompt Injection

- [ ] External or user-provided content is treated as data, not instructions.
- [ ] The skill does not tell the agent to follow instructions found inside untrusted content.
- [ ] The skill includes guidance for separating source content from agent instructions when applicable.
- [ ] The skill does not execute arbitrary code copied from external sources.

### Data Handling

- [ ] Data sent to external services is disclosed.
- [ ] PII or sensitive-data handling is documented when relevant.
- [ ] Secrets, tokens, cookies, and environment values are never logged or echoed.
- [ ] Outputs avoid exposing private source content unless the user explicitly asked for it.

### Scope and Permissions

- [ ] Requested permissions are necessary for the skill's purpose.
- [ ] File, network, browser, email, or messaging access is scoped and justified.
- [ ] Destructive or external actions require explicit confirmation.
- [ ] The skill does not modify systems outside its declared scope.

### Tool Use

- [ ] Tools and APIs called by the skill are documented.
- [ ] External calls are intentional and reviewable.
- [ ] Rate limits, authentication failures, and partial failures are handled or documented.
- [ ] The skill avoids silent side effects.

### Review Evidence

- [ ] Automated scan was run with `security/tools/scan.sh`.
- [ ] Reviewer manually inspected the full skill instructions.
- [ ] Reviewer tested risky flows in a sandbox or non-production context when practical.
- [ ] Findings and review decision are documented in the relevant catalog PR or review record.
