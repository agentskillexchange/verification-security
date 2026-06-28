# Agent Skill Exchange Verification & Security

> Public verification, security review, and skill quality process for [Agent Skill Exchange](https://agentskillexchange.com).

[![Marketplace](https://img.shields.io/badge/Marketplace-AgentSkillExchange.com-6366f1)](https://agentskillexchange.com)
[![Primary Catalog](https://img.shields.io/badge/Primary%20Catalog-agentskillexchange%2Fskills-blue)](https://github.com/agentskillexchange/skills)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## What This Repo Is

This repo documents how Agent Skill Exchange reviews skill submissions, evaluates security risk, and keeps its public trust language consistent.

It is intentionally a process repo. The primary catalog, skill source files, generated indexes, and day-to-day marketplace data live in [`agentskillexchange/skills`](https://github.com/agentskillexchange/skills).

Use this repo for:

- Verification and security review criteria
- Reviewer checklists and threat-model guidance
- Skill quality standards
- Submission templates and self-review guidance
- Lightweight scanning tools used before human review

Do not use this repo as the canonical skill catalog. Link to the `skills` repo for marketplace content.

## Trust Labels

Agent Skill Exchange uses two public trust labels:

| Label | Meaning |
|-------|---------|
| **Published** | The skill is listed in the catalog and has passed basic publishing checks. |
| **Security Reviewed** | The skill has passed additional security review for scope, data handling, prompt-injection risk, and destructive actions. |

Older internal terms such as `listed` or `verified_metadata` should be mapped to **Published** in public-facing docs and UI.

## Repository Structure

```
/
├── verification/
│   └── checklist.md          # Publishing and security-review checklist
│
├── security/
│   ├── review-guide.md       # How to conduct a security review
│   ├── reviewer-quickstart.md # 10-minute reviewer triage guide
│   ├── trust-label-lifecycle.md # Trust label assignment and downgrade rules
│   ├── threat-model.md       # Threat model for agent skills
│   └── tools/
│       └── scan.sh           # Basic automated scan script
│
├── examples/
│   └── review-patterns.md    # Safe and risky SKILL.md review patterns
│
├── standards/
│   ├── skill-spec.md         # AgentSkill specification
│   └── categories.md         # Skill category taxonomy
│
├── submission/
│   └── SKILL_TEMPLATE.md     # Standard SKILL.md template
│
└── CONTRIBUTING.md
```

## Quick Start

Run a self-review before submitting or updating a skill:

```bash
git clone https://github.com/agentskillexchange/verification-security.git
cd verification-security

cat verification/checklist.md
./security/tools/scan.sh /path/to/your/SKILL.md
```

The scanner is a first pass only. A clean scan does not guarantee that a skill is safe; it helps reviewers catch obvious issues before deeper review.

Reviewers can start with the 10-minute [`Reviewer Quickstart`](security/reviewer-quickstart.md), compare against the [`Review Patterns`](examples/review-patterns.md), then use the full [`Security Review Guide`](security/review-guide.md), [`Verification Checklist`](verification/checklist.md), and [`Trust Label Lifecycle`](security/trust-label-lifecycle.md) for final decisions.

## Submitting Skills

Submit and maintain skill content in the primary catalog repo:

<https://github.com/agentskillexchange/skills>

Use [`submission/SKILL_TEMPLATE.md`](submission/SKILL_TEMPLATE.md) as a starting point, and use [`verification/checklist.md`](verification/checklist.md) before opening a catalog PR.

## Contributing

Contributions are welcome when they improve the review process:

- New security checks
- Clearer review criteria
- Better examples of risky skill behavior
- Improvements to the scanner
- Taxonomy refinements that help review consistency

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT.
