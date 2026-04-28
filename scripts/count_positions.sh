#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

input_file="${project_root}/data/processed/hh_positions.csv"
output_file="${project_root}/data/processed/hh_uniq_positions.csv"

awk -F',' 'NR>1 { print $3 }' "$input_file" | sort | uniq -c | sort -nr | \
awk '
BEGIN {
    print "\"name\",\"count\""
}
{
    printf "%s,%s\n", $2, $1
}' > "$output_file"