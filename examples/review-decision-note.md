# Review Decision Note Example

Use this note after a reviewer has run the scanner and completed the relevant
manual checks. It is meant for a catalog PR, issue, or review record where the
author needs to see the decision, evidence, and next action without reading the
full evidence packet first.

Keep the note short. Link the fuller evidence packet when a second reviewer
needs to reproduce the decision.

## Template

```markdown
Review outcome: [Needs changes / Published only / Security Reviewed]

Skill reviewed: [path or PR link]
Version reviewed: [commit, tag, or PR SHA]
Scanner result: `[command]` -> [exit code and summary]
Manual checks: [prompt injection, data handling, permissions, side effects, destructive actions]
Risky flow test: [sandbox result, non-production result, or "not run: reason"]
Evidence packet: [link, if available]

Decision:
[One or two sentences explaining why this outcome applies.]

Required follow-up:
- [Specific author action, or "None"]
```

## Security Reviewed Example

```markdown
Review outcome: Security Reviewed

Skill reviewed: examples/scanner-fixtures/safe-minimal-skill.md
Version reviewed: 9108ef9
Scanner result: `security/tools/scan.sh examples/scanner-fixtures/safe-minimal-skill.md` -> exit 0, no issues found
Manual checks: prompt injection, data handling, permissions, side effects, and destructive actions reviewed
Risky flow test: not run; the fixture has no live service calls, destructive actions, or credential handling
Evidence packet: examples/reviewer-evidence-packet.md#passing-packet

Decision:
The reviewed fixture is narrow, local-only, and does not instruct the agent to
follow untrusted content. It can use Security Reviewed as a minimal safe
example.

Required follow-up:
- None for this fixture.
```

## Published Only Example

```markdown
Review outcome: Published only

Skill reviewed: examples/scanner-fixtures/risky-skill.md
Version reviewed: 9108ef9
Scanner result: `security/tools/scan.sh examples/scanner-fixtures/risky-skill.md` -> exit 1, 7 issue(s) found
Manual checks: prompt injection, data handling, permissions, external setup, and destructive actions reviewed
Risky flow test: not run; live execution is not approved for this intentionally risky fixture
Evidence packet: examples/reviewer-evidence-packet.md#blocking-packet

Decision:
The skill can remain a static risky-pattern fixture, but it does not qualify for
Security Reviewed because it includes prompt-following from untrusted content,
raw environment logging, curl-pipe-shell setup, and unconfirmed destructive
actions.

Required follow-up:
- Treat fetched content as data, not instructions.
- Replace raw environment logging with explicit redacted keys.
- Replace curl-pipe-shell setup with a pinned or manually reviewed install path.
- Require explicit confirmation before destructive file actions.
```

## Recheck Example

```markdown
Review outcome: keep Security Reviewed after recheck

Skill reviewed: [path or PR link]
Version reviewed: [new commit]
Prior reviewed version: [old commit]
Scanner result: `[command]` -> [exit code and summary]
Manual checks: changed permissions, data flow, external services, and destructive actions reviewed
Risky flow test: [result or "not run: reason"]
Evidence packet: [link, if available]

Decision:
The diff does not weaken the assumptions recorded in the prior review evidence,
and the new scanner/manual checks did not find new unresolved risk. Keep
Security Reviewed.

Required follow-up:
- Recheck again before keeping Security Reviewed if a future diff changes tool
  access, external services, authentication, data flow, prompt-injection
  handling, or destructive actions.
```

If scanner results, manual checks, or risky-flow evidence are incomplete, use
**Published only** until the missing evidence is supplied.
