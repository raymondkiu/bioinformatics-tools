#!/usr/bin/env bash
# merge_bakta.sh
# Merge many Bakta summary .txt files into a single tab-delimited .tsv
# with exactly one header row.
#
# Usage:
#   ./merge_bakta.sh *.txt
#   ./merge_bakta.sh /path/to/bakta_outputs/*.txt
#   ./merge_bakta.sh -o results.tsv *.txt
#
# Output columns: file, Length, Count, GC, N50, N90, N ratio, coding density,
#                 tRNAs, tmRNAs, rRNAs, ncRNAs, ncRNA regions, CRISPR arrays,
#                 CDSs, pseudogenes, hypotheticals, sORFs, gaps, oriCs, oriVs, oriTs

set -euo pipefail

output="merged_bakta_summary.tsv"

show_help() {
    cat << 'EOF'
merge_bakta.sh - Merge multiple Bakta summary .txt files into one TSV

DESCRIPTION
    Parses the "key: value" lines from Bakta annotation summary files
    (the Sequence(s): / Annotation: report block) and combines them
    into a single tab-delimited table, one row per input file, with
    exactly one header row.

USAGE
    ./merge_bakta.sh [-o output.tsv] file1.txt file2.txt ...
    ./merge_bakta.sh [-o output.tsv] *.txt
    ./merge_bakta.sh [-o output.tsv] /path/to/bakta_outputs/*.txt

OPTIONS
    -o FILE       Write output to FILE (default: merged_bakta_summary.tsv)
    -h, --help    Show this help message and exit

OUTPUT COLUMNS
    file, Length, Count, GC, N50, N90, N ratio, coding density,
    tRNAs, tmRNAs, rRNAs, ncRNAs, ncRNA regions, CRISPR arrays,
    CDSs, pseudogenes, hypotheticals, sORFs, gaps, oriCs, oriVs, oriTs

NOTES
    - Fields missing from a given file are written as "NA".
    - Field matching works regardless of which section (Sequence(s):
      or Annotation:) a key appears under.

EXAMPLES
    ./merge_bakta.sh *.txt
    ./merge_bakta.sh -o all_genomes.tsv results/*.txt
EOF
}

# Parse options
while [[ "${1:-}" == -* ]]; do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -o)
            output="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Try '$0 --help' for usage." >&2
            exit 1
            ;;
    esac
done

if [[ $# -eq 0 ]]; then
    echo "Error: no input files given." >&2
    echo "Try '$0 --help' for usage." >&2
    exit 1
fi

# Field names, in the order Bakta prints them. Keys are matched exactly
# (case-sensitive, trimmed) against the "key: value" lines in each file.
fields=(
    Length Count GC N50 N90 "N ratio" "coding density"
    tRNAs tmRNAs rRNAs ncRNAs "ncRNA regions" "CRISPR arrays"
    CDSs pseudogenes hypotheticals sORFs gaps oriCs oriVs oriTs
)

# Write header once
{
    printf "file"
    for f in "${fields[@]}"; do
        printf "\t%s" "$f"
    done
    printf "\n"
} > "$output"

for file in "$@"; do
    if [[ ! -f "$file" ]]; then
        echo "Warning: skipping missing file '$file'" >&2
        continue
    fi

    declare -A vals=()

    # Parse every "key: value" line in the file (works across both the
    # Sequence(s): and Annotation: sections without needing to track them).
    while IFS=':' read -r key value; do
        key="$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        [[ -z "$key" ]] && continue
        # value may itself contain no colon issues here since all Bakta
        # values are simple numbers
        value="$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        vals["$key"]="$value"
    done < "$file"

    printf "%s" "$(basename "$file")" >> "$output"
    for f in "${fields[@]}"; do
        printf "\t%s" "${vals[$f]:-NA}" >> "$output"
    done
    printf "\n" >> "$output"

    unset vals
done

echo "Done. Merged $# file(s) into $output" >&2
