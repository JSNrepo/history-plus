# History+ Security Guide

## Overview

History+ implements a sophisticated three-tier security approach to protect sensitive information while maintaining audit capabilities. This document outlines the security features and best practices.

## Security Features

### 1. Three-Tier Security Model

**Tier 1: Never Logged (Complete Exclusion)**
- `passwd` - Password changes
- `su` - User switching
- `login` - Authentication
- `ssh-keygen` - SSH key generation

**Tier 2: Smart Password Filtering (Command + Output Logged, Password Prompts Filtered)**
- `sudo` - Privilege escalation (logs command + results, filters password prompts)
- `gpg` - GPG operations
- `openssl` - SSL/TLS operations

### 2. Key Benefits

✅ **Full Audit Capability**: `sudo nmap` logs both command AND scan results
✅ **Smart Password Protection**: Password prompts filtered, useful output preserved  
✅ **Critical Command Protection**: Authentication commands never logged
✅ **Flexible Configuration**: User-configurable additional exclusions

### 3. Real-World Example: sudo nmap

**Command**: `sudo nmap -sS target.com`

**What gets logged**:
```
[2025-08-16 15:30:01]
Command: sudo nmap -sS target.com
Output:
[PASSWORD PROMPT FILTERED]
Starting Nmap 7.80 ( https://nmap.org )
Nmap scan report for target.com (192.168.1.1)
Host is up (0.001s latency).
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
443/tcp  open  https
---
```

**Security Features**:
- ✅ Command fully audited
- ✅ Scan results preserved
- ❌ Password prompt filtered out
- ✅ Compliance maintained

### 3. Automatic Password Detection

Commands containing password-related flags are automatically excluded:
- `-p`, `--password`
- `--pass`, `--pwd`
- `--secret`, `--token`
- `--key`, `--auth`

### 4. Secure File Permissions

- Configuration directory: `~/.history_plus/` (700 permissions)
- Log files: Readable only by owner
- PID files: Restricted access

## Security Audit

Run regular security audits to check your configuration:

```bash
history+ security
```

This command checks:
- Configuration file security
- Directory permissions
- Hardcoded protection status
- Recommendations for improvement

## Best Practices

### 1. Regular Log Cleanup

Clean old logs periodically:

```bash
# Remove logs older than 30 days
history+ cleanup --older-than 30d

# Remove logs larger than 100MB
history+ cleanup --larger-than 100MB
```

### 2. Review Log Contents

Periodically review logs for sensitive information:

```bash
# List recent sessions
history+ list --recent 10

# Export logs for analysis
history+ export --format json --output audit.json
```

### 3. Monitor Configuration

- Check `~/.history_plus/config` regularly
- Ensure no critical commands are accidentally enabled
- Run `history+ security` after configuration changes

### 4. Sensitive Environments

For highly sensitive environments, consider:

- Log encryption using filesystem-level encryption
- Network isolation for log storage
- Regular security audits
- Automated log rotation and cleanup

## Incident Response

If sensitive data is accidentally logged:

1. **Stop logging immediately**:
   ```bash
   history+ stop
   ```

2. **Identify affected files**:
   ```bash
   history+ list
   ```

3. **Securely delete logs**:
   ```bash
   # Remove specific session
   rm ~/.history_plus/logs/session_YYYYMMDD_HHMMSS.log
   
   # Or clean all logs
   history+ cleanup --all
   ```

4. **Review configuration**:
   ```bash
   history+ security
   ```

5. **Update exclusions** if needed in `~/.history_plus/config`

## Threat Model

History+ protects against:

- **Accidental password logging** - Critical commands hardcoded exclusions
- **Configuration errors** - Security audit warnings
- **Unauthorized access** - Restricted file permissions
- **Data exposure** - Configurable sensitive command exclusions

History+ does **not** protect against:

- **Root access attacks** - Root can access all files
- **Memory dumps** - Commands in memory before filtering
- **Network interception** - Remote logging transmission
- **Physical access** - Direct disk access

## Compliance Considerations

When using History+ in regulated environments:

- **Data retention**: Configure appropriate cleanup policies
- **Access controls**: Ensure proper user permissions
- **Audit trails**: Use export features for compliance reporting
- **Encryption**: Consider filesystem-level encryption for logs

## Reporting Security Issues

If you discover a security vulnerability in History+:

1. **Do not** open a public issue
2. Document the issue with reproduction steps
3. Contact the maintainers privately
4. Allow time for assessment and patching

## Security Updates

- Keep History+ updated to the latest version
- Review security notifications
- Test updates in non-production environments first
- Monitor the project repository for security advisories

---

**Remember**: Security is a shared responsibility. While History+ provides robust protections, users must follow security best practices and maintain their systems appropriately.
