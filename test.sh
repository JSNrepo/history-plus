#!/bin/bash

# Test script for history+
# This script runs basic functionality tests

set -uo pipefail  # Removed -e to handle test failures gracefully

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

print_info() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1" >&2
}

# Test if script exists and is executable
test_script_exists() {
    print_info "Checking if history+ script exists and is executable"
    
    if [[ -f "history+" && -x "history+" ]]; then
        print_success "Script exists and is executable"
        return 0
    else
        print_error "Script not found or not executable"
        return 1
    fi
}

# Test help command
test_help_command() {
    print_info "Testing help command"
    
    if ./history+ help >/dev/null 2>&1; then
        print_success "Help command works"
        return 0
    else
        print_error "Help command failed"
        return 1
    fi
}

# Test status command (should show no active session)
test_status_command() {
    print_info "Testing status command"
    
    if ./history+ status >/dev/null 2>&1; then
        print_success "Status command works"
        return 0
    else
        print_error "Status command failed"
        return 1
    fi
}

# Test invalid command
test_invalid_command() {
    print_info "Testing invalid command handling"
    
    if ! ./history+ invalid_command >/dev/null 2>&1; then
        print_success "Invalid command properly rejected"
        return 0
    else
        print_error "Invalid command should have failed"
        return 1
    fi
}

# Test config file creation
test_config_creation() {
    print_info "Testing configuration directory existence"
    
    # Run status to ensure config creation
    ./history+ status >/dev/null 2>&1
    
    if [[ -d "$HOME/.history_plus" && -f "$HOME/.history_plus/config" ]]; then
        print_success "Configuration directory and config file exist"
        return 0
    else
        print_error "Configuration directory or config file missing"
        return 1
    fi
}

# Test list command
test_list_command() {
    print_info "Testing list command"
    
    # The list command should work even with no logs (returns exit code 1 but that's ok)
    if ./history+ list >/dev/null 2>&1 || [[ $? -eq 1 ]]; then
        print_success "List command works"
        return 0
    else
        print_error "List command failed unexpectedly"
        return 1
    fi
}

# Test security audit command
test_security_audit() {
    print_info "Testing security audit command"
    
    if ./history+ security >/dev/null 2>&1; then
        print_success "Security audit command works"
        return 0
    else
        print_error "Security audit command failed"
        return 1
    fi
}

# Test ShellCheck (if available)
test_shellcheck() {
    print_info "Running ShellCheck if available"
    
    if command -v shellcheck >/dev/null 2>&1; then
        if shellcheck history+; then
            print_success "ShellCheck passed"
            return 0
        else
            print_error "ShellCheck found issues"
            return 1
        fi
    else
        print_info "ShellCheck not available, skipping"
        return 0
    fi
}

# Run all tests
run_tests() {
    local total_tests=0
    local passed_tests=0
    
    echo "=== history+ Test Suite ==="
    echo
    
    # Array of test functions
    local tests=(
        "test_script_exists"
        "test_help_command" 
        "test_status_command"
        "test_invalid_command"
        "test_config_creation"
        "test_list_command"
        "test_security_audit"
        "test_shellcheck"
    )
    
    # Run each test
    for test in "${tests[@]}"; do
        ((total_tests++))
        echo
        if $test; then
            ((passed_tests++))
        fi || true  # Don't exit on test failure
    done
    
    echo
    echo "=== Test Results ==="
    echo "Passed: $passed_tests/$total_tests"
    
    if [[ $passed_tests -eq $total_tests ]]; then
        print_success "All tests passed!"
        return 0
    else
        print_error "Some tests failed"
        return 1
    fi
}

# Check if we're in the right directory
if [[ ! -f "history+" ]]; then
    print_error "Please run this script from the directory containing 'history+'"
    exit 1
fi

# Run tests
run_tests
