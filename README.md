# history+

`history+` is a professional command-line utility that logs all executed commands and their outputs in real time.  
It is designed for **audit, debugging, and forensic analysis**.  

Unlike the default shell history, `history+` captures both the **command input** and **its output**, while excluding sensitive commands for security.

---
## Why Use history+?

- **Comprehensive Auditing:** Capture every command and its output for full traceability.
- **Debugging Made Easy:** Review exact command outputs to troubleshoot issues.
- **Forensic Analysis:** Maintain a tamper-resistant log for compliance and investigations.
- **Privacy Controls:** Exclude sensitive commands from logs to protect credentials and private data.

---

## Quick Start

```bash
# Start logging your shell session
history+ start

# Run your commands as usual...

# Stop logging when done
history+ stop

# Check current logging status
history+ status

# View the latest log entries in real time
history+ tail

# List all previous logging sessions
history+ list
```

---

## Sample Configuration

Create or edit `~/.history_plus/config` to customize which commands are excluded from output logging:

```text
passwd,ssh,mysql,sudo,ftp
```

You can add or remove commands (comma-separated) as needed.

---

## Support

- **Bugs or Feature Requests:** Open an issue on the repository.
- **Contributions:** Pull requests are welcome!
- **Questions:** Contact the maintainer via GitHub.

---
## Features

- Start and stop logging sessions with simple commands.
- Logs are stored with timestamps in `~/.history_plus/`.
- Excludes sensitive commands (like `passwd`, `ssh`, `mysql`) from output logging.
- Configurable exclusion list via `~/.history_plus/config`.
- Auto-stops when the terminal is closed (EXIT, INT, HUP traps).
- Self-aware: `history+` commands themselves are never logged.
- Built-in commands:
  - `history+ start` → Start logging session.
  - `history+ stop` → Stop current session.
  - `history+ status` → Show active session and log file path.
  - `history+ tail` → Live view of active log file.
  - `history+ list` → List all previous logging sessions.

---

## Installation

### Quick Installation

```bash
# Clone the repository
git clone https://github.com/vinothvbt/history+.git
cd history-plus

# Install for current user only (recommended)
./install.sh --user

# OR install system-wide (requires sudo)
sudo ./install.sh
```

### Manual Installation

1. Download or clone this repository
2. Make the script executable and copy to your PATH:

   ```bash
   chmod +x history+
   sudo cp history+ /usr/local/bin/
   ```

3. Create configuration directory:

   ```bash
   mkdir -p ~/.history_plus
   ```

4. (Optional) Add a config file to define excluded commands:

   ```bash
   cp config.example ~/.history_plus/config
   ```

---

## Usage

Start logging:
```bash
history+ start
```

Stop logging:
```bash
history+ stop
```

Check status:
```bash
history+ status
```

Live view:
```bash
history+ tail
```

List sessions:
```bash
history+ list
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

- Sensitive commands are excluded from output logging based on your config file.
- By default, the following are excluded: `passwd`, `ssh`, `mysql`, `sudo`, `ftp`.
- Update `~/.history_plus/config` to control exclusions.

---

## Development

Run tests:
```bash
make test
```

Install for development:
```bash
make install-user
```

Lint code:
```bash
make lint
```

---

## License

MIT License – free to use and modify.
