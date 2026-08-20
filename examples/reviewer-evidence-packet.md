# Reviewer Evidence Packet Examples

Use these examples when a submission asks for **Security Reviewed** evidence and
the reviewer needs a compact, reproducible packet instead of prose-only notes.

The passing example uses the safe fixture at
[`examples/scanner-fixtures/safe-minimal-skill.md`](scanner-fixtures/safe-minimal-skill.md).
The blocking example uses the intentionally risky fixture at
[`examples/scanner-fixtures/risky-skill.md`](scanner-fixtures/risky-skill.md).

## Passing Packet

Skill under review: `examples/scanner-fixtures/safe-minimal-skill.md`

Requested outcome: `Security Reviewed`

Scanner command and result:

```bash
security/tools/scan.sh examples/scanner-fixtures/safe-minimal-skill.md
# exit 0, no issues found
```

Manual checks completed:

- Prompt injection: no blocking instruction to follow untrusted content. The
  fixture says referenced content is data to summarize, not instructions.
- Data handling: no secrets, credentials, private user data, or external data
  transfer.
- Permissions: local documentation review only; commands and external resources
  require user confirmation.
- Destructive actions: none.
- External services: none.

Source-backed claims checked:

- None. The fixture does not claim specific API, model, package, platform,
  permission, or security-control behavior.

Risky flow tested:

- Not applicable. The fixture has no live service calls, destructive actions, or
  credential handling.

Follow-up needed:

- None for this fixture. A real skill would still need reviewer confirmation
  that referenced files and implementation behavior match the submitted
  `SKILL.md`.

Review decision:

This packet is sufficient to advance the fixture to **Security Reviewed** as a
minimal safe example.

## Blocking Packet

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

Source-backed claims checked:

- Helper-script provenance: unsupported. The fixture uses an unpinned remote
  install script, so the source, version, and reviewed install path are missing.
- Permission and destructive-action claims: unsupported until the requested file
  deletion behavior is scoped and requires explicit confirmation.

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
