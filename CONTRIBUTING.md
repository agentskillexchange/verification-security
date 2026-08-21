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

### Improve Submission Evidence

Update `submission/SKILL_TEMPLATE.md` when authors need clearer evidence prompts for **Security Reviewed** requests. Keep those prompts aligned with `examples/reviewer-evidence-packet.md` so reviewers can turn submitted scanner results, source-backed claim checks, manual checks, risky-flow evidence, and open follow-ups into one review record.

### Refine Standards

Use `standards/` for reusable definitions: skill structure, categories, and quality language. Keep marketplace catalog data out of this repo.

## PR Guidelines

- Keep changes focused.
- Explain the practical risk or review benefit.
- Test scanner changes against at least one sample `SKILL.md`.
- Keep public trust language aligned to **Published** and **Security Reviewed**.

## Before Opening a PR

Run the checks that match the files you changed:

```bash
bash -n security/tools/scan.sh
bash -n security/tools/test_scan.sh
git diff --check
./security/tools/test_scan.sh
./security/tools/scan.sh submission/SKILL_TEMPLATE.md
./security/tools/scan.sh examples/scanner-fixtures/safe-minimal-skill.md
./security/tools/scan.sh examples/scanner-fixtures/risky-skill.md
```

The intentionally risky fixture should exit with status `1` and report the
expected findings. Do not weaken that fixture to make the test pass; update the
expected output only when the scanner behavior intentionally changes.

## Conduct

Be direct and constructive. Security reviews can be sensitive; focus on the behavior and risk, not the author.
