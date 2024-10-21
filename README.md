# Navicat Registry Cleaner

A Windows batch tool for cleaning Navicat Premium registry entries. This tool automatically cleans specific registry items and provides detailed operation logs.

## Features

- Automatic cleanup of Navicat Premium related registry entries
- Detailed operation logging
- Automatic cleaning of historical logs (7-day retention by default)
- Can be configured as a Windows scheduled task
- Secure registry operation mechanism

## Usage

### Direct Execution

1. Download the `cracker.bat` file
2. Run the script with administrator privileges
3. The script will automatically create a `logs` folder and record operation logs

### Setting up as a Scheduled Task

1. Open Windows Task Scheduler (Press Win+R, type `taskschd.msc`)
2. Create a basic task
3. Choose frequency (weekly or monthly recommended)
4. Select program/script: Browse to select `cracker.bat`
5. Complete creation, recommend setting "Run with highest privileges" in task properties

## Log Description

- Log files are located in the `logs` folder in the same directory as the script
- Log file naming format: `cleanup_YYYYMMDD.log`
- Each run appends records to the current day's log file
- Automatically cleans log files older than 7 days by default

## Registry Cleaning Scope

The script cleans the following registry entries:
1. `HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Update`
2. `HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Registration[version and language]`
3. Specific entries containing "Info" or "ShellFolder" under `HKEY_CURRENT_USER\Software\Classes\CLSID`

## Disclaimer

This tool is provided for learning and research purposes only. Users assume all responsibility for any issues caused by using this tool. Please ensure you understand the impact of its operations on your system before use.

## License

[MIT License](LICENSE)

## Changelog

### v1.0.0 (2024-10-21)
- Initial release
- Implemented basic registry cleaning functionality
- Added logging functionality
- Added automatic historical log cleaning
