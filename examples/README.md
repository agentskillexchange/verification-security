# Examples

Use these examples to compare safe patterns, risky patterns, scanner fixtures,
and completed reviewer evidence packets.

| Need | Start here | Use it for |
|------|------------|------------|
| Small safe/risky snippets | [`review-patterns.md`](review-patterns.md) | Comparing a single `SKILL.md` instruction against an expected safeguard. |
| Scanner and manual-review decisions | [`risky-patterns.md`](risky-patterns.md) | Mapping `FAIL`, `WARN`, `INFO`, and line evidence to review actions. |
| Browser/session data handling | [`session-data-handling.md`](session-data-handling.md) | Reviewing cookies, local storage, screenshots, and signed-in page evidence. |
| Permission scope boundaries | [`permission-scope.md`](permission-scope.md) | Reviewing broad tool, file, browser, messaging, and account access. |
| Dependency update trust | [`dependency-update-trust.md`](dependency-update-trust.md) | Reviewing package installs, version upgrades, changelog instructions, and migration side effects. |
| Production boundaries | [`production-boundaries.md`](production-boundaries.md) | Reviewing live deploys, migrations, customer-data access, rollback paths, and incident scopes. |
| Passing and blocking evidence packets | [`reviewer-evidence-packet.md`](reviewer-evidence-packet.md) | Seeing what reproducible `Security Reviewed` or `Published only` evidence looks like. |
| Review decision note | [`review-decision-note.md`](review-decision-note.md) | Turning evidence into a concise PR, issue, or review-record outcome. |
| Source-backed verification | [`source-backed-verification.md`](source-backed-verification.md) | Checking API, package, platform, permission, or security-control claims against reviewable sources. |
| Threat-model outcome cues | [`../security/threat-model.md#review-outcome-cues`](../security/threat-model.md#review-outcome-cues) | Classifying prompt-injection, data-flow, permission, helper-script, or destructive-action findings before writing the final decision. |
| A clean scanner target | [`scanner-fixtures/safe-minimal-skill.md`](scanner-fixtures/safe-minimal-skill.md) | Checking the scanner's no-issue path and a minimal safe review packet. |
| An intentionally risky scanner target | [`scanner-fixtures/risky-skill.md`](scanner-fixtures/risky-skill.md) | Confirming expected risky findings and practicing scanner-output triage. |

Run fixture scans from the repository root:

```bash
security/tools/scan.sh examples/scanner-fixtures/safe-minimal-skill.md
security/tools/scan.sh examples/scanner-fixtures/risky-skill.md
```
