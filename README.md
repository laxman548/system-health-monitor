🖥️ Linux System Health Monitor

A lightweight, modular Bash-based shell utility developed to collect, monitor, evaluate, and report key Linux system health metrics. Built as part of a DevOps engineering workflow, this utility uses native Linux system utilities and interfaces to provide real-time system health information.

The application is built incrementally by first verifying Linux administrative commands manually, then scripting, testing, modularizing, and integrating them into a single monitoring workflow.

📌 Project Architecture & Progress

The monitor tracks system components individually using modular scripts located in the lib/ directory.

Monitoring Module	Status	Core Tool / Source
System Information	✅ Completed	hostname, whoami, /etc/os-release, uname, uptime
CPU Monitoring	✅ Completed	/proc/stat, awk
Memory Monitoring	✅ Completed	/proc/meminfo, awk
Disk Monitoring	✅ Completed	df -h
Process Monitoring	✅ Completed	ps aux
Filesystem Monitoring	✅ Completed	df -h, grep, awk
Health Thresholds	✅ Completed	Conditional Bash logic and awk
Logging Engine	✅ Completed	logs/system-health.log
Cron Scheduling	✅ Completed	crontab
Alerting System	⏳ Planned	Email notifications / Slack Webhooks
Docker Integration	⏳ Planned	Container resource tracking
Jenkins CI/CD	⏳ Planned	Automated deployment pipeline
✨ Features
🖥️ System Information — Displays hostname, user, operating system, kernel, and uptime.
⚙️ CPU Monitoring — Tracks CPU usage and evaluates its health status.
🧠 Memory Monitoring — Tracks memory usage and evaluates thresholds.
💾 Disk Monitoring — Tracks disk usage.
🔄 Process Monitoring — Displays process count and top CPU and memory-consuming processes.
📁 Filesystem Monitoring — Monitors mounted Windows filesystems such as C: and D: under WSL2.
🩺 Health Thresholds — Classifies metrics as OK, WARNING, or CRITICAL.
📊 Overall Health — Combines individual component statuses into one system-wide health status.
📝 Logging — Records timestamped monitoring results in logs/system-health.log.
⏰ Cron Scheduling — Supports automated periodic execution through cron.
🧩 Modular Architecture — Separates monitoring responsibilities into reusable Bash modules.
🧰 Tech Stack & Tools
Operating System: Ubuntu 24.04 LTS via WSL2
Scripting Language: GNU Bash
Data Processing: awk, grep, sed, cut
System Utilities: df, ps, hostname, whoami, uname, uptime
System Interface: Linux /proc filesystem where applicable
Scheduling: Cron / crontab
Version Control: Git
Repository Hosting: GitHub
🛠️ Installation & Setup

Follow these steps to clone, configure, and run the health monitor on a Linux environment.

1. Prerequisites

Ensure the following tools are available:

Ubuntu 20.04+ or another Linux distribution
Bash 4.0+
Git 2.0+
awk
grep
sed
cut
df
ps
Cron for scheduled monitoring

For WSL2-based Windows filesystem monitoring:

Windows Subsystem for Linux 2
Ubuntu running under WSL2

Check the installed versions:

bash --version
git --version
awk --version
2. Clone the Repository
git clone https://github.com/laxman548/system-health-monitor.git
cd system-health-monitor
3. Adjust Permissions

Make the main script executable:

chmod +x system-health-monitor.sh

Make the library scripts executable:

