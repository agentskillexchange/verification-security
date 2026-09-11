# Review Decision Note Example

Use this note after a reviewer has run the scanner and completed the relevant
manual checks. It is meant for a catalog PR, issue, or review record where the
author needs to see the decision, evidence, and next action without reading the
full evidence packet first.

Keep the note short. Link the fuller evidence packet when a second reviewer
needs to reproduce the decision.

If the submission requested `unsure`, keep that value in `Requested outcome`,
then convert the evidence into one final review outcome: **Needs changes**,
**Published only**, or **Security Reviewed**.

## Template

```markdown
Review outcome: [Needs changes / Published only / Security Reviewed]

Skill reviewed: [path or PR link]
Version reviewed: [commit, tag, or PR SHA]
Requested outcome: [Published only / Security Reviewed / unsure]
Scanner result: `[command]` -> [exit code and summary]
Manual checks: [prompt injection, data handling, permissions, side effects, destructive actions]
Source-backed claims: [claim types checked and sources used / none claimed / unsupported parts]
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
Source-backed claims: none claimed beyond local fixture behavior
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
Source-backed claims: unsupported setup and external-source claims recorded in the evidence packet
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
Source-backed claim recheck: [no changed claims / claim types checked and sources used / unsupported parts]
Risky flow test: [result or "not run: reason"]
Evidence packet: [link, if available]

Decision:
The diff does not weaken the assumptions recorded in the prior review evidence,
changed claims are still backed by reviewable sources, and the new
scanner/manual checks did not find new unresolved risk. Keep Security Reviewed.

Required follow-up:
- Recheck again before keeping Security Reviewed if a future diff changes tool
  access, external services, authentication, data flow, prompt-injection
  handling, source-backed claims, or destructive actions.
```

If scanner results, manual checks, or risky-flow evidence are incomplete, use
**Published only** until the missing evidence is supplied.

## Needs Changes Follow-up Example

```markdown
Review outcome: Security Reviewed after Needs changes follow-up

Skill reviewed: [path or PR link]
Version reviewed: [new commit]
Prior review outcome: Needs changes
Scanner result: `[command]` -> [exit code and summary]
Manual checks: source-backed API/model/package/platform claims, permissions, data flow, and security controls reviewed
Source-backed claims: [corrected claim and authoritative source checked]
Risky flow test: [result or "not run: reason"]
Evidence packet: [link, if available]

Decision:
The author corrected the unsupported claim or supplied source-backed evidence
that matches the reviewed behavior. The scanner/manual checks do not show new
unresolved risk, so the skill can move from Needs changes to Security Reviewed.

Required follow-up:
- Recheck again if the claim, dependency, permission scope, data flow, or
  security-control evidence changes.
```

Use this follow-up only after the unsupported claim is corrected or backed by
authoritative evidence. If the new evidence still does not match the skill's
behavior, keep **Needs changes**.
