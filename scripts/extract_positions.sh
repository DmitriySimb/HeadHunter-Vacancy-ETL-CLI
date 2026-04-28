#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

input_file="${project_root}/data/processed/hh_sorted.csv"
output_file="${project_root}/data/processed/hh_positions.csv"

head -n 1 "$input_file" > "$output_file"

awk -F'",' '
NR>1 {
    name = $3
    level = "-"

    if (name ~ /Junior/) level = "Junior"

    if (name ~ /Middle/) {
        if (level == "-") level = "Middle"
        else level = level"/Middle"
    }

    if (name ~ /Senior/) {
        if (level == "-") level = "Senior"
        else level = level"/Senior"
    }

    print $1"\","$2"\",\""level"\","$4
}' "$input_file" >> "$output_file"
