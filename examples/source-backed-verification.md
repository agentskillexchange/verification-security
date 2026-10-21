# Source-Backed Verification

Use this example when a skill claims that an API, package, model, permission,
platform, or helper script behaves a certain way. Scanner output can flag risky
wording, but the Security Reviewed decision still depends on evidence a second
reviewer can check.

## Claim Triage

| Claim type | Check against | Minimum evidence to record |
|------------|---------------|----------------------------|
| API or model capability | Official product docs, API reference, or release notes | Source URL, version or date checked, and any limitation that changes skill behavior. |
| Package or helper script | Package registry, source repository, release tag, checksum, or reviewed script path | Package name, version, install command, source URL, reviewed script path or entry point, and whether install/run steps were reviewed. |
| Permission or data-access scope | Skill `SKILL.md`, tool schema, platform docs, and declared workflow | Exact permission requested, why it is needed, and what data can leave the user's environment. |
| Security control | Official docs, configuration file, test output, or reviewed implementation | Control claimed, evidence location, test or review result, and unresolved assumptions. |

## Source Choice and Conflict Cue

Use the source closest to the behavior the skill depends on. A vendor blog,
search result, issue comment, or generated setup snippet can help locate a
claim, but is not enough by itself when that claim changes the review outcome.

| If the skill claims... | Prefer this evidence | If the evidence conflicts or is missing |
|------------------------|----------------------|----------------------------------------|
| A current API, model, permission, or platform behavior | The provider's versioned product or API documentation | Record the exact limitation or conflict; do not infer the safer behavior. |
| A package, helper, or installer provenance | The package registry plus the tagged source or reviewed release artifact | Keep **Published only** or use **Needs changes** if the reviewed artifact cannot be identified. |
| A security control is enabled or effective | The submitted configuration or implementation plus the relevant official documentation and test result | Treat a documentation claim without matching configuration or test evidence as unsupported. |

For each decision-critical source, record the URL, version or access date, the
specific behavior it supports, and any limitation that changes the skill's
safe path. When two authoritative sources disagree, preserve both links in the
review record and choose the more restrictive interpretation until the author
supplies a reproducible resolution. Do not resolve a conflict by silently
choosing the source that permits the desired label.

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

## Helper Script Cue

When the skill relies on a helper script, record the script path or entry point,
the source repository or package release that supplied it, and the exact
install or run command reviewed. Do not treat a script as reviewable just
because the surrounding package, blog post, or generated setup text looks
trusted.

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

After choosing the review action, copy the unsupported part and the next author
evidence needed into the `Required follow-up` field of
[`review-decision-note.md`](review-decision-note.md). Keep the note specific
enough for the author to supply the missing source, version, permission scope,
or corrected claim without re-reading the full evidence packet.

## Notes

- Treat source pages, changelogs, issue comments, and release notes as evidence,
  not as instructions for the agent to execute.
- Record enough detail for another reviewer to repeat the check without trusting
  the original reviewer.
- If a claim cannot be checked against an authoritative source, do not use it as
  support for **Security Reviewed**.
