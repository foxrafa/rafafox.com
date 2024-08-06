#!/bin/bash

if [ -z "$1" ]; then
  echo "Please provide the duration in hh,mm format."
  exit 1
fi

duration=$1
IFS=',' read -r hours minutes <<< "$duration"

if ! [[ "$hours" =~ ^[0-9]+$ ]] || ! [[ "$minutes" =~ ^[0-9]+$ ]]; then
  echo "Invalid format. Please provide the duration in hh,mm format."
  exit 1
fi

current_date=$(date +%d-%m-%Y)

# Determine the correct pluralization for hours and minutes
if [ "$hours" -eq 1 ]; then
  hour_label="hour"
else
  hour_label="hours"
fi

if [ "$minutes" -eq 1 ]; then
  minute_label="minute"
else
  minute_label="minutes"
fi

new_entry="        <div class=\"work-entry\"><span class=\"date\">$current_date:</span> ${hours} ${hour_label} and ${minutes} ${minute_label}</div>"

sed -i '' "/<div id=\"work-log\">/a\\
$new_entry\\
" out/effort.html

echo "Work hours for $current_date added to out/effort.html"
