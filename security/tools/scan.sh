#!/usr/bin/env bash
# scan.sh — Basic automated security scan for SKILL.md files
# Usage: ./scan.sh /path/to/SKILL.md
# 
# Returns exit code 0 if no issues found, 1 if issues detected.

set -euo pipefail

SKILL_FILE="${1:-}"
ISSUES=0

if [[ -z "$SKILL_FILE" ]] || [[ ! -f "$SKILL_FILE" ]]; then
  echo "Usage: $0 /path/to/SKILL.md"
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

# ---- Check 6: Environment variable exposure ----
if grep -qiE "print|echo|log|console\.log" "$SKILL_FILE" && grep -qiE "process\.env|os\.environ|\$[A-Z_]{4,}" "$SKILL_FILE"; then
  echo "⚠️  WARN: Skill may log environment variables"
  ISSUES=$((ISSUES+1))
fi

# ---- Check 7: Destructive operations without confirmation ----
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
