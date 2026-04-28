#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

input_dir="${project_root}/data/partitions"
output_file="${project_root}/data/processed/hh_concatenated.csv"

first_file=$(find "$input_dir" -name "20*.csv" | sort | head -n 1)

if [ -z "$first_file" ]; then
    echo "No partition files found in $input_dir"
    exit 1
fi

head -n 1 "$first_file" > "$output_file"

find "$input_dir" -name "20*.csv" | sort | while IFS= read -r file; do
    tail -n +2 "$file" >> "$output_file"
done