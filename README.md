# Log Analysis Script

This script is designed to analyze log files for patterns indicative of potential security issues. It is a tool to help diagnose and respond quickly to security incidents by searching for broad patterns that cover a wide range of potential threats.

## Features

- **Security-Focused Log Analysis**: The script scans log files for patterns that could indicate security problems, such as authentication failures, unauthorized access attempts, system errors, and more.
- **Comprehensive Pattern Matching**: Uses regular expressions to search for a wide variety of security-related terms, making it a versatile tool for detecting many types of potential issues.
- **Automated Reporting**: Generates a consolidated report with the results of the analysis, including detailed logs of all matched patterns.

## Usage Scenarios

- **Incident Response**: Quickly identify security issues in system logs after a suspected breach.

## Prerequisites

- **Bash**: The script is written in Bash and should be run on a system that supports Bash scripting.
- **Superuser Privileges**: The script must be executed with superuser privileges to access and analyze log files.

## Usage

1. **Ensure Superuser Privileges**: Before running the script, ensure you have the necessary permissions. The script will check for this and exit if not executed as root.

2. **Run the Script**: Execute the script by running:

   ```bash
   ./analyze_logs.sh
   ```

3. **Analyze the Logs**: The script will analyze the specified log files (by default, `/var/log/system.log`) and search for patterns defined in the script.

4. **View the Report**: After the analysis, a report is generated with a timestamp in its filename (e.g., `rapport_YYYYMMDD_HHMMSS.txt`). This report contains details about all matches found.

## How It Works

- **Log Files**: The script is set to analyze specific log files, such as `/var/log/system.log`. You can customize it by adding more log files to the `LOG_FILES` array.
  
- **Regex Patterns**: The script uses a set of predefined regular expressions to search for security-related events in the log files. These patterns include terms like "authentication failure," "unauthorized access," "critical error," etc.

- **Validation**: Before analyzing a log file, the script checks if the file exists and is readable. If a log file cannot be read, it is skipped, and a message is recorded in the report.

- **Report Generation**: The script generates a detailed report that includes the number of matches for each pattern and excerpts from the log files where the matches were found.

## Example Usage

To use the script:

```bash
sudo ./analyze_logs.sh
```

This will scan the log files for any indications of security issues and generate a report that you can review for further action.

## Customization

- **Adding Log Files**: To analyze additional log files, add their paths to the `LOG_FILES` array in the script.
- **Modifying Patterns**: You can customize or add new regular expression patterns in the `REGEX_PATTERNS` array to tailor the script to your specific needs.
  
![Capture d’écran 2024-08-20 à 20 35 31](https://github.com/user-attachments/assets/35a13abb-7fea-4692-92f1-40f8239f6e1d)
