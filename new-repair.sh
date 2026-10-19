#!/usr/bin/env bash

# Force script directory resolution to absolute path
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

if [ $# -lt 2 ]; then
  echo "Error: Missing arguments."
  echo "Usage: ./new-repair.sh [category] [name]"
  echo "Categories: gpus, motherboards, consoles, other"
  echo "Example: ./new-repair.sh gpus rtx3070-short"
  exit 1
fi

CATEGORY="$1"
NAME="$2"
DATE=$(date +%Y-%m-%d)

TARGET_DIR="$SCRIPT_DIR/$CATEGORY"
TEMPLATE_FILE="$SCRIPT_DIR/templates/case-template.md"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Category '$CATEGORY' does not exist in $SCRIPT_DIR."
  echo "Valid categories: gpus, motherboards, consoles, other"
  exit 1
fi

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Error: Template file not found at $TEMPLATE_FILE"
  exit 1
fi

FILENAME="$TARGET_DIR/logs/$DATE-$NAME.md"

if [ -f "$FILENAME" ]; then
  echo "Notice: File $FILENAME already exists. Opening existing file."
else
  cp "$TEMPLATE_FILE" "$FILENAME"
  echo "Created new log: $FILENAME"
fi

# Editor fallback detection for Arch
EDITOR_CMD=""
for ed in micro nano vim vi; do
  if command -v "$ed" &> /dev/null; then
    EDITOR_CMD="$ed"
    break
  fi
done

if [ -n "$EDITOR_CMD" ]; then
  "$EDITOR_CMD" "$FILENAME"
else
  echo "Warning: No standard text editor found (micro, nano, vim). File created at $FILENAME"
fi
