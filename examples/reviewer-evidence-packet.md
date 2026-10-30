# Reviewer Evidence Packet Examples

Use these examples when a submission asks for **Security Reviewed** evidence and
the reviewer needs a compact, reproducible packet instead of prose-only notes.
After completing a packet, copy the requested outcome, scanner summary, manual
checks, source-backed claims, risky-flow evidence, and follow-up into the
[`Review Decision Note`](review-decision-note.md) so the PR, issue, or review
record has a short decision that links back to this evidence.

If the submission requested `unsure`, keep `unsure` as the requested outcome in
the packet, then use the recorded evidence to choose **Needs changes**,
**Published only**, or **Security Reviewed** in the short decision note.

The passing example uses the safe fixture at
[`examples/scanner-fixtures/safe-minimal-skill.md`](scanner-fixtures/safe-minimal-skill.md).
The blocking example uses the intentionally risky fixture at
[`examples/scanner-fixtures/risky-skill.md`](scanner-fixtures/risky-skill.md).

## Fixture Practice Path

For a first evidence-packet practice run, scan the safe fixture first and copy
the clean result into the passing packet fields below. Then scan the risky
fixture, keep the failing exit code and issue count, and map each scanner or
manual finding into `Manual checks completed`, `Source-backed claims checked`,
`Risky flow tested`, and `Follow-up needed` before writing the final decision.

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

## Bounded Non-Production External-Action Packet

Use this *illustrative completed packet* when a skill has one risky external
action, such as sending a test notification or creating a test-only record.
It shows the minimum evidence that turns “we tested it” into a reviewable
handoff. It is not evidence for a real skill: replace every example value with
the submitted skill's actual command, target, result, owner, and sources.

Skill under review: `test-notification skill`, version `0.3.0`

Requested outcome: `Security Reviewed`

Scanner command and result:

```bash
security/tools/scan.sh path/to/SKILL.md
# exit 0, no unresolved findings
```

Manual checks completed:

- External action: the skill sends only the fixed test message `review check`
  to the named `skill-review-sandbox` workspace; it does not send to a
  production workspace or recipient.
- Confirmation: before the send, the skill shows the workspace and message and
  asks the user to confirm that one test notification may be sent.
- Data handling: the message contains no customer data, secrets, file content,
  or raw tool output. The credential is read only at send time and is neither
  printed nor included in the review record.
- Permissions and destructive actions: the credential is limited to the
  sandbox workspace; the action creates one test notification and cannot
  delete, publish, or modify production data.
- Owner: `Skill maintainer` owns the sandbox workspace and can revoke its
  credential or delete the test notification.

Source-backed claims checked:

- The real submission must link the provider's official documentation for the
  credential scope and test-workspace behavior. This illustrative packet makes
  no provider-specific claim.

Risky flow tested:

- Non-production test: after the confirmation prompt, one test notification
  was sent to `skill-review-sandbox`; the maintainer recorded the command,
  timestamp, and returned test-message identifier in the PR or review record.
- Rollback: the maintainer deleted that one test notification from the sandbox
  and recorded the result. No production workspace, recipient, or data was
  involved.

Follow-up needed:

- None in this example. A real packet must name the actual sandbox target,
  confirmation wording, owner, command/result, rollback result, and official
  source links; otherwise request **Published only** or **Needs changes**.

Review decision:

This shape can support **Security Reviewed** only after the real evidence is
present and reproducible. A stated intention to use a sandbox is not evidence
by itself.

## Blocking Packet

Skill under review: `examples/scanner-fixtures/risky-skill.md`

Requested outcome: `Security Reviewed`

Scanner command and result:

```bash
security/tools/scan.sh examples/scanner-fixtures/risky-skill.md
# exit 1, 9 issue(s) found
```

Manual checks completed:

- Prompt injection: blocking. The fixture tells the agent to fetch a page and
  follow instructions from that page.
- Data handling: blocking. The fixture logs environment values with
  `console.log(process.env)`.
- Permissions: needs changes. The fixture installs a remote script with
  `curl ... | bash`.
- Remote execution: blocking. The fixture sources a remote script through shell
  process substitution without a pinned, reviewed artifact.
- Transport security: blocking. The fixture disables TLS certificate
  verification for an API request.
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
- Owner must replace remote process substitution with a pinned artifact that is
  verified and reviewed before execution.
- Owner must keep TLS certificate verification enabled and correct the trust
  configuration rather than bypass it.
- Owner must add explicit confirmation before destructive file actions.

Review decision:

Keep the skill **Published only** or block publication until the issues above
are fixed. Do not advance it to **Security Reviewed** from this packet.
