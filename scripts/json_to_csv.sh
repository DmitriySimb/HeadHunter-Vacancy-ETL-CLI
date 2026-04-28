#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

input_file="${project_root}/data/raw/hh.json"
output_file="${project_root}/data/processed/hh.csv"
filter_file="${project_root}/filters/vacancies_to_csv.jq"

mkdir -p "${project_root}/data/processed"

jq -r -s -f "$filter_file" "$input_file" > "$output_file"