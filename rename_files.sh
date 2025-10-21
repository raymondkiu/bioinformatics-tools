#!/bin/bash
# ===========================================================
# Rename files recursively: prefix or suffix mode
# Version: 1.0
# Author: Raymond Kiu
# Usage:
#   Prefix mode: ./rename_files.sh -p PREFIX pattern1 [pattern2 ...]
#   Suffix mode: ./rename_files.sh -s OLD_EXT NEW_EXT [TARGET_DIR]
#
# Options:
#   -h        Show help
#   -v        Show version
#   -a        Show author
#   -p        Prefix mode
#   -s        Suffix mode
# ===========================================================

VERSION="1.0"
AUTHOR="Raymond Kiu"

prefix_mode=0
suffix_mode=0

# --- parse options ---
while getopts ":hvap:s:" opt; do
  case $opt in
    h)
      echo "Usage:"
      echo "  Prefix mode: $0 -p PREFIX pattern1 [pattern2 ...]"
      echo "  Suffix mode: $0 -s OLD_EXT NEW_EXT [TARGET_DIR]"
      echo ""
      echo "Options:"
      echo "  -h        Show help"
      echo "  -v        Show version"
      echo "  -a        Show author"
      echo "  -p        Prefix mode"
      echo "  -s        Suffix mode"
      exit 0
      ;;
    v)
      echo "$0 version $VERSION"
      exit 0
      ;;
    a)
      echo "Author: $AUTHOR"
      exit 0
      ;;
    p)
      prefix_mode=1
      prefix="$OPTARG"
      shift $((OPTIND -1))
      break
      ;;
    s)
      suffix_mode=1
      oldext="$OPTARG"
      shift $((OPTIND -1))
      newext="$1"
      shift
      break
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# --- PREFIX MODE ---
if [ $prefix_mode -eq 1 ]; then
    if [ $# -lt 1 ]; then
        echo "Error: No pattern provided for prefix mode."
        echo "Usage: $0 -p PREFIX pattern1 [pattern2 ...]"
        exit 1
    fi

    # Enable recursive globs like **/*.fa
    shopt -s globstar nullglob

    for pattern in "$@"; do
        for file in $pattern; do
            if [ -f "$file" ]; then
                dir=$(dirname "$file")
                base=$(basename "$file")
                newname="${dir}/${prefix}${base}"
                mv "$file" "$newname"
                echo "Renamed: $file → $newname"
            fi
        done
    done
    exit 0
fi

# --- SUFFIX MODE ---
if [ $suffix_mode -eq 1 ]; then
    target="${1:-.}"  # optional target directory

    if [ -z "$oldext" ] || [ -z "$newext" ]; then
        echo "Error: old_ext and new_ext are required for suffix mode."
        echo "Usage: $0 -s OLD_EXT NEW_EXT [TARGET_DIR]"
        exit 1
    fi

    if [ ! -d "$target" ]; then
        echo "Error: directory '$target' not found."
        exit 2
    fi

    if [ "$oldext" = "any" ]; then
        find "$target" -type f | while read -r f; do
            newname="${f%.*}.$newext"
            echo "Renaming: $f → $newname"
            mv "$f" "$newname"
        done
    else
        find "$target" -type f -name "*.$oldext" | while read -r f; do
            newname="${f%.$oldext}.$newext"
            echo "Renaming: $f → $newname"
            mv "$f" "$newname"
        done
    fi
    exit 0
fi

# --- If no mode selected ---
echo "Error: You must select a mode: -p (prefix) or -s (suffix)"
echo "Use -h for help."
exit 1
