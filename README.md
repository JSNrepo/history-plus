# history+

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**history+** is a professional command-line utility for advanced shell command auditing. It logs every command and its output in real time, making it indispensable for audit, debugging, and forensic analysis. Unlike default shell history, history+ captures both command input and output, while excluding sensitive commands for security.

---

## Table of Contents

- [Features](#features)
- [Why Use history+?](#why-use-history)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Advanced Usage](#advanced-usage)
- [Example Log Entry](#example-log-entry)
- [Security Notes](#security-notes)
- [Development](#development)
- [Support & Contributing](#support--contributing)
- [License](#license)

---

## Features

**Core Features**
- Start/stop logging sessions with a single command.
- Logs every command and output with timestamps (`~/.history_plus/`).
- Excludes sensitive commands from output logging (configurable).
- Auto-stops on terminal exit.
- Self-aware: `history+` commands themselves are never logged.

**Professional Features**
- Log rotation (auto/manual).
- Log management: clean up old logs by age or size.
- Flexible export: JSON, CSV.
- Size monitoring and warnings.
- Powerful cleanup with confirmation prompts.

**Built-in Commands**
- `history+ start` / `history+ stop` / `history+ status`
- `history+ tail` / `history+ list` / `history+ rotate`
- `history+ cleanup [options]` / `history+ export [options] file`

---

## Why Use history+?

- **Comprehensive Auditing:** Full traceability of all shell activity.
- **Debugging Made Easy:** Review exact command outputs.
- **Forensic Analysis:** Tamper-resistant logs for compliance/investigations.
- **Privacy Controls:** Exclude sensitive commands to protect credentials.

---

## Installation

### Quick Install (Recommended)

```
git clone https://github.com/vinothvbt/history-plus.git
cd history-plus
chmod +x history+ install.sh test.sh
./install.sh --user       # For current user
# OR for system-wide
sudo ./install.sh
```

### Using Makefile

```
git clone https://github.com/vinothvbt/history-plus.git
cd history-plus
make install-user          # For current user
# OR
make install               # System-wide
```

### Manual Install

1. Clone/download repository.
2. Make the script executable and copy to your PATH:
    ```
    chmod +x history+
    sudo cp history+ /usr/local/bin/
    ```
3. Create configuration directory:
    ```
    mkdir -p ~/.history_plus
    ```
4. (Optional) Add a config file:
    ```
    cp config.example ~/.history_plus/config
    ```

---

## Quick Start

```
history+ start   # Start logging
# ...your commands...
history+ stop    # Stop logging
history+ status  # Check current logging status
history+ tail    # View latest log entries
history+ list    # List previous sessions
```

---

## Configuration

Customize command exclusions by editing `~/.history_plus/config`:

```
passwd,ssh,mysql,sudo,ftp
```

Add or remove commands as comma-separated values.

---

## Usage

- **Start Logging:** `history+ start`
- **Stop Logging:** `history+ stop`
- **Check Status:** `history+ status`
- **Live View:** `history+ tail`
- **List Sessions:** `history+ list`
- **Rotate Logs:** `history+ rotate`
- **Cleanup Old Logs:** `history+ cleanup --older-than 30d --dry-run`
- **Export:**  
    ```
history+ export --format json session.log
history+ export --format csv session.log output.csv
    ```

---

## Advanced Usage

- **Automated Log Management (via crontab):**
    ```
    0 2 * * * /usr/local/bin/history+ cleanup --older-than 30d
    ```
- **Size-based Cleanup:**
    ```
history+ cleanup --larger-than 100M --dry-run
    ```
- **Export for Scripting/Analysis:**
    ```
history+ export --format json session.log | jq '.session.entries[].command'
history+ export --format csv session.log
    ```

---

## Example Log Entry

```
[2025-08-16 19:32:01]
Command: ls -la
Output:
total 12
drwxr-xr-x  3 user user 4096 Aug 16 19:31 .
drwxr-xr-x 18 user user 4096 Aug 16 19:00 ..
-rw-r--r--  1 user user   23 Aug 16 19:31 file.txt
---
```

---

## Security Notes

- Sensitive commands are excluded from output logging, based on your config file.
- Default exclusions: `passwd`, `ssh`, `mysql`, `sudo`, `ftp`.
- Edit `~/.history_plus/config` to control exclusions.

---

## Development

- **Run Tests:** `make test`
- **Install for Dev:** `make install-user`
- **Lint:** `make lint`

---

## Support & Contributing

- **Bug Reports & Feature Requests:** [Open an issue](https://github.com/vinothvbt/history-plus/issues).
- **Contributions:** Pull requests are welcome!
- **Questions:** Contact the maintainer via GitHub.

---

## License

MIT License – free to use and modify.
