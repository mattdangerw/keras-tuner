#!/bin/bash

base_dir=$(dirname $(dirname $0))

isort --sl -c "${base_dir}"
if ! [ $? -eq 0 ]; then
  echo "Please run \"./shell/format.sh\" to format the code."
  exit 1
fi
flake8 "${base_dir}"
if ! [ $? -eq 0 ]; then
  echo "Please fix the code style issue."
  exit 1
fi
black --check --line-length 85 "${base_dir}"
if ! [ $? -eq 0 ]; then
  echo "Please run \"./shell/format.sh\" to format the code."
    exit 1
fi
for i in $(find "${base_dir}" -name '*.py'); do
  if ! grep -q Copyright $i; then
    echo "Please run \"./shell/format.sh\" to format the code."
    exit 1
  fi
done
