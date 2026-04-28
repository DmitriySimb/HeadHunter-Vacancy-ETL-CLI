#!/bin/sh

set -e

script_dir="$(cd "$(dirname "$0")" && pwd)"

query="${1:-Data Scientist}"

"${script_dir}/fetch_vacancies.sh" "$query"
"${script_dir}/json_to_csv.sh"
"${script_dir}/sort_csv.sh"
"${script_dir}/extract_positions.sh"
"${script_dir}/count_positions.sh"
"${script_dir}/partition_by_date.sh"
"${script_dir}/concatenate_partitions.sh"