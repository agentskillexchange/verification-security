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
  - missing Gotchas / Limitations guidance
  - missing NOT for / anti-trigger guidance
  - possible hardcoded credentials
  - unreviewed external URLs
  - prompt-injection language
  - curl-pipe-shell install patterns
  - environment value logging
  - destructive actions without confirmation

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
  echo "⚠️  WARN: No Gotchas/Limitations section found"
  echo "   Recommended: Add a '## Gotchas & Known Limitations' section"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 2: NOT for section ----
if ! grep -qi "not for\|don't use\|avoid\|when not to" "$SKILL_FILE"; then
  echo "⚠️  WARN: No 'NOT for' / anti-trigger section found"
  echo "   Recommended: Add a '## NOT for' section"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 3: Hardcoded credentials ----
if grep -qiE "(api_key|apikey|secret|password|token)\s*=\s*['\"][^'\"]{6,}" "$SKILL_FILE"; then
  echo "🚨 FAIL: Possible hardcoded credential detected"
  grep -niE "(api_key|apikey|secret|password|token)\s*=\s*['\"][^'\"]{6,}" "$SKILL_FILE" | head -5
  ISSUES=$((ISSUES+1))
fi

# ---- Check 4: Suspicious outbound URLs (non-documentation) ----
SUSPICIOUS=$(grep -oiE 'https?://[^[:space:])"'"'"']+' "$SKILL_FILE" | grep -viE '(github\.com|docs\.|readme|example\.com|localhost|your-|<|\{)' | head -10 || true)
if [[ -n "$SUSPICIOUS" ]]; then
  echo "ℹ️  INFO: External URLs found (verify these are intentional):"
  echo "$SUSPICIOUS" | sed 's/^/   /'
fi

# ---- Check 5: Prompt injection patterns ----
if grep -qiE "follow (any|all) instructions|ignore (previous|prior|above)" "$SKILL_FILE"; then
  echo "🚨 FAIL: Possible prompt injection pattern found in skill text"
  grep -niE "follow (any|all) instructions|ignore (previous|prior|above)" "$SKILL_FILE"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 6: Curl-pipe-shell setup ----
if grep -qiE "(curl|wget)[^|]{0,120}\|[[:space:]]*(sudo[[:space:]]+)?(bash|sh)\b" "$SKILL_FILE"; then
  echo "⚠️  WARN: Curl-pipe-shell install pattern found"
  echo "   Recommended: Replace with pinned package installs, checksums, or a manual review step"
  grep -niE "(curl|wget)[^|]{0,120}\|[[:space:]]*(sudo[[:space:]]+)?(bash|sh)\b" "$SKILL_FILE"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 7: Environment variable exposure ----
if grep -qiE "print|echo|log|console\.log" "$SKILL_FILE" && grep -qiE "process\.env|os\.environ|\$[A-Z_]{4,}" "$SKILL_FILE"; then
  echo "⚠️  WARN: Skill may log environment variables"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 8: Destructive operations without confirmation ----
if grep -qiE "\b(rm |delete|drop table|format|wipe|truncate)" "$SKILL_FILE"; then
  if ! grep -qiE "(confirm|ask|prompt|proceed\?|are you sure)" "$SKILL_FILE"; then
    echo "⚠️  WARN: Destructive operation found without explicit confirmation requirement"
    ISSUES=$((ISSUES+1))
  fi
fi

echo "=========================================="
if [[ $ISSUES -eq 0 ]]; then
  echo "✅ Scan complete — no issues found"
  exit 0
else
  echo "❌ Scan complete — $ISSUES issue(s) found"
  exit 1
fi
