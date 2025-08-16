#!/bin/bash

# Installation script for history+
# Usage: ./install.sh [--user]

set -euo pipefail

readonly SCRIPT_NAME="history+"
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if running as root when installing system-wide
check_permissions() {
    local install_dir="$1"
    
    if [[ "$install_dir" == "/usr/local/bin" ]] && [[ $EUID -ne 0 ]]; then
        print_error "System-wide installation requires root privileges"
        echo "Run: sudo ./install.sh"
        echo "Or use: ./install.sh --user (for user-only installation)"
        exit 1
    fi
}

# Install history+ script
install_script() {
    local install_dir="$1"
    local script_path="$install_dir/$SCRIPT_NAME"
    
    print_info "Installing $SCRIPT_NAME to $install_dir"
    
    # Create directory if it doesn't exist
    mkdir -p "$install_dir"
    
    # Copy script
    cp "$SCRIPT_NAME" "$script_path"
    chmod +x "$script_path"
    
    print_success "Installed $SCRIPT_NAME to $script_path"
}

# Setup configuration
setup_config() {
    local config_dir="$HOME/.history_plus"
    
    print_info "Setting up configuration directory"
    
    # Create config directory
    mkdir -p "$config_dir"
    chmod 700 "$config_dir"
    
    # Copy example config if user doesn't have one
    if [[ ! -f "$config_dir/config" ]] && [[ -f "config.example" ]]; then
        cp config.example "$config_dir/config"
        print_info "Created default config file: $config_dir/config"
    fi
    
    print_success "Configuration directory ready: $config_dir"
}

# Add to PATH if needed (for user installation)
update_path() {
    local install_dir="$1"
    local shell_rc=""
    
    # Determine shell RC file
    case "$SHELL" in
        */bash)
            shell_rc="$HOME/.bashrc"
            ;;
        */zsh)
            shell_rc="$HOME/.zshrc"
            ;;
        */fish)
            shell_rc="$HOME/.config/fish/config.fish"
            ;;
        *)
            print_warning "Unknown shell: $SHELL"
            print_info "Manually add $install_dir to your PATH"
            return
            ;;
    esac
    
    # Check if directory is already in PATH
    if [[ ":$PATH:" == *":$install_dir:"* ]]; then
        print_info "$install_dir is already in PATH"
        return
    fi
    
    # Add to PATH in shell RC file
    if [[ -f "$shell_rc" ]]; then
        if ! grep -q "$install_dir" "$shell_rc"; then
            echo "" >> "$shell_rc"
            echo "# Added by history+ installer" >> "$shell_rc"
            echo "export PATH=\"\$PATH:$install_dir\"" >> "$shell_rc"
            print_success "Added $install_dir to PATH in $shell_rc"
            print_warning "Restart your shell or run: source $shell_rc"
        else
            print_info "PATH already configured in $shell_rc"
        fi
    else
        print_warning "Shell RC file not found: $shell_rc"
        print_info "Manually add this to your shell configuration:"
        echo "export PATH=\"\$PATH:$install_dir\""
    fi
}

# Verify installation
verify_installation() {
    local install_dir="$1"
    local script_path="$install_dir/$SCRIPT_NAME"
    
    print_info "Verifying installation"
    
    if [[ -x "$script_path" ]]; then
        print_success "Installation verified: $script_path"
        
        # Test the script
        if "$script_path" help >/dev/null 2>&1; then
            print_success "Script is working correctly"
        else
            print_warning "Script may have issues (check permissions)"
        fi
    else
        print_error "Installation failed: $script_path not found or not executable"
        exit 1
    fi
}

# Show post-installation instructions
show_instructions() {
    cat << EOF

${GREEN}history+ has been successfully installed!${NC}

Quick start:
  1. Start logging: ${BLUE}history+ start${NC}
  2. Run your commands normally
  3. Stop logging: ${BLUE}history+ stop${NC}
  4. Check status: ${BLUE}history+ status${NC}
  5. View logs: ${BLUE}history+ tail${NC}

Configuration:
  • Config file: ~/.history_plus/config
  • Logs directory: ~/.history_plus/logs/
  • Customize excluded commands by editing the config file

For help: ${BLUE}history+ help${NC}

EOF
}

# Main installation function
main() {
    local install_dir
    local user_install=false
    
    # Parse arguments
    case "${1:-}" in
        --user|-u)
            user_install=true
            install_dir="$HOME/.local/bin"
            ;;
        --help|-h)
            cat << EOF
Usage: $0 [OPTIONS]

Options:
  --user, -u    Install for current user only (to ~/.local/bin)
  --help, -h    Show this help message

Default: Install system-wide to /usr/local/bin (requires sudo)

Examples:
  sudo $0           # System-wide installation
  $0 --user         # User-only installation
EOF
            exit 0
            ;;
        "")
            install_dir="/usr/local/bin"
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
    
    # Check if script exists
    if [[ ! -f "$SCRIPT_NAME" ]]; then
        print_error "Script file '$SCRIPT_NAME' not found in current directory"
        exit 1
    fi
    
    print_info "Installing history+ $(if $user_install; then echo "(user-only)"; else echo "(system-wide)"; fi)"
    
    # Check permissions
    check_permissions "$install_dir"
    
    # Install script
    install_script "$install_dir"
    
    # Setup configuration
    setup_config
    
    # Update PATH if needed (user installation)
    if $user_install; then
        update_path "$install_dir"
    fi
    
    # Verify installation
    verify_installation "$install_dir"
    
    # Show instructions
    show_instructions
}

# Check if we're in the right directory
if [[ ! -f "history+" ]]; then
    print_error "Please run this script from the directory containing 'history+'"
    exit 1
fi

# Run main function
main "$@"
