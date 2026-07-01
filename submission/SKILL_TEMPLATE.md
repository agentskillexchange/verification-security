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
- [ ] Prompt-injection risk from web pages, documents, user files, or third-party content is handled with clear boundaries.
- [ ] Long provider docs, schemas, generated outputs, or examples are kept in separate files instead of crowding the main instructions.
- [ ] `security/tools/scan.sh` was run against this `SKILL.md`, and any warnings are either fixed or documented for reviewer follow-up.

Requested review outcome: [Published only / Security Reviewed / unsure]
Evidence for Security Reviewed, if requested: [scanner result, manual review notes, fixture output, or other evidence]

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
