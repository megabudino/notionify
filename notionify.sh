#!/usr/bin/env bash

usage() {
  echo "Usage: notionify.sh <markdown-file.md>"
}

if [ "$#" -ne 1 ]; then
  usage
  exit 1
fi

input_file="$1"

if [[ "$input_file" != *.md ]]; then
  echo "Error: input file must have a .md extension."
  exit 1
fi

if [ ! -f "$input_file" ]; then
  echo "Error: '$input_file' not found in current directory."
  exit 1
fi

echo "Input validated: $input_file"
exit 0
