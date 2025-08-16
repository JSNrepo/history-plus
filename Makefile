# Makefile for history+
# Simple automation for build, test, and installation tasks

.PHONY: all test install install-user uninstall clean help permissions

# Default target
all: permissions test

# Fix file permissions (needed after git clone)
permissions:
	@echo "Setting executable permissions..."
	@chmod +x history+ install.sh test.sh
	@echo "Permissions set successfully"

# Run tests
test: permissions
	@echo "Running history+ test suite..."
	@./test.sh

# Install system-wide (requires sudo)
install: permissions
	@echo "Installing history+ system-wide..."
	@sudo ./install.sh

# Install for current user only
install-user: permissions
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
	@echo "  all           - Set permissions and run tests (default)"
	@echo "  permissions   - Fix file permissions after git clone"
	@echo "  test          - Run test suite"
	@echo "  install       - Install system-wide (requires sudo)"
	@echo "  install-user  - Install for current user only"
	@echo "  uninstall     - Uninstall system-wide"
	@echo "  uninstall-user- Uninstall user installation"
	@echo "  clean         - Remove all config and logs (dangerous!)"
	@echo "  lint          - Run ShellCheck if available"
	@echo "  demo          - Run a quick demo of features"
	@echo "  help          - Show this help"

# Quick demo of features
demo: permissions
	@echo "=== history+ Professional Features Demo ==="
	@echo "1. Testing help system..."
	@./history+ help | head -5
	@echo ""
	@echo "2. Testing export help..."
	@./history+ export --help | head -5
	@echo ""
	@echo "3. Testing cleanup help..."
	@./history+ cleanup --help | head -5
	@echo ""
	@echo "Demo completed! Use 'make install-user' to install."
