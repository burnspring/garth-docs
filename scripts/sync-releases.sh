#!/usr/bin/env bash
# Copy Garth's release notes (release-notes/<version>.md in the garth repository,
# one per release) into the Release notes guide as releases/vX-Y-Z.md. The garth
# repository writes them; this site only publishes them. Run it after a release,
# then commit and push here: the push republishes the site. (As toft-docs does.)
set -euo pipefail
here="$(cd "$(dirname "$0")/.." && pwd)"
src="${GARTH_CHECKOUT:-$here/../garth}/release-notes"
for f in "$src"/*.md; do
  v=$(basename "$f" .md)
  cp "$f" "$here/src/content/docs/releases/v${v//./-}.md"
done
echo "synced $(ls "$src"/*.md | wc -l) release notes from $src"
