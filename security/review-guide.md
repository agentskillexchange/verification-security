# Security Review Guide

This guide explains how Agent Skill Exchange reviewers evaluate a skill for the **Security Reviewed** label.

For first-pass triage, start with the 10-minute [Reviewer Quickstart](reviewer-quickstart.md).
For label assignment, recheck, and downgrade rules, use the [Trust Label Lifecycle](trust-label-lifecycle.md).

## Review Scope

A security review evaluates a skill for:

1. Prompt injection risk: can untrusted content steer the agent?
2. Data leakage risk: can private data leave the user's environment unexpectedly?
3. Scope creep: does the skill do more than it claims?
4. Destructive or external actions: can the skill cause irreversible or public effects?
5. Credential handling: are secrets handled safely?

## Where Skill Content Lives

Skill submissions and catalog updates belong in [`agentskillexchange/skills`](https://github.com/agentskillexchange/skills). This repo provides the review process and criteria.

## Review Process

1. Read the full `SKILL.md` and any referenced scripts or templates.
2. Run the scanner: `./security/tools/scan.sh /path/to/SKILL.md`.
3. Check the Security Reviewed section in [`../verification/checklist.md`](../verification/checklist.md).
4. Identify all external services, tools, file access, and user-visible side effects.
5. Test risky flows in a sandbox or non-production context when practical.
6. Document findings in the catalog PR, review record, or issue.
7. Approve the **Security Reviewed** label only when risks are understood, disclosed, and appropriately controlled.

## Common Red Flags

Compare borderline cases against the safe and risky [`SKILL.md` review patterns](../examples/review-patterns.md) and the [`Risky Pattern Reference`](../examples/risky-patterns.md).

- The skill tells the agent to follow instructions found in a webpage, email, PDF, issue, or other untrusted content.
- The skill sends user data to an external URL without clearly saying so.
- The skill logs environment variables, tokens, cookies, request headers, or raw private documents.
- The skill grants broad filesystem, browser, messaging, or email access without a specific reason.
- The skill can delete, publish, send, spend, merge, deploy, or change accounts without explicit confirmation.
- The skill hides tool calls, network calls, or side effects behind vague wording.

## Review Outcome

Use one of these outcomes:

- **Needs changes:** security or clarity issues must be fixed before review can pass.
- **Published only:** the skill is acceptable for catalog publishing but has not passed security review.
- **Security Reviewed:** the skill passed the additional security review and can use the public label.

Record enough evidence for another reviewer to reproduce the decision, then apply the lifecycle rules for label changes or downgrades.
