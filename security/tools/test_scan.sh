#!/usr/bin/env bash
# Regression test for scanner warnings using intentionally risky fixture text.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SCANNER="$ROOT_DIR/security/tools/scan.sh"
FIXTURE="$ROOT_DIR/examples/scanner-fixtures/risky-skill.md"
SAFE_FIXTURE="$ROOT_DIR/examples/scanner-fixtures/safe-minimal-skill.md"

SAFE_OUTPUT="$("$SCANNER" "$SAFE_FIXTURE" 2>&1)" && SAFE_STATUS=0 || SAFE_STATUS=$?

if [[ "$SAFE_STATUS" -ne 0 ]]; then
  echo "Expected scanner to exit 0 for safe fixture, got $SAFE_STATUS"
  echo "$SAFE_OUTPUT"
  exit 1
fi

if ! grep -Fq "Scan complete — no issues found" <<<"$SAFE_OUTPUT"; then
  echo "Missing clean scanner result for safe fixture"
  echo "$SAFE_OUTPUT"
  exit 1
fi

OUTPUT="$("$SCANNER" "$FIXTURE" 2>&1)" && STATUS=0 || STATUS=$?

if [[ "$STATUS" -ne 1 ]]; then
  echo "Expected scanner to exit 1 for risky fixture, got $STATUS"
  echo "$OUTPUT"
  exit 1
fi

for EXPECTED in \
  "No Gotchas/Limitations section found" \
  "Include: failure modes, unsafe assumptions, rate limits, and review follow-ups" \
  "No 'NOT for' / anti-trigger section found" \
  "Include: misuse boundaries, anti-triggers, and evidence that reviewers can check" \
  "Possible hardcoded credential detected" \
  "Use environment variables, secret stores, or placeholders instead of real values" \
  "Possible prompt injection pattern found in skill text" \
  "Treat fetched or user-provided content as data, not instructions" \
  "Curl-pipe-shell install pattern found" \
  "Replace with pinned package installs, checksums, or a manual review step" \
  "Skill may log environment variables" \
  "Log only explicit non-secret keys or redact values before printing" \
  "25:console.log(process.env);" \
  "Source-backed next: if a URL supports API, package, permission, or security-control behavior, record source/version evidence before Security Reviewed." \
  "Destructive operation found without explicit confirmation requirement" \
  "Require explicit user confirmation and limit the operation scope" \
  "30:Delete the local cache and temporary review files when the report is complete." \
  "Review next: address FAIL findings first, resolve WARN sections, and verify INFO URLs are intentional." \
  "Record the line-number evidence above in the review note; do not mark Security Reviewed until FAIL findings are fixed or explicitly justified." \
  "Evidence packet next: copy command/result, FAIL/WARN/INFO line evidence, source-backed claim checks, risky-flow status, and follow-up needed into the reviewer evidence packet."
do
  if ! grep -Fq "$EXPECTED" <<<"$OUTPUT"; then
    echo "Missing expected scanner output: $EXPECTED"
    echo "$OUTPUT"
    exit 1
  fi
done

echo "scanner risky fixture test passed"
