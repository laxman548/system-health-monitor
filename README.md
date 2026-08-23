Linux System Health Monitor

A Bash-based Linux system health monitoring project built as part of my DevOps and Cloud Engineering learning journey.

The project is being developed incrementally — first understanding Linux commands and system information manually, then implementing the logic in Bash, testing it, modularizing the code, and finally versioning the changes using Git and GitHub.

1. Project Objective

The goal is to build a Linux system health monitoring utility that can collect and report important system health information.

The planned monitoring areas are:

System information
CPU usage
Memory usage
Disk usage
Running processes
Filesystem status
Health thresholds
Logging
Scheduled monitoring

The project is intentionally being developed feature by feature rather than creating the complete solution at once.

2. Development Environment

Current environment:

OS          : Ubuntu 24.04.1 LTS
Environment : WSL2
Shell       : Bash
Kernel      : 6.18.33.2-microsoft-standard-WSL2
Version     : Git
Repository  : GitHub

The Linux environment was verified using:

cat /etc/os-release
uname -r
3. Project Initialization

The project was created in the Linux environment at:

/home/laxman/projects/system-health-monitor

The project directory was created and verified using:

mkdir system-health-monitor
cd system-health-monitor
pwd

Git was initialized:

git init

The default branch was changed to:

main

The Git repository was verified using:

git status
4. GitHub Repository Setup

A GitHub repository was created for the project.

The local repository was connected to GitHub using:

git remote add origin https://github.com/laxman548/system-health-monitor.git

The remote connection was verified using:

git remote -v

The initial project was pushed using:

git push -u origin main

After the initial setup, future changes are published using:

git push
5. First Implementation — System Information

The first version of the application was created in:

system-health-monitor.sh

The objective was to collect basic Linux system information.

The first version collects:

Hostname
Current User
Operating System
Kernel Version
System Uptime
5.1 Hostname

Linux hostname was checked using:

hostname

The Bash implementation:

HOSTNAME=$(hostname)
5.2 Current User

The current Linux user was checked using:

whoami

The Bash implementation:

CURRENT_USER=$(whoami)
5.3 Operating System

Linux operating system information is available in:

/etc/os-release

The OS name was extracted using:

OS=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d '"' -f 2)

Example:

Ubuntu 24.04.1 LTS
5.4 Kernel

The Linux kernel version was checked using:

uname -r

The Bash implementation:

KERNEL=$(uname -r)
5.5 System Uptime

System uptime was checked using:

uptime -p

The Bash implementation:

UPTIME=$(uptime -p)
6. Bash Concepts Learned

During the initial implementation, the following Bash concepts were practiced:

Variables
Command substitution
echo
grep
cut
awk
Linux commands
Script execution
File permissions
Bash functions
Bash arrays
Conditional statements
Error handling

Example of command substitution:

HOSTNAME=$(hostname)

This executes the Linux command and stores its output in a Bash variable.

7. CPU Monitoring

After completing basic system information, CPU monitoring was implemented.

Instead of relying only on an external monitoring command, the CPU information was obtained directly from the Linux /proc filesystem.

The source used is:

/proc/stat

CPU information was inspected manually using:

cat /proc/stat | grep '^cpu '

Example:

cpu  1163 0 3305 8010434 612 0 731
8. Understanding CPU Statistics

The CPU values in /proc/stat are cumulative CPU time counters.

The project extracts the required values using:

cat /proc/stat | grep '^cpu ' | awk '{print $2, $3, $4, $5, $6, $7, $8}'

The current implementation uses:

User Time
System Time
Idle Time
I/O Wait Time

A single reading cannot directly give the CPU utilization for the current moment.

Therefore, two samples are taken at different times.

9. CPU Sampling

First CPU sample:

CPU1=$(cat /proc/stat | grep '^cpu ' | awk '{print $2, $3, $4, $5, $6, $7, $8}')

The script waits for two seconds:

sleep 2

Second CPU sample:

CPU2=$(cat /proc/stat | grep '^cpu ' | awk '{print $2, $3, $4, $5, $6, $7, $8}')

Example:

CPU Sample 1:
1163 0 3305 8010434 612 0 731

CPU Sample 2:
1163 0 3306 8012839 612 0 732

The difference between the two samples represents CPU activity during the sampling interval.

10. Bash Arrays

The CPU values were converted into Bash arrays:

CPU1_VALUES=($CPU1)
CPU2_VALUES=($CPU2)

Individual values were accessed using indexes:

USER1=${CPU1_VALUES[0]}
SYSTEM1=${CPU1_VALUES[2]}
IDLE1=${CPU1_VALUES[3]}
IOWAIT1=${CPU1_VALUES[4]}

The same approach was used for the second CPU sample.

This helped in understanding how Bash arrays can be used to process command output.

11. CPU Usage Calculation

The difference between the two CPU samples is calculated:

USER_DIFF=$((USER2 - USER1))
SYSTEM_DIFF=$((SYSTEM2 - SYSTEM1))
IDLE_DIFF=$((IDLE2 - IDLE1))
IOWAIT_DIFF=$((IOWAIT2 - IOWAIT1))

Busy CPU time:

BUSY_DIFF=$((USER_DIFF + SYSTEM_DIFF))

Total CPU time:

