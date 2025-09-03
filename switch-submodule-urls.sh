#!/bin/bash

# Script to switch between BitBucket and GitHub URLs for Git submodules
# Usage: ./switch-submodule-urls.sh [bitbucket|github]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BITBUCKET_CONFIG="$SCRIPT_DIR/.gitmodules.bitbucket"
GITHUB_CONFIG="$SCRIPT_DIR/.gitmodules.github"
CURRENT_CONFIG="$SCRIPT_DIR/.gitmodules"

show_usage() {
    echo "Usage: $0 [bitbucket|github|status]"
    echo ""
    echo "Commands:"
    echo "  bitbucket  - Switch all submodules to use BitBucket URLs"
    echo "  github     - Switch all submodules to use GitHub URLs"
    echo "  status     - Show current submodule URL configuration"
    echo ""
    echo "Examples:"
    echo "  $0 bitbucket   # Switch to BitBucket"
    echo "  $0 github      # Switch to GitHub"
    echo "  $0 status      # Show current URLs"
}

show_status() {
    echo "Current submodule URL configuration:"
    echo "===================================="
    
    if [[ -f "$CURRENT_CONFIG" ]]; then
        # Check if we're currently using BitBucket or GitHub URLs
        if grep -q "bitbucket.org" "$CURRENT_CONFIG"; then
            echo "✓ Currently configured for: BitBucket"
        elif grep -q "github.com" "$CURRENT_CONFIG"; then
            echo "✓ Currently configured for: GitHub (RefXyDea organization)"
        else
            echo "? Mixed or unknown configuration detected"
        fi
        
        echo ""
        echo "Sample URLs:"
        head -6 "$CURRENT_CONFIG" | grep -E "(path|url)" | head -4
    else
        echo "❌ No .gitmodules file found"
        return 1
    fi
}

switch_to_bitbucket() {
    echo "Switching submodules to BitBucket URLs..."
    
    if [[ ! -f "$BITBUCKET_CONFIG" ]]; then
        echo "❌ BitBucket configuration file not found: $BITBUCKET_CONFIG"
        return 1
    fi
    
    # Backup current .gitmodules if it exists
    if [[ -f "$CURRENT_CONFIG" ]]; then
        cp "$CURRENT_CONFIG" "$CURRENT_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✓ Backed up current .gitmodules"
    fi
    
    # Copy BitBucket configuration
    cp "$BITBUCKET_CONFIG" "$CURRENT_CONFIG"
    echo "✓ Switched to BitBucket URLs"
    
    # Sync the submodule URLs
    git submodule sync --recursive
    echo "✓ Synced submodule URLs with Git"
    
    echo ""
    echo "All submodules are now configured to use BitBucket URLs"
    echo "You may need to run 'git submodule update --init --recursive' to update existing submodules"
}

switch_to_github() {
    echo "Switching submodules to GitHub URLs..."
    
    if [[ ! -f "$GITHUB_CONFIG" ]]; then
        echo "❌ GitHub configuration file not found: $GITHUB_CONFIG"
        return 1
    fi
    
    # Backup current .gitmodules if it exists
    if [[ -f "$CURRENT_CONFIG" ]]; then
        cp "$CURRENT_CONFIG" "$CURRENT_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
        echo "✓ Backed up current .gitmodules"
    fi
    
    # Copy GitHub configuration
    cp "$GITHUB_CONFIG" "$CURRENT_CONFIG"
    echo "✓ Switched to GitHub URLs (RefXyDea organization)"
    
    # Sync the submodule URLs
    git submodule sync --recursive
    echo "✓ Synced submodule URLs with Git"
    
    echo ""
    echo "All submodules are now configured to use GitHub URLs"
    echo "You may need to run 'git submodule update --init --recursive' to update existing submodules"
}

update_submodules() {
    echo ""
    read -p "Would you like to update all submodules now? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Updating submodules..."
        git submodule update --init --recursive --remote
        echo "✓ Submodules updated"
    else
        echo "Skipped submodule update. Run 'git submodule update --init --recursive' when ready."
    fi
}

# Main script logic
case "$1" in
    "bitbucket")
        switch_to_bitbucket
        update_submodules
        ;;
    "github")
        switch_to_github
        update_submodules
        ;;
    "status")
        show_status
        ;;
    *)
        show_usage
        exit 1
        ;;
esac

echo ""
echo "Done!"