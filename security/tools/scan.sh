#!/usr/bin/env bash
# scan.sh — Basic automated security scan for SKILL.md files
#
# Returns exit code 0 if no issues found, 1 if issues detected.

set -euo pipefail

SKILL_FILE="${1:-}"
ISSUES=0

usage() {
  cat <<'EOF'
Usage: security/tools/scan.sh /path/to/SKILL.md

Runs lightweight pre-review checks for common Agent Skill risks:
  - VSR001: missing Gotchas / Limitations guidance
  - VSR002: missing NOT for / anti-trigger guidance
  - VSR003: possible hardcoded credentials
  - VSR004: unreviewed external URLs
  - VSR005: prompt-injection language
  - VSR006: curl-pipe-shell install patterns
  - VSR007: remote scripts executed through shell process substitution
  - VSR008: remote scripts executed through command substitution
  - VSR009: disabled TLS certificate verification
  - VSR010: environment value logging
  - VSR011: destructive actions without confirmation

Include the VSR identifier and line evidence in a reviewer packet or decision
note so another reviewer can trace the finding after the scan.

Exit codes:
  0  no issues found
  1  warnings or failures found; review the output
  2  usage error, missing file, or unreadable file

Examples:
  security/tools/scan.sh submission/SKILL_TEMPLATE.md
  security/tools/scan.sh ../skills/some-skill/SKILL.md
EOF
}

if [[ "$SKILL_FILE" == "-h" || "$SKILL_FILE" == "--help" ]]; then
  usage
  exit 0
fi

if [[ -z "$SKILL_FILE" ]]; then
  usage
  exit 2
fi

if [[ ! -f "$SKILL_FILE" ]]; then
  echo "ERROR: SKILL.md file not found: $SKILL_FILE" >&2
  echo >&2
  usage >&2
  exit 2
fi

echo "🔍 Scanning: $SKILL_FILE"
echo "=========================================="

# ---- Check 1: Gotchas section ----
if ! grep -qi "gotcha\|limitation\|known issue\|caveat" "$SKILL_FILE"; then
  echo "⚠️  WARN [VSR001]: No Gotchas/Limitations section found"
  echo "   Recommended: Add a '## Gotchas & Known Limitations' section"
  echo "   Include: failure modes, unsafe assumptions, rate limits, and review follow-ups"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 2: NOT for section ----
if ! grep -qi "not for\|don't use\|avoid\|when not to" "$SKILL_FILE"; then
  echo "⚠️  WARN [VSR002]: No 'NOT for' / anti-trigger section found"
  echo "   Recommended: Add a '## NOT for' section"
  echo "   Include: misuse boundaries, anti-triggers, and evidence that reviewers can check"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 3: Hardcoded credentials ----
if grep -qiE "(api_key|apikey|secret|password|token)\s*=\s*['\"][^'\"]{6,}" "$SKILL_FILE"; then
  echo "🚨 FAIL [VSR003]: Possible hardcoded credential detected"
  echo "   Recommended: Use environment variables, secret stores, or placeholders instead of real values"
  grep -niE "(api_key|apikey|secret|password|token)\s*=\s*['\"][^'\"]{6,}" "$SKILL_FILE" | head -5
  ISSUES=$((ISSUES+1))
fi

# ---- Check 4: Suspicious outbound URLs (non-documentation) ----
SUSPICIOUS=$(grep -oiE 'https?://[^[:space:])"'"'"']+' "$SKILL_FILE" | grep -viE '(github\.com|docs\.|readme|example\.com|localhost|your-|<|\{)' | head -10 || true)
if [[ -n "$SUSPICIOUS" ]]; then
  echo "ℹ️  INFO [VSR004]: External URLs found (verify these are intentional):"
  echo "$SUSPICIOUS" | sed 's/^/   /'
  echo "   Source-backed next: if a URL supports API, package, permission, or security-control behavior, record source/version evidence before Security Reviewed."
fi

# ---- Check 5: Prompt injection patterns ----
if grep -qiE "follow (any|all) instructions|ignore (previous|prior|above)" "$SKILL_FILE"; then
  echo "🚨 FAIL [VSR005]: Possible prompt injection pattern found in skill text"
  echo "   Recommended: Treat fetched or user-provided content as data, not instructions"
  grep -niE "follow (any|all) instructions|ignore (previous|prior|above)" "$SKILL_FILE"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 6: Curl-pipe-shell setup ----
