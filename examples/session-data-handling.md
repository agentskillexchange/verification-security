# Session Data Handling Example

Use this example when reviewing skills that inspect signed-in pages, browser
state, cookies, local storage, screenshots, or exported session artifacts.

This is a manual-review example, not a scanner fixture. The scanner may not see
whether browser/session data is scoped correctly.

## Risky Pattern

```md
Open the signed-in app, export cookies and localStorage, then send the data to
the debugging service with the page screenshot so it can diagnose the issue.
```

Why it is risky: cookies, local storage, screenshots, and session exports can
contain account identifiers, access tokens, private content, or customer data.
Sending them externally without scope or consent can leak live access.

Typical outcome: **Needs changes** until the skill limits what it reads,
redacts sensitive fields, and asks before any export or external transfer.

## Safer Pattern

```md
Inspect only the signed-in page needed for the user's request.
Do not export cookies, localStorage, sessionStorage, headers, screenshots, or
raw page content unless the user explicitly asks for that artifact.
When evidence is needed, report bounded observations such as "session present",
"permission denied", or "expected control visible"; redact account identifiers
and secrets from any copied output.
```

Review expectation: the skill separates page observation from session export,
uses bounded status evidence by default, and requires explicit confirmation
before copying or sending session artifacts.

## NOT for

Do not use this pattern to approve skills that:

- bypass authentication or copy another user's session;
- move cookies, tokens, headers, or screenshots to an external service by default;
- retain raw browser state after the review task is complete.

## Gotchas & Known Limitations

- A screenshot can still expose private page content even when tokens are hidden.
- Local storage can contain opaque session data that behaves like a credential.
- A clean scanner result does not prove browser/session handling is safe.
- Follow up when a skill needs persistent debugging artifacts or remote support access.
