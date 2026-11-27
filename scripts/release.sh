#!/bin/sh
# Release one version of the four repositories of the project, in sync.
#
# Usage: scripts/release.sh v0.0.1 [milestone issue]
#
# The four clones mathlib, mathlib-agent, mathlib-lean and mathlib-handbook must be side by side, on main, with no local change.
# The milestone issue is the tracking issue of tamnd/mathlib that the release PRs refer to. The default is 1 (M0).
# The script does these steps:
#   1. mathlib-lean: a release PR that moves the Unreleased section of CHANGELOG.md, then the tag and the release.
#   2. mathlib-agent: the same. The release workflow of the tag attaches the binaries.
#   3. mathlib: the same.
#   4. mathlib-handbook: the same, and the PR also pins EDITION to the release commits of mathlib, mathlib-lean and mathlib-agent, with a line in CHANGELOG.md.
# Each PR has the labels release and type/chore, and the script merges it at once.
set -eu

V=${1:?usage: scripts/release.sh vX.Y.Z [milestone issue]}
ISSUE=${2:-1}
case $V in v[0-9]*.[0-9]*.[0-9]*) ;; *) echo "the version $V is not of the form vX.Y.Z" >&2; exit 2 ;; esac
DATE=$(date -u +%Y-%m-%d)
ROOT=$(cd "$(dirname "$0")/../.." && pwd)
OWNER=tamnd
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

MILESTONE=$(gh issue view "$ISSUE" -R "$OWNER/mathlib" --json milestone -q '.milestone.title')
CODE=${MILESTONE%%.*}

for r in mathlib mathlib-agent mathlib-lean mathlib-handbook; do
  cd "$ROOT/$r"
  git switch -q main
  git pull -q --ff-only
  if [ -n "$(git status --porcelain)" ]; then echo "$r has local changes" >&2; exit 1; fi
  if git rev-parse -q --verify "refs/tags/$V" >/dev/null || git ls-remote --exit-code --tags origin "$V" >/dev/null 2>&1; then
    echo "$r has the tag $V already" >&2; exit 1
  fi
done

# Move the Unreleased section of CHANGELOG.md under the heading of the version.
bump_changelog() {
  python3 - "$V" "$DATE" <<'EOF'
import sys
v, d = sys.argv[1], sys.argv[2]
s = open("CHANGELOG.md").read()
if "## Unreleased" not in s:
    sys.exit("CHANGELOG.md has no Unreleased section")
s = s.replace("## Unreleased", f"## Unreleased\n\n## {v} - {d}", 1)
open("CHANGELOG.md", "w").write(s)
EOF
}

# Print the section of the version in CHANGELOG.md.
notes() {
  awk -v h="## $V - $DATE" '$0 == h {on = 1; next} on && /^## / {exit} on {print}' CHANGELOG.md
  cat <<EOF

### The books

The PDF and EPUB files of the volumes and of the Catalogue of this edition are attached to the release $V of $OWNER/mathlib-handbook: https://github.com/$OWNER/mathlib-handbook/releases/tag/$V. The CI of the tag builds them, and they are there some minutes after the tag. The file SHA256SUMS gives the SHA-256 sum of each file.
EOF
}

# Open the release PR of the current repository, merge it, then tag the merge commit and make the release.
release_repo() {
  repo=$1
  shift
  git switch -q -c "release-$V"
  bump_changelog
  git add -A
  git commit -q -m "Release $V"
  git push -q -u origin "release-$V"
  if [ "$repo" = mathlib ]; then ref="#$ISSUE"; else ref="$OWNER/mathlib#$ISSUE"; fi
  cat > "$TMP/body.md" <<EOF
## Summary

This PR releases $V of $repo. It moves the Unreleased section of CHANGELOG.md under the heading $V. The four repositories of the project get the release $V at the same time.

## Milestone

Refers to $ref ($CODE). The four repositories have their releases in sync.

## Checks

- The release script \`scripts/release.sh\` of $OWNER/mathlib made this PR.
EOF
  gh pr create -R "$OWNER/$repo" --title "Release $V" --label release --label type/chore --body-file "$TMP/body.md" "$@" >/dev/null
  gh pr merge "release-$V" -R "$OWNER/$repo" --squash --delete-branch
  git switch -q main
  git pull -q --ff-only
  git branch -q -D "release-$V" 2>/dev/null || true
  git tag -a "$V" -m "$repo $V"
  git push -q origin "$V"
  notes > "$TMP/notes.md"
  gh release create "$V" -R "$OWNER/$repo" --verify-tag --latest --title "$repo $V" --notes-file "$TMP/notes.md" >/dev/null
  echo "$repo $V at $(git rev-parse --short HEAD)"
}

# 1. mathlib-lean.
cd "$ROOT/mathlib-lean"
release_repo mathlib-lean
LEAN=$(git rev-parse HEAD)

# 2. mathlib-agent.
cd "$ROOT/mathlib-agent"
release_repo mathlib-agent
AGENT=$(git rev-parse HEAD)

# 3. mathlib.
cd "$ROOT/mathlib"
release_repo mathlib --milestone "$MILESTONE"
MATHLIB=$(git rev-parse HEAD)

# 4. mathlib-handbook, pinned to the release commits.
cd "$ROOT/mathlib-handbook"
python3 - "$V" "$MATHLIB" "$LEAN" "$AGENT" <<'EOF'
import re, sys
v, mathlib, lean, agent = sys.argv[1:5]
s = open("EDITION").read()
s = re.sub(r"(?m)^version .*$", "version " + v.lstrip("v"), s)
s = re.sub(r"(?m)^mathlib( .*)?$", "mathlib " + mathlib, s)
s = re.sub(r"(?m)^mathlib-lean( .*)?$", "mathlib-lean " + lean, s)
if re.search(r"(?m)^mathlib-agent( .*)?$", s):
    s = re.sub(r"(?m)^mathlib-agent( .*)?$", "mathlib-agent " + agent, s)
else:
    s += "mathlib-agent " + agent + "\n"
open("EDITION", "w").write(s)
line = (f"- `EDITION` pins mathlib at `{mathlib[:10]}`, mathlib-lean at `{lean[:10]}` and mathlib-agent at `{agent[:10]}`, "
        f"the commits of their release {v}.\n")
c = open("CHANGELOG.md").read()
head = "## Unreleased\n"
i = c.index(head) + len(head)
# The line goes first in the Changed part of the Unreleased section. With no Changed part, a new one goes first.
end = c.find("\n## ", i)
end = len(c) if end < 0 else end
j = c.find("### Changed\n\n", i, end)
if j >= 0:
    j += len("### Changed\n\n")
    c = c[:j] + line + c[j:]
else:
    c = c[:i] + "\n### Changed\n\n" + line + c[i:]
open("CHANGELOG.md", "w").write(c)
EOF
release_repo mathlib-handbook

echo "the release $V is done in the four repositories"
