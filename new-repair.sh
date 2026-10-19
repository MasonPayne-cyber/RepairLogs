#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: ./new-repair.sh [category] [name]"
  echo "Categories: gpus, motherboards, consoles, other"
  echo "Example: ./new-repair.sh gpus rtx3070-short"
  exit 1
fi

CATEGORY=$1
NAME=$2
DATE=$(date +%Y-%m-%d)

if [ ! -d "$CATEGORY" ]; then
  echo "Error: Category '$CATEGORY' does not exist."
  exit 1
fi

FILENAME="$CATEGORY/logs/$DATE-$NAME.md"
cp templates/case-template.md "$FILENAME"
echo "Created: $FILENAME"
nvim "$FILENAME"
