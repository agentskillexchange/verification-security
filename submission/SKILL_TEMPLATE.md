# [Skill Name]

> One-sentence trigger-oriented description of when an AI agent should use this skill.

## When to Use

Use this skill when:

- [Trigger condition 1]
- [Trigger condition 2]
- [Trigger condition 3]

Example trigger phrases: "[example phrase]", "[example phrase 2]"

## NOT for

Do not use this skill for:

- [Anti-trigger 1]
- [Anti-trigger 2]
- [Situation where a different skill or manual review is required]

## Prerequisites

Before using this skill, ensure:

- [ ] [Required tool or API key]
- [ ] [Required environment variable: `MY_API_KEY`]
- [ ] [Required software or service access]

## Instructions

[Describe what the agent should do, step by step. Keep the main instructions concise. Move long references, examples, schemas, or provider-specific details into separate files when useful.]

## Safety and Permissions

- External services used: [list or "none"]
- Data sent externally: [describe or "none"]
- Destructive actions: [describe confirmation requirements or "none"]
- Required user confirmation: [when the agent must ask first]

## Submission Self-Review

Before submitting this skill for Agent Skill Exchange review, complete the checks below.

- [ ] The trigger and anti-trigger sections clearly explain when the skill should and should not run.
- [ ] Every referenced script, template, asset, API, browser action, file action, and external service is listed above or in References.
- [ ] Required secrets, tokens, cookies, or private URLs are named as placeholders only; no real values are included.
- [ ] Data sent to external services is minimized and described in plain language.
- [ ] Destructive, irreversible, or production-affecting actions require explicit user confirmation.
- [ ] Each new live-system action names its target, the required confirmation, non-production validation, and rollback path with an owner.
- [ ] Prompt-injection risk from web pages, documents, user files, or third-party content is handled with clear boundaries.
- [ ] Claims about APIs, models, packages, platforms, permissions, or security controls are backed by official docs, registry/source links, release notes, or checked implementation evidence.
- [ ] Long provider docs, schemas, generated outputs, or examples are kept in separate files instead of crowding the main instructions.
- [ ] `security/tools/scan.sh` was run against this `SKILL.md`, and any warnings are either fixed or documented for reviewer follow-up.

### Live-System Action Boundary (if applicable)

For each new production, customer-facing, or persistent-system action, record
the evidence a reviewer needs before treating it as eligible for **Security
Reviewed**:

- Target and action: [named environment, service, data store, or account and exact change]
- Explicit confirmation: [the user-visible approval required immediately before the live action]
- Non-production validation: [command or test, observed result, and where it ran]
- Monitoring and stop condition: [what is watched after the action and when to stop or escalate]
- Rollback: [what state is restored, command or procedure, and accountable owner]
- Customer-data or secret boundary: [what is accessed or changed, or "none"]

Link the completed record from the review decision note. A passing staging test
or a planned rollback alone does not prove that a live action is safe to
approve. See [`examples/production-boundaries.md`](../examples/production-boundaries.md)
for a completed reviewer-facing recheck record.

### Remote Setup or Transport Fallback (if applicable)

If this skill downloads code, installs a helper, or calls an external service,
record the safe path when that step cannot be verified:

- Normal path: [pinned artifact, package version, or documented endpoint]
- Failure boundary: [when the skill must stop instead of retrying or bypassing a check]
- Safe alternative: [download a pinned artifact, verify its checksum or signature, and review it before execution; or defer the action]
- Transport boundary: [keep certificate verification enabled; repair the trust configuration or obtain a reviewed, narrowly scoped pinning approach]
- Evidence for the alternative: [registry/source URL, checksum or signature, reviewer/owner, and date checked]

Do not substitute a remote shell execution path or a TLS-verification bypass for
this evidence. See [`examples/risky-patterns.md`](../examples/risky-patterns.md)
for the reviewer decision boundary.

### External-Service Data Boundary (if applicable)

If the skill sends user, workspace, or session-derived data to an external
service, record the minimum necessary transfer and its lifecycle:

- Data fields and purpose: [each field or document excerpt, and why the service needs it]
- Minimization and redaction: [fields omitted, masked, or summarized before transfer]
- Destination and access: [named service, account/workspace, and who can access the result]
- Retention and deletion: [documented retention behavior or configured setting; deletion path, owner, and expected completion]
- Evidence and unresolved limits: [provider documentation, configuration/result, date checked, and any unknown retention or deletion behavior]

Do not describe a service as retaining or deleting data when that behavior has
not been verified. Treat an unknown data destination, retention period, or
deletion path as reviewer follow-up; request **Published only** or **unsure**
until the evidence supports **Security Reviewed**.

### External Dependency Evidence (if applicable)

For each package, provider API, model, helper, or service whose documented
behavior changes the skill's safe path, record evidence a second reviewer can
reproduce:

- Dependency and purpose: [name and the exact capability the skill relies on]
- Resolved version or identifier: [package version, API version, model ID, release, or commit]
- Authoritative source: [official documentation, registry, release artifact, or source URL]
- Source checked: [date checked and the specific behavior or limit it supports]
- Observed bounded behavior: [non-production command or test, result, and environment]
- Difference or unresolved limit: [where observed behavior differs from the source, or "none"]
- Review impact: [why this evidence supports or blocks the requested label]

Do not infer behavior from a package name, a search result, a blog post, or a
successful install. If the version cannot be identified, the source does not
support the relied-on behavior, or the bounded observation conflicts with the
source, record that limit and request **Published only**, **Needs changes**, or
reviewer follow-up as appropriate. See
[`examples/source-backed-verification.md`](../examples/source-backed-verification.md)
for evidence-selection and conflict guidance.

Requested review outcome: [Published only / Security Reviewed / unsure]
Use **Published only** when the skill is ready for catalog listing but security evidence is incomplete, **Security Reviewed** only when the scanner/manual/source-backed evidence below is complete, and **unsure** when you need a reviewer to classify the risk first.
Evidence for Security Reviewed, if requested: [scanner result, manual review notes, fixture output, or other evidence]

Author-provided evidence packet:

Fill this in before review; reviewers can copy the completed evidence into a review record or decision note instead of reconstructing it. If any Security Reviewed evidence item is missing or unverified, request **Published only** or **unsure** and name the missing evidence in `Follow-up needed`.

- Scanner command and result: [`security/tools/scan.sh path/to/SKILL.md`, exit code, unresolved findings]
- Source-backed claims checked: [API/model/package/platform/permission/security-control claims, source checked, and unsupported parts, or "none"]
- Manual checks completed: [prompt injection / data handling / permissions / destructive actions / external services; for a live-system action, target, confirmation, non-production validation, rollback path, and owner]
- Risky flow tested, if applicable: [sandbox or non-production evidence, or "not applicable"]
- Follow-up needed: [open questions, owner, and blocking status, or "none"]

See [`examples/reviewer-evidence-packet.md`](../examples/reviewer-evidence-packet.md) for a filled example.

## Usage Examples

```
[Example command or interaction 1]
```

```
[Example command or interaction 2]
```

## Gotchas & Known Limitations

- **[Issue 1]:** [Description and workaround]
- **[Issue 2]:** [Description and workaround]
- Rate limits: [Any relevant rate limits from external APIs]
- [Edge case or known failure mode]

## References

- [Link to documentation]
- [Link to related skill or source]
