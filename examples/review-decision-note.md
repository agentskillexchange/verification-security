# Review Decision Note Example

Use this note after a reviewer has run the scanner and completed the relevant
manual checks. It is meant for a catalog PR, issue, or review record where the
author needs to see the decision, evidence, and next action without reading the
full evidence packet first.

Keep the note short. Link the fuller evidence packet when a second reviewer
needs to reproduce the decision.

Use the short note by itself for low-risk **Published only** decisions, clean
documentation-only updates, or follow-up comments where the scanner result and
manual check summary are enough to explain the outcome. Add or link the full
[`Reviewer Evidence Packet`](reviewer-evidence-packet.md) when the decision
depends on reproducible evidence: **Security Reviewed** requests, `unsure`
intake, scanner failures, source-backed claim checks, sandbox or
non-production tests, or manual-risk tradeoffs.

If the submission requested `unsure`, keep that value in `Requested outcome`,
then convert the evidence into one final review outcome: **Needs changes**,
**Published only**, or **Security Reviewed**.

When a manual check drives the outcome, name the exact skill section, helper
file, dependency, permission, service, or user action that creates the risk,
then carry the required safeguard or unresolved follow-up into the note.

## From Packet To Note

When starting from a completed
[`Reviewer Evidence Packet`](reviewer-evidence-packet.md), copy the packet
fields directly into this short note:

| Packet field | Decision note field |
|--------------|---------------------|
| `Requested outcome` | `Requested outcome` |
| `Scanner command and result` | `Scanner result` |
| Scanner `FAIL`, `WARN`, or `INFO` lines that affected the decision | `Scanner evidence` |
| `Manual checks completed` | `Manual checks` |
| `Source-backed claims checked` | `Source-backed claims` |
| `Risky flow tested` | `Risky flow test` |
| `Follow-up needed` | `Required follow-up` |
| `Review decision` | `Review outcome` and `Decision` |

Do not upgrade a packet's requested outcome while copying it. Keep the requested
outcome as submitted, then use the recorded evidence to choose the final
`Review outcome`.

## Template

```markdown
Review outcome: [Needs changes / Published only / Security Reviewed]

Skill reviewed: [path or PR link]
Version reviewed: [commit, tag, or PR SHA]
Requested outcome: [Published only / Security Reviewed / unsure]
Scanner result: `[command]` -> [exit code and summary]
Scanner evidence: [FAIL/WARN/INFO labels and cited lines that affected the outcome / none]
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
Requested outcome: Security Reviewed
Scanner result: `security/tools/scan.sh examples/scanner-fixtures/safe-minimal-skill.md` -> exit 0, no issues found
Scanner evidence: none; no FAIL/WARN/INFO findings affected this outcome
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
Requested outcome: Security Reviewed
Scanner result: `security/tools/scan.sh examples/scanner-fixtures/risky-skill.md` -> exit 1, 7 issue(s) found
Scanner evidence: FAIL/WARN/INFO line evidence for prompt-following from fetched content, hardcoded credential text, curl-pipe-shell setup, raw environment logging, unconfirmed destructive action, and external URL use
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

## INFO URL Evidence Cue

When the scanner reports `INFO: External URLs found`, decide whether the URL is
only review context or whether the skill relies on it for setup, permissions,
API behavior, package behavior, or a security control. If the URL affects the
review outcome, carry it into the note instead of leaving it as a generic URL
finding:

```markdown
Scanner evidence: INFO lines 12 and 18 list an API endpoint and package
registry URL used by the setup flow.
Source-backed claims: package version and API behavior not yet checked against
official docs or registry metadata
Required follow-up:
- Provide source/version evidence for the package and API behavior, or keep the
  skill Published only until those claims are reviewable.
```

Reference-only docs links do not need this cue unless they support a behavior
claim used for **Security Reviewed**.

## Recheck Example

```markdown
Review outcome: Security Reviewed

Skill reviewed: [path or PR link]
Version reviewed: [new commit]
Prior reviewed version: [old commit]
Recheck decision: keep Security Reviewed after material-change recheck
Scanner result: `[command]` -> [exit code and summary]
Scanner evidence: [new or changed FAIL/WARN/INFO labels and cited lines / none]
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

For a changed manual-risk surface, keep **Security Reviewed** only when the
new safeguard, sandbox result, or non-production test evidence is recorded.
Otherwise, set the outcome to **Published only** and name the missing recheck
evidence in `Required follow-up`.

## Downgrade To Recheck Example

Use this outcome when a previously **Security Reviewed** skill remains suitable
to publish, but a material change has removed or left incomplete the evidence
needed to keep that stronger label. This is not a **Needs changes** decision
unless the skill is itself unclear, unsafe, or requires remediation.

```markdown
Review outcome: Published only

Skill reviewed: [path or PR link]
Version reviewed: [new commit]
Prior review label: Security Reviewed
Recheck decision: downgrade to Published only pending material-change evidence
Scanner result: `[command]` -> [exit code and summary]
Scanner evidence: [new or changed FAIL/WARN/INFO labels and cited lines / none]
Manual checks: [changed behavior reviewed / checks still needed]
Source-backed claim recheck: [claims checked / claims still needing sources]
Risky flow test: [result or "not run: reason"]
Evidence packet: [link, if available]

Decision:
The skill can remain published, but its new [tool, data-flow, permission, or
external-service] behavior is not yet supported by complete recheck evidence.
Do not retain Security Reviewed until the listed evidence is reviewed.

Required follow-up:
- Provide [specific scanner, manual, source-backed, or non-production test]
  evidence for the changed behavior, then request a fresh Security Reviewed
  decision.
```

After the missing evidence is supplied, use the [Recheck Example](#recheck-example)
for the new **Security Reviewed** decision; do not silently restore the label.

## Needs Changes Follow-up Example

Keep `Review outcome: Needs changes` while a required safeguard, correction, or
source-backed claim remains unresolved. Name the blocking evidence and the
specific author action in `Required follow-up`; do not use the successful
follow-up outcome below until the new evidence matches the skill's reviewed
behavior.

```markdown
Review outcome: Security Reviewed

Skill reviewed: [path or PR link]
Version reviewed: [new commit]
Prior review outcome: Needs changes
Scanner result: `[command]` -> [exit code and summary]
Scanner evidence: [resolved FAIL/WARN/INFO labels and cited lines / remaining findings]
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