TOTAL_DIFF=$((USER_DIFF + SYSTEM_DIFF + IDLE_DIFF + IOWAIT_DIFF))

CPU usage is calculated as:

CPU Usage = (Busy CPU Time / Total CPU Time) × 100

awk is used to display the result with decimal precision:

CPU_USAGE=$(awk "BEGIN {printf \"%.2f\", ($BUSY_DIFF / $TOTAL_DIFF) * 100}")

Example:

CPU Usage : 0.12%

The value changes depending on CPU activity during the sampling period.

12. Debugging and Error Handling

During CPU implementation, a division-by-zero error occurred:

division by zero attempted

The issue was traced to CPU values not being correctly stored in arrays.

The missing array initialization was identified:

CPU1_VALUES=($CPU1)
CPU2_VALUES=($CPU2)

Another issue was a variable-name typo during the calculation.

This debugging process helped verify each value step by step instead of treating the calculation as a black box.

A validation check was then added:

if [ "$TOTAL_DIFF" -eq 0 ]; then
    echo "ERROR: Unable to calculate CPU usage." >&2
    return 1
fi

This prevents an invalid division.

13. Defensive Bash Scripting

The CPU monitoring implementation uses:

set -euo pipefail

Purpose:

-e          Stop when a command fails
-u          Detect unset variables
-o pipefail Detect failures inside pipelines

This was added after the basic functionality was tested so that the script becomes more reliable.

14. Bash Functions

The CPU calculation was initially developed as a standalone script.

After the calculation was understood and tested, it was converted into a reusable function:

get_cpu_usage() {
    ...
}

The function performs:

Collect CPU Sample 1
        ↓
Wait 2 seconds
        ↓
Collect CPU Sample 2
        ↓
Calculate differences
        ↓
Calculate CPU usage
        ↓
Return CPU percentage

The result is returned using:

echo "$CPU_USAGE"

The calling script captures it using:

CPU_USAGE=$(get_cpu_usage)
15. Modular Project Structure

As the project grew, the CPU functionality was moved into a separate library.

The following directory was created:

lib/

The CPU library:

lib/cpu.sh

Current project structure:

system-health-monitor/
│
├── README.md
├── system-health-monitor.sh
└── lib/
    └── cpu.sh

The main script loads the CPU library using:

source ./lib/cpu.sh

The CPU function is then available to the main application:

CPU_USAGE=$(get_cpu_usage)

This separates:

Main Application
        ↓
Reusable Monitoring Logic

and allows additional monitoring modules to be added later.

16. Current Application

The current system-health-monitor.sh performs:

System Information
        +
CPU Monitoring

The application is executed using:

./system-health-monitor.sh

Example output:

========================================
         SYSTEM HEALTH MONITOR
========================================
Hostname          : DESKTOP-9UNIKTK
Current User      : laxman
Operating System  : Ubuntu 24.04.1 LTS
Kernel            : 6.18.33.2-microsoft-standard-WSL2
Uptime            : up 5 minutes
CPU Usage         : 0.12%
========================================
17. Current Project Architecture
system-health-monitor/
│
├── README.md
│
├── system-health-monitor.sh
│       │
│       ├── Hostname
│       ├── Current User
│       ├── Operating System
│       ├── Kernel
│       ├── Uptime
│       │
│       └── CPU Usage
│               │
│               └── lib/cpu.sh
│                       │
│                       └── get_cpu_usage()
│
└── lib/
    └── cpu.sh

The design will be extended as additional monitoring features are implemented.

18. Git Workflow

Git is being used throughout the development process.

For every feature, the following workflow is followed:

Check repository status
git status
Review changes
git diff
Stage changes
git add <file>
Review staged changes
git diff --cached
Check for whitespace errors
git diff --cached --check
Commit
git commit -m "Meaningful commit message"
Push to GitHub
git push
Verify clean working tree
git status

Expected:

nothing to commit, working tree clean

This workflow was followed for the CPU monitoring feature.

19. Development Journey So Far

The project has progressed through the following stages:

Linux / WSL2 Environment
        ↓
Project Directory
        ↓
Git Repository
        ↓
GitHub Repository
        ↓
System Information
        ↓
CPU Investigation using /proc/stat
        ↓
Manual CPU Sampling
        ↓
CPU Usage Calculation
        ↓
Debugging CPU Calculation
        ↓
Defensive Bash Scripting
        ↓
Bash Function
        ↓
Reusable CPU Library
        ↓
Integration with Main Application
        ↓
Git Commit
        ↓
GitHub Push

The important point is that each stage was first understood manually before being integrated into the application.

20. Completed Milestones
Milestone 1 — Project Setup
 Ubuntu/WSL2 environment verified
 Project directory created
 Git initialized
 Main branch configured
 GitHub repository created
 Git remote configured
 Initial project pushed to GitHub
Milestone 2 — System Information
 Hostname
 Current user
 Operating system
 Kernel version
 System uptime
Milestone 3 — CPU Monitoring
 /proc/stat investigated
 CPU samples collected
 Bash arrays used
 CPU differences calculated
 CPU utilization calculated
 Decimal percentage using awk
 Division-by-zero handling
 Defensive Bash settings
 CPU logic converted into a function
 CPU function moved to lib/cpu.sh
 CPU function integrated into main application
 Changes committed
 Changes pushed to GitHub
