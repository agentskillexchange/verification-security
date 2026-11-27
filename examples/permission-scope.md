# Permission Scope Example

Use this example when reviewing skills that request broad filesystem, browser,
email, messaging, network, deployment, or account access.

This is a manual-review example, not a scanner fixture. The scanner may not see
whether requested permissions are necessary for the skill's stated purpose.

## Risky Pattern

```md
Use browser, filesystem, email, Slack, GitHub, and deployment tools as needed to
finish the task. If a tool seems useful, use it without asking.
```

Why it is risky: the skill does not connect each permission to a specific
workflow, data boundary, or user-visible action. Broad access can expose private
data, change unrelated systems, or hide side effects behind vague wording.

Typical outcome: **Needs changes** until the author lists required tools,
scopes each permission to the workflow, and adds confirmation for external,
public, destructive, or account-changing actions.

## Safer Pattern

```md
Required tools: local file read access for the target project and GitHub issue
read access for the linked issue.
Do not open unrelated files, browser sessions, email, chat, deployment, or
payment tools.
Before posting, merging, deploying, sending messages, or changing account
settings, show the exact action and ask for confirmation.
```

Review expectation: every permission has a narrow reason, unrelated tools are
explicitly out of scope, and the skill asks before external or irreversible
actions.

Evidence handoff: after applying this example, record each requested permission,
the workflow it supports, any excluded tools, confirmation requirements,
validation result, and label decision in a reviewer packet. Use
[`reviewer-evidence-packet.md`](reviewer-evidence-packet.md) for the expected
packet shape.

## Copyable Permission Scope Record

Use one row for every requested tool, service, account, or access mode. Do not
replace a specific purpose with `as needed`. The record applies the
[NIST least-privilege principle](https://csrc.nist.gov/glossary/term/least_privilege):
access should be no broader than needed for the assigned task. It also makes
the requested action and resource explicit, as recommended by the
[OWASP Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html).

```markdown
| Requested permission | Exact task step | Resource and allowed operation | Why narrower access will not work | Explicit exclusions | Confirmation or approval required | Evidence checked |
|---|---|---|---|---|---|---|
| GitHub issue read | Read the linked defect report | One named issue; read only | The issue contains the reproduction details | No repository write, PR, or organization access | None; no external action | Linked issue and submitted instructions |
```

For a permission whose actual scope depends on a platform, credential, or
configuration claim, make `Evidence checked` specific enough for a second
reviewer to compare the intended boundary with the configured one:

```text
Permission claim: [for example, token can read only the named project]
Skill version: [commit, tag, or PR SHA]
Authoritative source: [official permission or scope documentation]
Source version or date checked: [version, release, or YYYY-MM-DD]
Submitted configuration: [setting, token scope name, or reviewed path; never the secret]
Bounded observation: [non-production check, result, and environment]
Mismatch or unknown limit: [none, or the exact broader/unverified behavior]
Recheck trigger: [new scope, resource, service, credential, or provider-source change]
```

The platform documentation shows what a permission is meant to allow; the
submitted configuration and bounded observation show what this skill can
actually access. Do not treat a permission label, a successful login, or a
documentation link alone as proof of the narrower boundary. Use the
[Source-Backed Verification](source-backed-verification.md) pattern when the
claim affects the review outcome.

Choose the outcome from the completed record:

- **Security Reviewed** only when every requested permission has a stated task
  step, a bounded resource and operation, exclusions, and an appropriate
  confirmation or approval boundary.
- **Published only** when the skill is otherwise clear and safely listable but
  evidence for one or more permissions is incomplete.
- **Needs changes** when a permission is broad, unexplained, conflicts with
  the stated task, or allows an external, public, destructive, paid, or
  account-changing action without explicit confirmation.

Re-review when a new tool, access mode, resource, or operation is added; do
not assume an existing label covers it. Copy the completed rows into the
[`Reviewer Evidence Packet`](reviewer-evidence-packet.md) and summarize the
decision in the [`Review Decision Note`](review-decision-note.md).

Also re-review when a provider changes the documented meaning of a permission
or the submitted credential/configuration changes without adding a new tool.
Until the source, configured scope, and bounded observation are refreshed,
keep the skill **Published only** rather than carrying forward **Security
Reviewed**.

## NOT for

Do not use this pattern to approve skills that:

- request broad tool access because it may be convenient later;
- rely on "as needed" wording instead of declared tools and boundaries;
- can touch production, accounts, messaging, or publishing surfaces without a
  confirmation step.

## Gotchas & Known Limitations

- A narrow permission list can still be risky if the workflow sends private data
  to an external service.
- Read-only access still needs scope when files, browser pages, email, or chat
  may contain private information.
- Re-review the skill when a new tool, API, data source, or side effect is added.
