# 🖥️ Linux System Health Monitor

A lightweight, modular Bash-based shell utility developed to collect, monitor, and report key Linux system health metrics. Built as part of a DevOps engineering workflow, this utility interacts natively with the Linux kernel via the `/proc` filesystem and core system utilities.

The application is built incrementally—initially verifying manual Linux administrative commands before scripting, testing, and modularizing them.

---

## 📌 Project Architecture & Progress

The monitor tracks system components individually using modular scripts located in the `lib/` directory.

| Monitoring Module | Status | Core Tool / Source |
| :--- | :---: | :--- |
| **System Information** | ✅ Completed | `/proc/version`, `hostnamectl` |
| **CPU Monitoring** | ✅ Completed | `/proc/stat`, `top` |
| **Memory Monitoring** | ✅ Completed | `/proc/meminfo`, `free` |
| **Disk Monitoring** | ✅ Completed | `df -h` |
| **Process Monitoring** | ✅ Completed | `ps aux` |
| **Filesystem Monitoring**| ✅ Completed | `stat`, `find` |
| **Health Thresholds** | ✅ Completed | Conditional Bash logic |
| **Logging Engine** | ✅ Completed | Written safely to `logs/` directory |
| **Cron Scheduling** | ✅ Completed | `crontab` automated routines |
| **Alerting System** | ⏳ Planned | Email notifications / Slack Webhooks |
| **Docker Integration** | ⏳ Planned | Container resource tracking |
| **Jenkins CI/CD** | ⏳ Planned | Automated deployment pipeline |

---

## 🧰 Tech Stack & Tools

- **Operating System:** Ubuntu 24.04 LTS (via WSL2)
- **Scripting Language:** GNU Bash
- **Data Parsers:** `awk`, `grep`, `cut`, `sed`
- **Core Interface:** Linux `/proc` pseudo-filesystem
- **Version Control:** Git & GitHub

---

## 🛠️ Installation & Setup

Follow these steps to clone, configure, and execute the health monitor on your local Linux environment.

### 1. Prerequisites
Ensure you are running a Linux distribution (such as Ubuntu) with standard shell utilities installed.

### 2. Clone the Repository
```bash
git clone https://github.com/laxman548/system-health-monitor.git
cd system-health-monitor
```

### 3. Adjust Permissions
Make the main entry script and all auxiliary library files executable:
```bash
chmod +x system-health-monitor.sh
chmod +x lib/*.sh
```

---

## 💻 Usage

### Run the System Health Monitor
From the project directory, run the master script manually:
```bash
./system-health-monitor.sh
```

**Example output:**
```text
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
```

### View the Health Log
Every execution appends metrics directly into the persistent log subsystem.

- **Display the complete log:**
  ```bash
  cat logs/system-health.log
  ```
- **View only the latest five entries:**
  ```bash
  tail -n 5 logs/system-health.log
  ```
- **Follow the log stream in real time:**
  ```bash
  tail -f logs/system-health.log
  ```

**Example log entry format:**
```text
2026-08-26 12:45:05 | CPU=0.08% | MEMORY=6.51% | DISK=1% | FILESYSTEM=WARNING | OVERALL=WARNING
```

### Automate Monitoring via Cron
To run this health monitor automatically every hour and record logs, add it to your user crontab.

1. Open your crontab editor:
   ```bash
   crontab -e
   ```
2. Paste the following configuration rule at the bottom of the file (ensure to use your absolute path):
   ```text
   0 * * * * cd /absolute/path/to/system-health-monitor && ./system-health-monitor.sh
   ```

---

## 🩺 Health Status Rules

The monitoring engine evaluates resources across three severity layers: `OK`, `WARNING`, and `CRITICAL`.

### 📊 Resource Evaluation Metrics

#### 🚀 CPU, Memory, and Disk
- **Below 70%** → `OK`
- **70% - 89.99%** → `WARNING`
- **90% and above** → `CRITICAL`

#### 💾 Filesystem Capacity
- **Below 80%** → `OK`
- **80% - 89.99%** → `WARNING`
- **90% and above** → `CRITICAL`

### 🛡️ Overall Health Evaluation
Overall health dynamically cascades based on the highest resource severity detected across components (`CRITICAL` > `WARNING` > `OK`):

```text
  CPU Usage    → OK
  Memory Usage → OK
  Disk Capacity→ OK
  Filesystem   → WARNING
                 ↓
  OVERALL STATUS = WARNING
```
*Note: If even a single monitored component changes state to `CRITICAL`, the system overall health state escalates to `CRITICAL` immediately.*

---

## 📂 Directory Structure

```text
system-health-monitor/
├── lib/                      # Modular script components (CPU, Memory, Disk, etc.)
├── logs/                     # Historical system performance log files
│   └── system-health.log     # Target file for streaming log entries
├── README.md                 # Project documentation and specifications
└── system-health-monitor.sh  # Master execution engine entry point
```

---

## 🚀 Future Enhancements

The following operational milestones are in active development planning:
- 🚨 **Alerting System** — Send automated notifications (e.g., Slack Webhooks or Email) when system statuses cross into `WARNING` or `CRITICAL` levels.
- 🐳 **Docker Integration** — Track isolated container execution metrics along with host-level container resource usage.
- 🔄 **Jenkins CI/CD** — Enforce validation linting checks and test automation suites through configured declarative pipelines.
- 📊 **Enhanced Monitoring** — Scale up internal collection capabilities to include tracking network socket limits and open file descriptors.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
