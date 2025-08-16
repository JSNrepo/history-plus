# Makefile for history+
# Simple automation for build, test, and installation tasks

.PHONY: all test install install-user uninstall clean help

# Default target
all: test

# Run tests
test:
	@echo "Running history+ test suite..."
	@./test.sh

# Install system-wide (requires sudo)
install:
	@echo "Installing history+ system-wide..."
	@sudo ./install.sh

# Install for current user only
install-user:
	@echo "Installing history+ for current user..."
	@./install.sh --user

# Uninstall system-wide
uninstall:
	@echo "Uninstalling history+ (system-wide)..."
	@sudo rm -f /usr/local/bin/history+
	@echo "Removed /usr/local/bin/history+"
	@echo "Note: User configuration in ~/.history_plus is preserved"

# Uninstall user installation
uninstall-user:
	@echo "Uninstalling history+ (user installation)..."
	@rm -f ~/.local/bin/history+
	@echo "Removed ~/.local/bin/history+"
	@echo "Note: User configuration in ~/.history_plus is preserved"

# Clean up generated files and configs (dangerous!)
clean:
	@echo "Cleaning up history+ files..."
	@echo "This will remove ALL logs and configuration!"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		rm -rf ~/.history_plus; \
		echo "Removed ~/.history_plus"; \
	else \
		echo "Cancelled."; \
	fi

# Run ShellCheck if available
lint:
	@if command -v shellcheck >/dev/null 2>&1; then \
		echo "Running ShellCheck..."; \
		shellcheck history+ install.sh test.sh; \
		echo "ShellCheck passed!"; \
	else \
		echo "ShellCheck not available. Install with: apt install shellcheck"; \
	fi

# Show available targets
help:
	@echo "Available targets:"
	@echo "  all           - Run tests (default)"
	@echo "  test          - Run test suite"
	@echo "  install       - Install system-wide (requires sudo)"
	@echo "  install-user  - Install for current user only"
	@echo "  uninstall     - Uninstall system-wide"
	@echo "  uninstall-user- Uninstall user installation"
	@echo "  clean         - Remove all config and logs (dangerous!)"
	@echo "  lint          - Run ShellCheck if available"
	@echo "  help          - Show this help"
