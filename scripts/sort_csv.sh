#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

input_file="${project_root}/data/processed/hh.csv"
output_file="${project_root}/data/processed/hh_sorted.csv"

head -n 1 "$input_file" > "$output_file"
tail -n +2 "$input_file" | sort -t ',' -k2,2 -k1,1 >> "$output_file"