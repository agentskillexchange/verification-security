# AgentSkill Specification

Version: 1.0

## What Is a Skill?

An agent skill is a structured set of instructions that tells an AI agent:

1. When to activate.
2. What to do.
3. When not to activate.
4. What can go wrong.
5. Which tools, files, services, or permissions are required.

Skills are usually delivered through a `SKILL.md` file loaded into the agent's context.

## Required Sections

| Section | Purpose |
|---------|---------|
| Name | Clear, specific skill name. |
| Description | Trigger-oriented description written for the model. |
| When to Use | Explicit trigger conditions. |
| NOT for | Anti-triggers and out-of-scope cases. |
| Instructions | What the agent should do. |
| Gotchas | Known limitations, risks, and failure modes. |

## Recommended Sections

| Section | Purpose |
|---------|---------|
| Prerequisites | Required tools, keys, services, permissions, or environment variables. |
| Examples | Sample usage or expected interactions. |
| Output Format | Required shape for generated output, if any. |
| References | Docs, related files, or source links. |
| Version | Last updated date or compatibility note. |

## Design Principles

1. Description is for the model, not marketing copy.
2. A skill should have one primary job.
3. Details can live in referenced files when they would bloat the core instructions.
4. Gotchas should help the agent avoid real failure modes.
5. External services and side effects must be explicit.
6. Destructive, public, or irreversible actions require confirmation.

## Reviewability Requirements

Security review depends on evidence that a reviewer can check without inferring hidden intent. A skill is easier to approve, reject, or downgrade consistently when its `SKILL.md` makes these boundaries explicit:

| Boundary | Required evidence in the skill |
|----------|--------------------------------|
| Untrusted content | Identify pages, messages, files, issues, logs, or other inputs that must be treated as data rather than instructions. |
| Tool and permission scope | List the tools, files, services, credentials, and network access the skill needs, plus any common requests it should refuse. |
| External services and data flow | Name each service called and summarize what user or workspace data is sent there. |
| Destructive, public, or irreversible actions | Require explicit confirmation and describe preview, dry-run, rollback, or recovery behavior where available. |
| Dependencies and helper scripts | Point reviewers to source repositories, package metadata, install commands, and any helper code that runs outside the model context. |
| Known limitations | State failure modes, unsafe assumptions, rate limits, and manual follow-ups that affect review decisions. |

These requirements align the skill spec with the repository's scanner checks, human review guide, and trust-label lifecycle. They also map to common secure-development and LLM-risk guidance, especially OWASP LLM risks for prompt injection, sensitive information disclosure, supply chain, insecure plugin design, and excessive agency, plus NIST SSDF practices for tracking security requirements, risks, design decisions, and provenance.

References:

- [OWASP Top 10 for Large Language Model Applications](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [NIST Secure Software Development Framework (SSDF) SP 800-218](https://www.nist.gov/publications/secure-software-development-framework-ssdf-version-11-recommendations-mitigating-risk)
