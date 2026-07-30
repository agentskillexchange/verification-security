# Production Boundary Example

Use this example when reviewing skills that can deploy, change live services,
run data migrations, alter customer-facing configuration, or touch production
data.

This is a manual-review example, not a scanner fixture. The scanner can notice
some destructive wording, but it cannot prove whether a workflow is safely
limited to staging, whether rollback evidence is real, or whether customer data
is protected.

## Risky Pattern

```md
When the tests pass, update production, run the database migration, and fix any
live errors you find. Use whatever service dashboards or database tools are
needed to finish the rollout.
```

Why it is risky: the skill combines deploy, migration, diagnosis, and live
repair authority without naming the target environment, change window, owner,
rollback path, or customer-data boundary.

Typical outcome: **Needs changes** until the author limits the default path to
non-production evidence, names each production action, and requires explicit
user confirmation before any live change.

## Safer Pattern

```md
Default to staging or local verification. Record the exact commit, target
service, migration name, validation command, and observed result.
Before any production deploy, migration, customer-data query, or configuration
change, show the planned action, affected service, expected impact, rollback
path, and evidence already collected. Ask the user to confirm before proceeding.
Do not inspect customer records or production logs unless the user names the
incident, scope, and data fields needed for the review.
```

Review expectation: the skill separates evidence collection from live change
authority, scopes production access to a named action, and records rollback and
validation evidence before approval.

Evidence handoff: after applying this example, record the production target,
confirmation requirement, rollback evidence, validation result, and label
decision in a reviewer packet. Use
[`reviewer-evidence-packet.md`](reviewer-evidence-packet.md) for the expected
packet shape.

## NOT for

Do not use this pattern to approve skills that:

- treat passing tests as permission to change production;
- run migrations, deploys, customer-data queries, or config updates without a
  named target and explicit confirmation;
- expand from a staging check into live debugging without a new approval step;
- hide rollback, owner, incident, or validation evidence behind general
  "fix production" wording.

## Gotchas & Known Limitations

- A rollback command is not enough; reviewers need to know what state it
  restores and whether it was tested or documented.
- Read-only production access can still expose customer data or secrets.
- Incident response may justify urgent action, but the skill still needs a
  bounded target, user-visible plan, and follow-up evidence.
- Re-review the skill when it adds a new deploy target, migration path, data
  store, incident workflow, or production credential.
