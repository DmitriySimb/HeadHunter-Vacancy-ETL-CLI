#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

input_file="${project_root}/data/processed/hh_positions.csv"
output_dir="${project_root}/data/partitions"

mkdir -p "$output_dir"

find "$output_dir" -type f -name "20*.csv" -exec rm -f {} \;

header=$(head -n 1 "$input_file")

tail -n +2 "$input_file" | while IFS= read -r line; do
    created=$(echo "$line" | awk -F'","' '{ print $2 }' | awk -F'T' '{ print $1 }')
    file="${output_dir}/${created}.csv"

    if [ ! -f "$file" ]; then
        echo "$header" > "$file"
    fi

    echo "$line" >> "$file"
done
