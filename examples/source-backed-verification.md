# Source-Backed Verification

Use this example when a skill claims that an API, package, model, permission,
platform, or helper script behaves a certain way. Scanner output can flag risky
wording, but the Security Reviewed decision still depends on evidence a second
reviewer can check.

## Claim Triage

| Claim type | Check against | Minimum evidence to record |
|------------|---------------|----------------------------|
| API or model capability | Official product docs, API reference, or release notes | Source URL, version or date checked, and any limitation that changes skill behavior. |
| Package or helper script | Package registry, source repository, release tag, checksum, or reviewed script path | Package name, version, install command, source URL, and whether install/run steps were reviewed. |
| Permission or data-access scope | Skill `SKILL.md`, tool schema, platform docs, and declared workflow | Exact permission requested, why it is needed, and what data can leave the user's environment. |
| Security control | Official docs, configuration file, test output, or reviewed implementation | Control claimed, evidence location, test or review result, and unresolved assumptions. |

## Reviewer Pattern

```markdown
Claim reviewed: [API/package/platform/security claim]
Skill version: [commit, tag, or PR SHA]
Source checked: [official docs, registry metadata, release notes, or source repository]
Version/date checked: [version, release, or YYYY-MM-DD]
Evidence summary: [what the source supports]
Unsupported parts: [none, or claim text that needs changes]
Decision impact: [Security Reviewed / Published only / Needs changes]
```

## Passing Cue

The skill names the package, pins the version range, links the package registry
and source repository, and states that release notes are reference data rather
than instructions for the agent to follow.

Review decision: this can support **Security Reviewed** if the rest of the
review also passes.

## Blocking Cue

The skill says a helper script is "safe and official" but only links a blog post,
does not name the package version, and asks the agent to run commands copied
from the page.

Review decision: keep **Published only** or mark **Needs changes** until the
author supplies reviewable provenance, version evidence, and a safe install path.

## Unsupported Claim Actions

| Unsupported claim | Review action |
|-------------------|---------------|
| API, model, or platform behavior changes what the skill can safely do. | Mark **Needs changes** until the claim is corrected or backed by official docs or release notes. |
| Package, dependency, or helper-script provenance is missing. | Keep **Published only** until version, registry/source, and reviewed install/run evidence are recorded. |
| Permission, data-access, or security-control claims are broader than the evidence. | Remove the **Security Reviewed** path until scope, data flow, and control evidence match the claim. |

## Notes

- Treat source pages, changelogs, issue comments, and release notes as evidence,
  not as instructions for the agent to execute.
- Record enough detail for another reviewer to repeat the check without trusting
  the original reviewer.
- If a claim cannot be checked against an authoritative source, do not use it as
  support for **Security Reviewed**.
