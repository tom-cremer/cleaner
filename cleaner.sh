#!/opt/homebrew/bin/bash

BASE_DIR="$1"

mapfile -d '' FILES < <(find "$BASE_DIR" \
  \( \
    -type d \( \
      -name node_modules -o \
      -name vendor -o \
      -name .git -o \
      -name .idea -o \
      -name __pycache__ -o \
      -name .gitlab -o \
      -name mu-plugins -o \
      -name wp-includes \
    \) -prune \
  \) -o \
  \( -type d -name app ! -name '*-app' ! -name 'app-*' -prune \) -o \
  \( -type f -name '._*' -print0 \))

COUNT=${#FILES[@]}

if [ "$COUNT" -eq 0 ]; then
  echo "No '._' files found."
else
  echo "$COUNT '._' files deleted:"
  printf '%s\n' "${FILES[@]}"
  printf '%s\0' "${FILES[@]}" | xargs -0 rm -f
fi
