#!/usr/bin/env bash
set -euo pipefail

# --- config you can tweak (optional) ---
PUBLIC_HTML="/common/web/$USER/public_html"
JEKYLL_BUILD_CMD="bundle exec jekyll build"
JEKYLL_CLEAN_CMD="bundle exec jekyll clean"
# ---------------------------------------

echo "[1/7] Ensuring Bundler is available on PATH…"
# Add user gem bin dir to PATH for this shell
RUBY_USER_BIN="$(ruby -e 'require "rubygems"; print Gem.user_dir')/bin"
export PATH="$RUBY_USER_BIN:$PATH"

if ! command -v bundle >/dev/null 2>&1; then
  echo "Bundler not found; installing to user gems…"
  gem install bundler --user-install
fi

echo "[2/7] Installing gems into vendor/bundle (no sudo)…"
bundle config set path 'vendor/bundle' >/dev/null
bundle install --retry 3 --jobs 4

echo "[3/7] Cleaning Jekyll buils..."
$JEKYLL_CLEAN_CMD

echo "[4/7] Building site with Jekyll…"
$JEKYLL_BUILD_CMD

echo "[5/7] Creating public_html if needed…"
rm -rf "$PUBLIC_HTML/"
mkdir -p "$PUBLIC_HTML"
``
echo "[6/7] Syncing _site/ → $PUBLIC_HTML (and removing stale files)…"
cp -r _site/. "$PUBLIC_HTML/"

echo "[7/7] Fixing permissions so the web server can read files…"
chmod 755 "$HOME" "$PUBLIC_HTML"
find "$PUBLIC_HTML" -type d -exec chmod 755 {} \;
find "$PUBLIC_HTML" -type f -exec chmod 644 {} \;

NETID="$(whoami)"
URL="https://people.cs.rutgers.edu/~$NETID/"
echo
echo "✅ Deployed! Visit: $URL"