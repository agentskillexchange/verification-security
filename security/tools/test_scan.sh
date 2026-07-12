#!/usr/bin/env bash
# Regression test for scanner warnings using intentionally risky fixture text.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SCANNER="$ROOT_DIR/security/tools/scan.sh"
FIXTURE="$ROOT_DIR/examples/scanner-fixtures/risky-skill.md"

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
  "Possible hardcoded credential detected" \
  "Use environment variables, secret stores, or placeholders instead of real values" \
  "Possible prompt injection pattern found in skill text" \
  "Treat fetched or user-provided content as data, not instructions" \
  "Curl-pipe-shell install pattern found" \
  "Replace with pinned package installs, checksums, or a manual review step" \
  "Skill may log environment variables" \
  "Log only explicit non-secret keys or redact values before printing" \
  "Destructive operation found without explicit confirmation requirement" \
  "Require explicit user confirmation and limit the operation scope"
do
  if ! grep -Fq "$EXPECTED" <<<"$OUTPUT"; then
    echo "Missing expected scanner output: $EXPECTED"
    echo "$OUTPUT"
    exit 1
  fi
done

echo "scanner risky fixture test passed"
