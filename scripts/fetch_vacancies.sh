#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"
project_root="$(cd "${script_dir}/.." && pwd)"

query="${1:-Data Scientist}"
output_file="${project_root}/data/raw/hh.json"

mkdir -p "${project_root}/data/raw"

encoded_query=$(printf "%s" "$query" | sed 's/ /+/g')

curl -s "https://api.hh.ru/vacancies?professional_role=165&per_page=20&text=${encoded_query}" \
    | jq '.items[]' > "$output_file"