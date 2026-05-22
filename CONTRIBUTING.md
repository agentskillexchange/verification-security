# Contributing to Agent Skill Exchange Verification & Security

Thanks for helping improve the review process behind Agent Skill Exchange.

## Scope

This repo is for verification, security review, standards, and submission-process documentation. The primary skill catalog lives in [`agentskillexchange/skills`](https://github.com/agentskillexchange/skills).

Open skill additions or skill content changes in the `skills` repo, not here.

## Ways to Contribute

### Improve Review Criteria

Open a PR against `verification/checklist.md` when a criterion is unclear, missing, or no longer matches how skills are reviewed.

### Add Security Guidance

Add concrete risk patterns to `security/review-guide.md` or `security/threat-model.md`. Focus on issues reviewers can actually check, such as prompt injection, data leakage, unsafe tool use, and destructive actions.

### Improve Scanner Checks

Update `security/tools/scan.sh` when a lightweight automated check can catch an issue before human review. Include a short explanation of the risk the check addresses.

### Refine Standards

Use `standards/` for reusable definitions: skill structure, categories, and quality language. Keep marketplace catalog data out of this repo.

## PR Guidelines

- Keep changes focused.
- Explain the practical risk or review benefit.
- Test scanner changes against at least one sample `SKILL.md`.
- Keep public trust language aligned to **Published** and **Security Reviewed**.

## Conduct

Be direct and constructive. Security reviews can be sensitive; focus on the behavior and risk, not the author.
