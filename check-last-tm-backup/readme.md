# Checking the last Time Machine backup

A script to alert via Apple reminder if your Time Machine backup is older than 2 days. 
The script checks the date of the last Time Machine backup and, if it exceeds 2 days, creates a new reminder.

## Make the script executable 
By running `chmod +x check_tm_backup.sh` in the Terminal...

## Scheduling the Script

1. Open the Terminal.
2. Type crontab -e and press Enter to edit your cron jobs.
3. Add a line to run the script at your preferred interval: `0 12 * * * ~/Library/Scripts/check_tm_backup.sh`
