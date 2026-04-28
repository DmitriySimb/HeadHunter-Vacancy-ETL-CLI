# HeadHunter Vacancy ETL CLI

This project is a simple ETL pipeline built with shell scripts for collecting and processing job vacancy data from the HeadHunter API.

**What is ETL?**

ETL stands for Extract → Transform → Load — a common data processing workflow:

- Extract — get raw data (in this case from the hh.ru API)  
- Transform — clean and reshape it (JSON → CSV, sorting, filtering)  
- Load — save the result in a usable format  

In simple terms: we take messy raw data and turn it into something structured and ready for analysis.

---

## Overview

This project implements a full data processing pipeline using standard UNIX command-line tools.

The pipeline performs the following steps:

1. Fetches job vacancies from hh.ru  
2. Stores them as JSON  
3. Converts JSON into CSV (tabular format)  
4. Sorts the data  
5. Extracts job level (Junior / Middle / Senior)  
6. Computes basic statistics  
7. Splits data by date  
8. Merges everything back into a single dataset  

---

## Quick Start

Run the full pipeline with a single command:

```sh
./scripts/run_pipeline.sh "Data Scientist"
```

---

## Requirements

Make sure the following tools are installed:

- POSIX shell (`sh` or `bash`)
- curl
- jq (for JSON processing)
- awk
- sed
- sort
- uniq

Check:

```sh
which curl jq awk sed sort uniq
```

---

## Project Structure

```text
.
├── data/
│   ├── raw/           # raw JSON data
│   ├── processed/     # processed CSV files
│   └── partitions/    # data split by date
├── filters/
│   └── vacancies_to_csv.jq
├── scripts/
│   ├── fetch_vacancies.sh
│   ├── json_to_csv.sh
│   ├── sort_csv.sh
│   ├── extract_positions.sh
│   ├── count_positions.sh
│   ├── partition_by_date.sh
│   ├── concatenate_partitions.sh
│   └── run_pipeline.sh
└── README.md
└── README_RUS.md
```

---

## How the Pipeline Works (in simple terms)

### 1. Fetching data

The script sends a request to the HeadHunter API and saves vacancies as JSON.  
This is the raw data — convenient for machines, not for humans.

---

### 2. Converting to CSV

JSON is transformed into a table (CSV), where each row represents a vacancy.

Only relevant fields are kept:

- id  
- creation date  
- job title  
- test requirement  
- link  

---

### 3. Sorting

Data is sorted:

- first by date  
- then by id  

This makes it easier to analyze and process further.

---

### 4. Cleaning and extracting job level

The script extracts the job level from the title:

- Junior  
- Middle  
- Senior  
- or - if not specified  

Example:

```text
"Senior Data Scientist" → "Senior"
```

---

### 5. Counting statistics

The script counts how many vacancies belong to each level:

```text
Junior — 8
Middle — 1
- — 11
```

This gives a quick overview of the job market distribution.

---

### 6. Splitting data by date

Data is split into separate files based on the creation date:

```text
2025-10-22.csv
2025-10-23.csv
...
```

This approach is useful when working with larger datasets.

---

### 7. Merging data back

All partitioned files are merged back into a single dataset.  
This step verifies that splitting and reconstruction work correctly.

---

## Example Output

After running the pipeline, you get a dataset like:

```csv
"id","created_at","name","has_test","alternate_url"
"126813281","2025-10-22T11:06:54+0300","Junior",false,"https://hh.ru/vacancy/126813281"
"126886506","2025-10-23T17:01:43+0300","-",false,"https://hh.ru/vacancy/126886506"
"127063385","2025-10-28T14:15:12+0300","Junior",false,"https://hh.ru/vacancy/127063385"
```

And a summary file with statistics:

```csv
"name","count"
"-",11
"Junior",8
"Middle",1
```

---

## What this project demonstrates

- working with real APIs  
- JSON processing using jq  
- text processing (awk, sed)  
- sorting and aggregating data  
- building a simple data pipeline  
- structuring a project  

---

## Key Features

- fully implemented in shell (no frameworks)  
- works with real-world data  
- reproducible workflow  
- modular pipeline (step-by-step scripts)  
- can be executed with a single command  

---

## Note

This project was originally implemented as part of a UNIX data processing course and later refactored into a standalone ETL pipeline for portfolio purposes.
