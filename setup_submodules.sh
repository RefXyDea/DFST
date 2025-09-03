#!/bin/bash

# List of all child repositories to convert to submodules
repos=(
    "fst-qa-automation"
    "fst-admin-server"
    "fst_scheduler_service"
    "fst_location"
    "vig_package"
    "fst_alarm"
    "fst_user-service"
    "fst-erp-codebase"
    "config-repo"
    "fst-scheduler"
    "fst_help"
    "dewatering_ui"
    "fst_eureka"
    "iridiumservicemanagement"
    "fst-metadata"
    "fst_config"
    "fst_audit"
    "vig_rest"
    "vig_iridium"
    "fst-common-utils"
    "fst-lpsg-application"
    "fst_common_entities_util"
    "fst-erp-csv-processing"
    "fst_observation_service"
    "fst_device_management_service"
    "vig_updater"
    "fst-docker"
    "test_fst_translation_service"
    "fst_datamon"
    "test_clone"
    "fst_report_service"
    "fst_erp_device"
    "fst_web_ui"
    "sitesfromexstcust"
    "fst_notification_service"
    "fst-parent-pom"
    "fst_remote_control"
    "fst-s3-file-uploader"
    "helm-fst-values"
    "fst-cloud-gateway-service"
    "vig_tcp"
    "fst-qa"
    "fst-config-repo-k8"
    "helm-fst-app"
    "vig_orbcomm"
    "fst-eks-configmap"
)

# Base URL pattern for Bitbucket
base_url="git@bitbucket.org:xyleminc"

echo "Setting up Git submodules for DFST project..."

for repo in "${repos[@]}"; do
    if [ -d "$repo" ]; then
        echo "Processing $repo..."
        
        # Get the current remote URL to verify it exists
        remote_url=$(cd "$repo" && git remote get-url origin 2>/dev/null || echo "")
        
        if [ -n "$remote_url" ]; then
            echo "  Found remote: $remote_url"
            
            # Backup the directory
            mv "$repo" "${repo}.bak"
            
            # Add as submodule
            git submodule add "$remote_url" "$repo"
            
            if [ $? -eq 0 ]; then
                echo "  ✓ Added $repo as submodule"
                rm -rf "${repo}.bak"
            else
                echo "  ✗ Failed to add $repo as submodule, restoring backup"
                rm -rf "$repo"
                mv "${repo}.bak" "$repo"
            fi
        else
            echo "  ⚠ No remote URL found for $repo, skipping"
        fi
    else
        echo "  ⚠ Directory $repo not found, skipping"
    fi
done

echo "Submodule setup complete!"
echo "To clone this repository with all submodules in the future, use:"
echo "  git clone --recurse-submodules <repository-url>"
echo "Or after cloning:"
echo "  git submodule update --init --recursive"