# Risky Pattern Reference

Use this reference when scanner output or manual review finds a risky pattern in a `SKILL.md`.
It maps common findings to review decisions and the minimum safeguard expected before a skill can continue toward **Security Reviewed**.

This is not a substitute for the full [Security Review Guide](../security/review-guide.md).

## Pattern Decisions

| Pattern | Why it matters | Typical outcome | Minimum safeguard |
|---------|----------------|-----------------|-------------------|
| Prompt injection | Untrusted pages, emails, PDFs, issues, logs, or model output can try to steer the agent. | **Needs changes** unless instructions clearly isolate untrusted content. | Treat external content as data, ignore embedded instructions, and state which actions are forbidden. |
| Secrets or credentials | Tokens, cookies, headers, environment values, and private config can leak through logs or external calls. | **Needs changes** if raw values can be printed, stored, or sent externally. | Report presence or validation status only; redact values and avoid raw environment dumps. |
| Curl-pipe-shell setup | Piping remote scripts into a shell can execute unaudited code in the user's environment. | **Needs changes** for default setup paths. | Prefer package-manager install, pinned releases, checksums, or manual review before execution. |
| Destructive actions | Delete, publish, deploy, merge, spend, send, wipe, format, or account-changing actions can be irreversible or public. | **Needs changes** if the skill can act without explicit confirmation. | Show a dry-run summary and ask for confirmation before the action. |
| Unsafe logging | Logs can persist private file paths, request bodies, credentials, customer data, or raw tool output. | **Needs changes** if sensitive data is logged by default. | Log only bounded metadata, redact sensitive fields, and document any required debug mode. |

## Review Notes

- A scanner warning is review input, not an automatic rejection.
- A clean scanner result does not prove the skill is safe.
- Borderline cases should stay **Published only** until safeguards and evidence are clear.
- **Security Reviewed** requires the risk to be disclosed, scoped, controlled, and reproducible from the review evidence.

## Reading Scanner Output

Use the scanner output as a triage queue, not a final verdict.

| Output type | Reviewer action |
|-------------|-----------------|
| `FAIL` | Stop the review path until the author removes the risky instruction or adds a concrete safeguard reviewers can reproduce. |
| `WARN` | Request a bounded change when the missing section or risky behavior affects when the skill should run, what it can change, or what it can expose. |
| `INFO` | Verify the URL, dependency, or external touchpoint is intentional, documented, and appropriate for the skill's scope. |
| Line evidence | Check the cited line first, then scan the surrounding section for whether the skill also states a safe alternative. |

When multiple findings appear, resolve `FAIL` items before spending review time on section polish. A skill should not advance to **Security Reviewed** while hardcoded credentials, prompt-following instructions from untrusted content, or unconfirmed destructive actions remain unresolved.

Use the companion [Review Patterns](review-patterns.md) for small safe/risky snippets and the [risky scanner fixture](scanner-fixtures/risky-skill.md) to see the scanner's expected warning coverage.