chmod +x lib/*.sh
4. Create the Log Directory
mkdir -p logs
5. Verify the Project Structure
ls -la

Expected structure:

system-health-monitor/
├── lib/
│   ├── cpu.sh
│   ├── disk.sh
│   ├── filesystem.sh
│   ├── health.sh
│   ├── memory.sh
│   └── process.sh
├── logs/
│   └── system-health.log
├── README.md
└── system-health-monitor.sh
6. Environment Variables

The project does not currently require environment variables, API keys, or external credentials.

💻 Usage
Run the System Health Monitor

From the project directory:

./system-health-monitor.sh

Example output:

========================================
         SYSTEM HEALTH MONITOR
========================================
HOSTNAME          : DESKTOP-9UNIKTK
CURRENT USER      : laxman
OPERATING SYSTEM  : Ubuntu 24.04.1 LTS
KERNEL            : 6.18.33.2-microsoft-standard-WSL2
UPTIME            : up 1 hour, 37 minutes
CPU USAGE         : 0.04% [OK]
MEMORY USAGE      : 6.59% [OK]
DISK USAGE        : 1% [OK]
FILESYSTEM HEALTH : WARNING
OVERALL HEALTH    : WARNING
PROCESS COUNT     : 28
TOP CPU PROCESS   : root 98 0.0 /usr/lib/systemd/systemd-udevd
TOP MEMORY PROCESS: root 210 0.2 /usr/bin/python3
FILESYSTEM MONITOR
Filesystem: C:\
Usage: 81%
Mount: /mnt/c
Status: WARNING
----------------
Filesystem: D:\
Usage: 12%
Mount: /mnt/d
Status: OK
----------------
========================================
View the Health Log

Display the complete log:

cat logs/system-health.log

View only the latest five entries:

tail -n 5 logs/system-health.log

Follow the log in real time:

tail -f logs/system-health.log

Example log entry:

2026-08-26 12:45:05 | CPU=0.08% | MEMORY=6.51% | DISK=1% | FILESYSTEM=WARNING | OVERALL=WARNING
🩺 Health Status Rules

The monitor uses three health levels:

OK
WARNING
CRITICAL
CPU, Memory, and Disk
Below 70%      → OK
70% - 89.99%   → WARNING
90% and above  → CRITICAL
Filesystem
Below 80%      → OK
80% - 89.99%   → WARNING
90% and above  → CRITICAL
Overall Health

The overall health follows the highest severity:

CRITICAL > WARNING > OK

For example:

CPU        → OK
Memory     → OK
Disk       → OK
Filesystem → WARNING
                 ↓
Overall    → WARNING

If any component becomes CRITICAL, the overall health becomes CRITICAL.

⏰ Automate Monitoring via Cron

The monitor can run automatically using cron.

1. Open the crontab editor
crontab -e
2. Run the monitor every hour

Add the following entry:

0 * * * * /absolute/path/to/system-health-monitor/system-health-monitor.sh

Replace /absolute/path/to/ with the actual location of the project.

For example:

0 * * * * /home/laxman/projects/system-health-monitor/system-health-monitor.sh
3. Verify the Cron Job
crontab -l

Cron will execute the monitor automatically according to the configured schedule, while the script continues to append monitoring results to:

logs/system-health.log
📂 Directory Structure
system-health-monitor/
├── lib/
│   ├── cpu.sh                 # CPU monitoring
│   ├── disk.sh                # Disk monitoring
│   ├── filesystem.sh          # Filesystem monitoring
│   ├── health.sh              # Health threshold evaluation
│   ├── memory.sh              # Memory monitoring
│   └── process.sh             # Process monitoring
├── logs/
│   └── system-health.log      # Historical monitoring logs
├── README.md                  # Project documentation
└── system-health-monitor.sh   # Main monitoring entry point
Module Responsibilities
cpu.sh
    → CPU usage monitoring

memory.sh
    → Memory usage monitoring

disk.sh
    → Disk usage monitoring

process.sh
    → Process count and top processes

filesystem.sh
    → Filesystem monitoring and filesystem health

health.sh
    → Individual and overall health evaluation

system-health-monitor.sh
    → Main monitoring workflow
🚀 Future Enhancements

The following features are planned:

🚨 Alerting System — Send notifications when the system reaches WARNING or CRITICAL status.
🐳 Docker Integration — Monitor Docker containers and container resource usage.
🔄 Jenkins CI/CD — Automate testing and deployment through a Jenkins pipeline.
📊 Enhanced Monitoring — Expand metrics and reporting capabilities.
📄 License

This project is open-source and available under the MIT License.
