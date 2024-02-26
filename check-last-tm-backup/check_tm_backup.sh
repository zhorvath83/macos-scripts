#!/bin/bash

# Get the date of the last Time Machine backup
last_backup=$(tmutil latestbackup | xargs basename)

# Extracted date components
year=${last_backup:0:4}
month=${last_backup:5:2}
day=${last_backup:8:2}
hour=${last_backup:11:2}
minute=${last_backup:13:2}
second=${last_backup:15:2}

formatted_last_backup_date="${year}-${month}-${day}-${hour}${minute}${second}"

echo "Date of last backup: $formatted_last_backup_date"

last_backup_timestamp=$(date -j -f "%Y-%m-%d-%H%M%S" "${formatted_last_backup_date}" "+%s")

echo "Timestamp of last backup: $last_backup_timestamp"

actual_timestamp=$(date "+%s")

echo "Actual epoch time: $actual_timestamp"

# Calculate the difference in days
elapsed_hours=$(( ($actual_timestamp - $last_backup_timestamp) / 3600 ))

echo "Elapsed hours since last TM backup: $elapsed_hours"

# Alert if the difference is more than X
if [ "$elapsed_hours" -gt 48 ]; then

    # create a reminder
    osascript -e 'set computerName to do shell script "scutil --get ComputerName"' -e 'tell application "Reminders" to make new reminder with properties {name:"Check Time Machine Backup on " & computerName, body:"Your last Time Machine backup is older than '"$elapsed_hours"' hours.", remind me date:(current date) + 1 * minutes}'

fi
