# history+

**history+** is a professional command-line utility for advanced auditing of shell commands. It logs every command and its output in real-time, making it indispensable for audits, debugging, and forensic analysis. Unlike default shell history, `history+` captures both command input and output, while using smart filtering to protect sensitive data.

---

## Table of Contents

- [Why Use history+?](#why-use-history)
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Usage](#usage)
- [Advanced Usage](#advanced-usage)
- [Example Log Entry](#example-log-entry)
- [Security Notes](#security-notes)
- [Development](#development)
- [License](#license)

---

## Why Use history+?

- **Full Auditing:** Capture every command and its output for comprehensive traceability.
- **Debugging:** Review exact outputs for easier troubleshooting.
- **Forensics:** Maintain tamper-resistant logs for compliance and investigations.
- **Privacy:** Exclude sensitive commands and outputs to protect credentials and private data.

---

## Features

### Core Features
- Start/stop logging sessions with simple commands.
- Timestamped logs saved in `~/.history_plus/`.
- Smart exclusion and filtering for sensitive commands (customizable).
- Handles shell exit cleanly (EXIT, INT, HUP traps).
- Self-aware: never logs its own commands.

### Professional Features
- **Log Rotation:** Automatic/manual, with size-based triggers.
- **Log Management:** Clean up old logs by age/size; supports `--dry-run`.
- **Export:** Convert logs to JSON/CSV for deeper analysis.
- **Size Monitoring:** Warnings if logs exceed configured thresholds.
- **Advanced Cleanup:** Filter and confirm deletions by age, size, etc.

### Built-in Commands
- `history+ start` / `stop` / `status` / `tail` / `list`
- `history+ rotate` / `cleanup [options]` / `export [options]`
- `history+ security` (security audit of your config)

---

## Installation

### Quick Installation

```bash
git clone https://github.com/vinothvbt/history-plus.git
cd history-plus
chmod +x history+ install.sh test.sh
./install.sh --user         # For current user only (recommended)
# OR
sudo ./install.sh           # For system-wide installation
```

### Using Makefile

```bash
git clone https://github.com/vinothvbt/history-plus.git
cd history-plus
make install-user           # For current user
# OR
make install                # System-wide
```

### Manual Installation

1. Download or clone this repository.
2. Make the script executable and copy to your PATH:
    ```bash
    chmod +x history+
    sudo cp history+ /usr/local/bin/
    ```
3. Create configuration directory:
    ```bash
    mkdir -p ~/.history_plus
    ```
4. (Optional) Add a config file:
    ```bash
    cp config.example ~/.history_plus/config
    ```

---

## Quick Start

```bash
history+ start        # Begin logging
# ...run your commands...
history+ stop         # End logging
history+ status       # Show logging status and log paths
history+ tail         # View latest entries live
history+ list         # List all previous sessions
```

---

## Configuration

Customize excluded commands by editing `~/.history_plus/config`:

```
passwd,ssh,mysql,sudo,ftp
```

Add or remove commands (comma-separated) as needed.

---

## Usage

- **Start Logging:** `history+ start`
- **Stop Logging:** `history+ stop`
- **Check Status:** `history+ status`
- **Live View:** `history+ tail`
- **List Sessions:** `history+ list`
- **Rotate Logs:** `history+ rotate`
- **Cleanup Old Logs:**  
  `history+ cleanup --older-than 30d --dry-run`
- **Export Logs:**  
  `history+ export --format json session.log`  
  `history+ export --format csv session.log output.csv`

---

## Advanced Usage

### Automated Log Management (with crontab)
```bash
0 2 * * * /usr/local/bin/history+ cleanup --older-than 30d
```

### Size-Based Cleanup
```bash
history+ cleanup --larger-than 100M --dry-run
```

### Export for Analysis
```bash
history+ export --format json session.log | jq '.session.entries[].command'
history+ export --format csv session.log
```

### Log Rotation Strategies
```bash
history+ rotate
history+ status    # Check current session size
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

- **Never Logged:** Certain commands (`passwd`, `su`, `login`, `ssh-keygen`) are never logged.
- **Smart Password Filtering:** Commands like `sudo`, `gpg`, `openssl` have password prompts filtered.
- **Configurable Exclusions:** Add to your exclusion list in `~/.history_plus/config`.
- **Password Detection:** Any command with password flags (`-p`, `--password`, etc.) is auto-excluded.
- **Secure Storage:** Config directory uses restrictive permissions (700).
- **Security Audit:** Run `history+ security` to check your setup.

**Example:**  
A `sudo nmap` scan logs the command and results but filters out the sudo password prompt.

```
[2025-08-16 15:30:01]
Command: sudo nmap -sS target.com
Output:
[PASSWORD PROMPT FILTERED]
Starting Nmap 7.80 ( https://nmap.org )
...
---
```

---

## Development

- **Run tests:** `make test`
- **Install for dev:** `make install-user`
- **Lint:** `make lint`

---

## License

MIT License – free to use and modify.
