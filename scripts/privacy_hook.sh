#!/bin/bash
# Pre-deploy privacy hook for evsales-site.
#
# Triggered by PreToolUse on Bash. Reads tool input from stdin.
# If the command is a deploy/push for this project, runs the privacy check.
# If the check fails, outputs JSON to deny the tool call with the violation details.
#
# Exits 0 in all cases (uses JSON output to control allow/deny).

INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Only trigger on commands that publish evsales-site
# Matches: wrangler pages deploy ... evsales, git push (when in evsales-site dir context)
if ! echo "$CMD" | grep -qE '(wrangler[[:space:]]+pages[[:space:]]+deploy.*evsales|git[[:space:]]+push)'; then
    exit 0
fi

# Determine if we're in/targeting the evsales-site directory
SITE_DIR="/Users/energysada/ev/evsales-site"

# For git push, only intercept if the command/CWD is the evsales-site repo
if echo "$CMD" | grep -qE 'git[[:space:]]+push'; then
    # Check if the cwd is evsales-site OR the command explicitly cd's to it
    CWD=$(pwd)
    if [ "$CWD" != "$SITE_DIR" ] && ! echo "$CMD" | grep -q "$SITE_DIR"; then
        exit 0
    fi
fi

# Run the privacy check
OUTPUT=$(cd "$SITE_DIR" && python3 scripts/check_privacy.py 2>&1)
RC=$?

if [ $RC -eq 0 ]; then
    # Check passed — allow
    exit 0
fi

# Check failed — deny with detailed reason
REASON="🛑 PRIVACY CHECK FAILED for evsales-site deploy

$OUTPUT

These values appear in private historical xlsx files (bev.xlsx etc.) and must NOT be in deployed artifacts. Either:
1. Use directional language instead of specific values
2. Round heavily and verify not reverse-engineerable from public Q1 totals
3. If from a clearly public source, add to PUBLIC_ALLOWLIST in scripts/check_privacy.py

The deploy command was blocked. Fix the violations above and try again."

jq -n --arg reason "$REASON" '{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": $reason
  }
}'

exit 0
