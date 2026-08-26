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

### Run Manually
To check your system health immediately, execute the master script:
```bash
./system-health-monitor.sh
```

### Automate Monitoring via Cron
To run this health monitor automatically every hour and record logs, add it to your user crontab.

1. Open your crontab editor:
   ```bash
   crontab -e
   ```
2. Paste the following configuration rule at the bottom of the file (ensure to use your absolute path):
   ```text
   0 * * * * /absolute/path/to/system-health-monitor/system-health-monitor.sh
   ```

---

## 📂 Directory Structure

```text
system-health-monitor/
├── lib/                      # Modular script components (CPU, Memory, Disk, etc.)
├── logs/                     # Historical system performance log files
├── README.md                 # Project documentation and specifications
└── system-health-monitor.sh  # Master execution engine entry point
```

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
