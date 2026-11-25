#!/usr/bin/env bash
# Checks whether newer Hugo and Pagefind releases exist, tries a site build with each,
# and opens one pull request per tool that bumps its version file.
#
#   .hugo-version      read by deploy.yml and linkcheck.yml
#   .pagefind-version  read by deploy.yml
#
# Environment:
#   DRY_RUN=true       report what would happen; create no branch, pull request or issue
#   DEFAULT_BRANCH     base branch for pull requests (default: main)
#   GH_TOKEN           token for the gh CLI (the workflow passes github.token)
set -euo pipefail

DRY_RUN="${DRY_RUN:-false}"
DEFAULT_BRANCH="${DEFAULT_BRANCH:-main}"
SITE_URL="https://holmgrown.com/tsak/"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

read_version() { tr -d '[:space:]' < "$1"; }

# is_newer CURRENT LATEST: true when LATEST is a higher version than CURRENT
is_newer() {
  [ "$1" != "$2" ] && [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n1)" = "$2" ]
}

# hugo_bin VERSION: downloads that extended Hugo release (once) and prints its path
hugo_bin() {
  local dir="$work/hugo-$1"
  if [ ! -x "$dir/hugo" ]; then
    mkdir -p "$dir"
    curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v$1/hugo_extended_$1_linux-amd64.tar.gz" \
      | tar -xz -C "$dir" hugo
  fi
  echo "$dir/hugo"
}

# build_site HUGO_VERSION OUTPUT_DIR: the same build the deploy workflow does
build_site() {
  local bin
  bin="$(hugo_bin "$1")"
  "$bin" build --minify --baseURL "$SITE_URL" --destination "$2"
}

# open_bump TOOL FILE OLD NEW RESULT RELEASE_URL NOTE
open_bump() {
  local tool=$1 file=$2 old=$3 new=$4 result=$5 url=$6 note=$7
  local branch="tool-versions/$tool-$new" title="Bump $tool from $old to $new"
  local body="$work/body-$tool.md"

  cat > "$body" <<EOF
Automated by the "Tool versions" workflow.

- **Tool:** $tool
- **Change:** $old to $new (\`$file\`)
- **Release notes:** $url
- **Test build with $new:** $result

$note

Pull requests created with the workflow token do not start other workflows, so the Link check
has not run on this branch. Run it by hand from the Actions tab if you want it, or just merge:
the deploy workflow builds the site with the new version when this reaches \`$DEFAULT_BRANCH\`.
EOF

  if [ "$DRY_RUN" = "true" ]; then
    echo "DRY RUN: would open \"$title\" from $branch"
    sed 's/^/    | /' "$body"
    return
  fi
  if git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
    echo "Branch $branch already exists; not opening a duplicate."
    return
  fi

  git switch -q -c "$branch" "origin/$DEFAULT_BRANCH"
  printf '%s\n' "$new" > "$file"
  git add "$file"
  git commit -q -m "$title"
  git push -q origin "$branch"
  if ! gh pr create --base "$DEFAULT_BRANCH" --head "$branch" --title "$title" --body-file "$body"; then
    echo "Could not open a pull request (is 'Allow GitHub Actions to create and approve pull requests' off?). Opening an issue instead."
    gh issue create --title "$title" --body-file "$body"
  fi
  git switch -q --detach "origin/$DEFAULT_BRANCH"
}

if [ "$DRY_RUN" != "true" ]; then
  git config user.name "github-actions[bot]"
  git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
  git fetch -q origin "$DEFAULT_BRANCH"
fi

current_hugo="$(read_version .hugo-version)"
current_pagefind="$(read_version .pagefind-version)"
latest_hugo="$(gh api repos/gohugoio/hugo/releases/latest --jq '.tag_name' | sed 's/^v//')"
latest_pagefind="$(npm view pagefind version)"
echo "Hugo:     pinned $current_hugo, latest $latest_hugo"
echo "Pagefind: pinned $current_pagefind, latest $latest_pagefind"

if is_newer "$current_hugo" "$latest_hugo"; then
  if build_site "$latest_hugo" "$work/site-hugo-new" >"$work/hugo.log" 2>&1; then
    result="passed"
  else
    result="FAILED. The log tail is below."
    tail -n 20 "$work/hugo.log"
  fi
  open_bump hugo .hugo-version "$current_hugo" "$latest_hugo" "$result" \
    "https://github.com/gohugoio/hugo/releases/tag/v$latest_hugo" \
    "Hugo releases can change template behaviour. Check the release notes for anything that touches the \`layouts/\` directory."
else
  echo "Hugo is up to date."
fi

if is_newer "$current_pagefind" "$latest_pagefind"; then
  # Build the site with the pinned Hugo, then index it with the new Pagefind
  build_site "$current_hugo" "$work/site-pagefind" >"$work/pagefind-site.log" 2>&1
  if npx -y "pagefind@$latest_pagefind" --site "$work/site-pagefind" >"$work/pagefind.log" 2>&1; then
    result="passed (the index was built)"
  else
    result="FAILED. The log tail is below."
    tail -n 20 "$work/pagefind.log"
  fi
  open_bump pagefind .pagefind-version "$current_pagefind" "$latest_pagefind" "$result" \
    "https://github.com/Pagefind/pagefind/releases/tag/v$latest_pagefind" \
    "This only checks that an index can be built. Try a search on the live site after it deploys, because the search page loads Pagefind's UI script from the same version."
else
  echo "Pagefind is up to date."
fi
