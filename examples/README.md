# Examples

Use these examples to compare safe patterns, risky patterns, scanner fixtures,
and completed reviewer evidence packets.

| Need | Start here | Use it for |
|------|------------|------------|
| Small safe/risky snippets | [`review-patterns.md`](review-patterns.md) | Comparing a single `SKILL.md` instruction against an expected safeguard. |
| Scanner and manual-review decisions | [`risky-patterns.md`](risky-patterns.md) | Mapping `FAIL`, `WARN`, `INFO`, and line evidence to review actions. |
| Browser/session data handling | [`session-data-handling.md`](session-data-handling.md) | Reviewing cookies, local storage, screenshots, and signed-in page evidence. |
| Passing and blocking evidence packets | [`reviewer-evidence-packet.md`](reviewer-evidence-packet.md) | Seeing what reproducible `Security Reviewed` or `Published only` evidence looks like. |
| A clean scanner target | [`scanner-fixtures/safe-minimal-skill.md`](scanner-fixtures/safe-minimal-skill.md) | Checking the scanner's no-issue path and a minimal safe review packet. |
| An intentionally risky scanner target | [`scanner-fixtures/risky-skill.md`](scanner-fixtures/risky-skill.md) | Confirming expected risky findings and practicing scanner-output triage. |

Run fixture scans from the repository root:

```bash
security/tools/scan.sh examples/scanner-fixtures/safe-minimal-skill.md
security/tools/scan.sh examples/scanner-fixtures/risky-skill.md
```
