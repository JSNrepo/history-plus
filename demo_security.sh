#!/bin/bash

# Demo script to show History+ security features
# This demonstrates the different security levels for commands

echo "=== History+ Security Model Demo ==="
echo

echo "1. Commands that are NEVER logged (complete exclusion):"
echo "   - passwd (password changes)"
echo "   - su (user switching)" 
echo "   - login (authentication)"
echo "   - ssh-keygen (key generation)"
echo

echo "2. Commands that use SMART PASSWORD FILTERING (command + output logged, password prompts filtered):"
echo "   - sudo (privilege escalation - keeps scan results, filters password)"
echo "   - gpg (encryption operations)"
echo "   - openssl (SSL/TLS operations)"
echo

echo "3. Commands that are FULLY logged (command + output):"
echo "   - ls, cat, grep, etc. (normal commands)"
echo "   - Custom exclusions can be added to ~/.history_plus/config"
echo

echo "=== Key Benefit ==="
echo "✓ sudo nmap commands capture full scan results"
echo "✓ Password prompts are filtered out for security"
echo "✓ Critical auth commands are never logged"
echo

echo "Example log entries:"
echo

echo "[2025-08-16 15:30:01]"
echo "Command: sudo nmap -sS target.com"
echo "Output:"
echo "[PASSWORD PROMPT FILTERED]"
echo "Starting Nmap 7.80 ( https://nmap.org )"
echo "Nmap scan report for target.com (192.168.1.1)"
echo "Host is up (0.001s latency)."
echo "PORT     STATE SERVICE"
echo "22/tcp   open  ssh"
echo "80/tcp   open  http"
echo "443/tcp  open  https"
echo "---"
echo

echo "[2025-08-16 15:30:05]"
echo "Command: passwd"  
echo "Output: [EXCLUDED - SENSITIVE COMMAND]"
echo "---"
echo

echo "[2025-08-16 15:30:10]"
echo "Command: ls -la"
echo "Output:"
echo "total 24"
echo "drwxr-xr-x 2 user user 4096 Aug 16 15:30 ."
echo "drwxr-xr-x 3 user user 4096 Aug 16 15:30 .."
echo "-rw-r--r-- 1 user user  156 Aug 16 15:30 demo.txt"
echo "---"
echo

echo "=== Security Audit ==="
echo "Run 'history+ security' to check your configuration"
echo "Run 'history+ start' to begin logging with these protections"
