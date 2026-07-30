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
