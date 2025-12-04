#!/usr/bin/env bash

YEAR=2025
COOKIE="${AOC_SESSION_COOKIE}"
# Please set your own user agent here
USER_AGENT="github.com/RealPotatoe via script"

if [ -z "$COOKIE" ]; then
    echo "Error: AOC_SESSION_COOKIE environment variable is not set."
    exit 1
fi

echo "🎄 Fetching inputs for aoc $YEAR..."

for day in {1..12}; do
    padded_day=$(printf "%02d" "$day")
    dir_name="day$padded_day"
    file_path="$dir_name/input.txt"
    url="https://adventofcode.com/$YEAR/day/$day/input"

    if [ ! -d "$dir_name" ]; then
        echo "Day $padded_day: Creating directory..."
        mkdir -p "$dir_name"
    fi

    if [ -f "$file_path" ]; then
        echo "  Day $padded_day: Input already exists. Skipping."
        continue
    fi

    echo -n "  Day $padded_day: Fetching... "

    http_code=$(curl -s -w "%{http_code}" -o "$file_path" -b "session=$COOKIE" \
        -A "$USER_AGENT" \
        "$url")

    if [ "$http_code" == "200" ]; then
        echo "✅ Success!"
    else
        echo "❌ Failed (HTTP $http_code)"
        rm -f "$file_path"
        break
    fi

    # Be polite to the server
    sleep 0.2
done