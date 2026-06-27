# Reviewer Quickstart

Use this 10-minute pass when you need to decide whether a skill is ready for basic catalog publishing, needs changes, or should receive deeper security review.

This is a triage guide, not a replacement for the full [Security Review Guide](review-guide.md).

## 1. Confirm Scope

- Read the skill name, description, and trigger conditions.
- Identify the primary job the skill claims to do.
- Note every referenced script, template, service, API, browser action, file action, or external system.
- Stop if the skill cannot be understood without guessing; mark it **Needs changes**.

## 2. Run the Scanner

From this repo:

```bash
./security/tools/scan.sh /path/to/SKILL.md
```

Treat scanner output as review input:

- Warnings mean the reviewer should inspect the area manually.
- Failures usually require a change before the skill can be labeled **Security Reviewed**.
- A clean scan does not prove the skill is safe.

## 3. Check the Highest-Risk Questions

If a case is hard to classify, compare it with the safe and risky [`SKILL.md` review patterns](../examples/review-patterns.md).

Ask these before spending time on polish:

- Does the skill tell the agent to follow instructions from webpages, emails, PDFs, issues, logs, or other untrusted content?
- Can it send private user data, credentials, cookies, or raw environment values to an external service?
- Can it delete, publish, deploy, spend money, send messages, merge code, or change accounts?
- Does it request broad filesystem, browser, email, network, or messaging access without a specific reason?
- Are any setup steps, required secrets, or user-visible side effects hidden or vague?

If the answer is yes and the skill does not include clear safeguards, mark it **Needs changes**.

## 4. Pick the Review Outcome

Use one outcome and write a short reason:

| Outcome | Use when |
|---------|----------|
| **Needs changes** | The skill is unclear, overbroad, risky, or missing required disclosure. |
| **Published only** | The skill is suitable for catalog listing but has not passed deeper security review. |
| **Security Reviewed** | Risks are understood, disclosed, scoped, and controlled according to the full checklist. |

## 5. Record Evidence

Include enough evidence for another reviewer to reproduce the decision:

- Skill path and commit or PR.
- Scanner command and result.
- Manual notes for prompt injection, data handling, permissions, side effects, and destructive actions.
- Any sandbox test performed for risky flows.
- Final outcome and required follow-up.

For the full criteria, continue with the [verification checklist](../verification/checklist.md) and [security review guide](review-guide.md).
