#!/bin/bash

# This script takes all content to be fed into the AI model
find . \( -name "*.md" -o -name "*.sh" -o -name "*.sh" \) -type f -print0 | while IFS= read -r -d $'\0' file; do
    echo "---"
    sed 's/^/# /' <<< "$(basename "$file")"
    echo "---"
    cat "$file"
    echo ""
done > merged_file.txt
