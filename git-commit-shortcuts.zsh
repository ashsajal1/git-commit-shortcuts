# git-commit-shortcuts.zsh
types_map=(
  feat "✨ feat"
  fix  "🐛 fix"
  docs "📝 docs"
  style "💄 style"
  refactor "♻️ refactor"
  perf "⚡ perf"
  test "✅ test"
  chore "🔧 chore"
  build "🏗️ build"
  ci "🔁 ci"
  revert "⏪ revert"
)

_get_type_label() {
  local key=$1
  local i=1
  while [ $i -le ${#types_map[@]} ]; do
    if [ "${types_map[$i]}" = "$key" ]; then
      echo "${types_map[$i+1]}"
      return 0
    fi
    ((i+=2))
  done
  echo "🔖 $key"
}

_git_commit_with_icon() {
  local type=$1
  shift
  local label=$(_get_type_label "$type")

  local subject
  if [ $# -gt 0 ]; then
    subject="$*"
  else
    echo -n "Commit subject for ${label}: "
    IFS= read -r subject
  fi

  # If no subject and stdin is a tty, abort
  if [ -z "$subject" ] && [ -t 0 ]; then
    echo "Aborted: empty subject."
    return 1
  fi

  # Read piped stdin (if any) as body
  local body=""
  if [ ! -t 0 ]; then
    body="$(cat -)"
  fi

  # Build commit message file without adding extra quotes
  local full_subject="${label}: ${subject}"
  local tmpfile
  tmpfile="$(mktemp /tmp/gitmsg.XXXXXX)"

  {
    printf '%s\n' "$full_subject"
    if [ -n "$body" ]; then
      printf '\n%s' "$body"
    fi
  } >| "$tmpfile"

  git add -A

  if git commit -F "$tmpfile"; then
    rm -f "$tmpfile"
    return 0
  else
    echo "git commit failed."
    rm -f "$tmpfile"
    return 1
  fi
}

_create_wrappers() {
  local i=1
  while [ $i -le ${#types_map[@]} ]; do
    local key="${types_map[$i]}"
    local fname="g${key//[^a-zA-Z0-9]/}"
    eval "
    $fname() {
      _git_commit_with_icon '$key' \"\$@\"
    }
    "
    ((i+=2))
  done
}
_create_wrappers

ghelp() {
  echo "Available git shortcuts:"
  local i=1
  while [ $i -le ${#types_map[@]} ]; do
    printf "  g%s\t→ %s\n" "${types_map[$i]}" "${types_map[$i+1]}"
    ((i+=2))
  done
  echo
  echo "Usage examples:"
  echo "  gfeat add login button"
  echo "  gfix"
  echo "  echo \"Detailed body\" | gdocs update docs"
}
