# Reviewer Evidence Packet Example

Use this example when a submission asks for **Security Reviewed** evidence and
the reviewer needs a compact, reproducible packet instead of prose-only notes.

This example uses the intentionally risky fixture at
[`examples/scanner-fixtures/risky-skill.md`](scanner-fixtures/risky-skill.md).
It is a blocking review example, not a passing skill.

## Example Packet

Skill under review: `examples/scanner-fixtures/risky-skill.md`

Requested outcome: `Security Reviewed`

Scanner command and result:

```bash
security/tools/scan.sh examples/scanner-fixtures/risky-skill.md
# exit 1, 7 issue(s) found
```

Manual checks completed:

- Prompt injection: blocking. The fixture tells the agent to fetch a page and
  follow instructions from that page.
- Data handling: blocking. The fixture logs environment values with
  `console.log(process.env)`.
- Permissions: needs changes. The fixture installs a remote script with
  `curl ... | bash`.
- Destructive actions: blocking until the skill requires explicit user
  confirmation before deleting local cache or review files.
- External services: needs owner confirmation for the download URL and install
  path.

Risky flow tested:

- Not approved for live execution. The scanner fixture is static evidence only.
- Reviewers should use
  [`examples/risky-patterns.md#reading-scanner-output`](risky-patterns.md#reading-scanner-output)
  to triage the `FAIL`, `WARN`, `INFO`, and line-evidence output.

Follow-up needed:

- Owner must remove the prompt-following instruction or state that fetched
  content is data only.
- Owner must replace raw environment logging with redacted, explicit keys.
- Owner must replace curl-pipe-shell setup with a pinned or manually reviewed
  install path.
- Owner must add explicit confirmation before destructive file actions.

Review decision:

Keep the skill **Published only** or block publication until the issues above
are fixed. Do not advance it to **Security Reviewed** from this packet.
