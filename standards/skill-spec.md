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