if grep -qiE "(curl|wget)[^|]{0,120}\|[[:space:]]*(sudo[[:space:]]+)?(bash|sh)\b" "$SKILL_FILE"; then
  echo "⚠️  WARN [VSR006]: Curl-pipe-shell install pattern found"
  echo "   Recommended: Replace with pinned package installs, checksums, or a manual review step"
  grep -niE "(curl|wget)[^|]{0,120}\|[[:space:]]*(sudo[[:space:]]+)?(bash|sh)\b" "$SKILL_FILE"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 7: Remote script execution through process substitution ----
if grep -qiE "(source|\.)[[:space:]]+<\([[:space:]]*(curl|wget)\b" "$SKILL_FILE"; then
  echo "⚠️  WARN [VSR007]: Remote script executed through process substitution"
  echo "   Recommended: Download a pinned artifact, verify its checksum or signature, then review before execution"
  grep -niE "(source|\.)[[:space:]]+<\([[:space:]]*(curl|wget)\b" "$SKILL_FILE" | head -5
  ISSUES=$((ISSUES+1))
fi

# ---- Check 8: Remote script execution through command substitution ----
if grep -qiE "eval[[:space:]]+['\"]?[$][(][[:space:]]*(curl|wget)\b" "$SKILL_FILE"; then
  echo "⚠️  WARN [VSR008]: Remote script executed through command substitution"
  echo "   Recommended: Download a pinned artifact, verify its checksum or signature, then review before execution"
  grep -niE "eval[[:space:]]+['\"]?[$][(][[:space:]]*(curl|wget)\b" "$SKILL_FILE" | head -5
  ISSUES=$((ISSUES+1))
fi

# ---- Check 9: Disabled TLS certificate verification ----
if grep -qiE "(curl[^[:cntrl:]]*(--insecure|[[:space:]]-k([[:space:]]|$))|wget[^[:cntrl:]]*--no-check-certificate|verify[[:space:]]*=[[:space:]]*False)" "$SKILL_FILE"; then
  echo "🚨 FAIL [VSR009]: TLS certificate verification is disabled"
  echo "   Recommended: Keep certificate verification enabled; fix the trust store or use a reviewed certificate-pinning approach"
  grep -niE "(curl[^[:cntrl:]]*(--insecure|[[:space:]]-k([[:space:]]|$))|wget[^[:cntrl:]]*--no-check-certificate|verify[[:space:]]*=[[:space:]]*False)" "$SKILL_FILE" | head -5
  ISSUES=$((ISSUES+1))
fi

# ---- Check 10: Environment variable exposure ----
if grep -qiE "print|echo|log|console\.log" "$SKILL_FILE" && grep -qiE "process\.env|os\.environ|\$[A-Z_]{4,}" "$SKILL_FILE"; then
  echo "⚠️  WARN [VSR010]: Skill may log environment variables"
  echo "   Recommended: Log only explicit non-secret keys or redact values before printing"
  grep -niE "(print|echo|log|console\.log).*(process\.env|os\.environ|\$[A-Z_]{4,})|(process\.env|os\.environ|\$[A-Z_]{4,}).*(print|echo|log|console\.log)" "$SKILL_FILE" | head -5 || true
  ISSUES=$((ISSUES+1))
fi

# ---- Check 11: Destructive operations without confirmation ----
if grep -qiE "\b(rm |delete|drop table|format|wipe|truncate)" "$SKILL_FILE"; then
  if ! grep -qiE "(confirm|ask|prompt|proceed\?|are you sure)" "$SKILL_FILE"; then
    echo "⚠️  WARN [VSR011]: Destructive operation found without explicit confirmation requirement"
    echo "   Recommended: Require explicit user confirmation and limit the operation scope"
    grep -niE "\b(rm |delete|drop table|format|wipe|truncate)" "$SKILL_FILE" | head -5
    ISSUES=$((ISSUES+1))
  fi
fi

echo "=========================================="
if [[ $ISSUES -eq 0 ]]; then
  echo "✅ Scan complete — no issues found"
  exit 0
else
  echo "❌ Scan complete — $ISSUES issue(s) found"
  echo "Review next: address FAIL findings first, resolve WARN sections, and verify INFO URLs are intentional."
  echo "Record each VSR identifier and its line-number evidence above in the review note; do not mark Security Reviewed until FAIL findings are fixed or explicitly justified."
  echo "Evidence packet next: copy command/result, FAIL/WARN/INFO line evidence, source-backed claim checks, risky-flow status, and follow-up needed into the reviewer evidence packet."
  exit 1
fi
