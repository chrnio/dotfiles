#!/usr/bin/env bash

# GNOME Workspace Keyboard Setup
# Minimum: 3 workspaces
# Maximum: 10 workspaces

echo "GNOME Workspace Setup"
echo "---------------------"

read -rp "How many workspaces do you want? (3-10): " NUM_WORKSPACES

# Validate input
if ! [[ "$NUM_WORKSPACES" =~ ^[0-9]+$ ]]; then
    echo
    echo "Invalid input. Please enter a number between 3 and 10."
    exit 1
fi

# Enforce minimum
if (( NUM_WORKSPACES < 3 )); then
    echo
    echo "Nothing was changed."
    echo "Please use 3 or greater."
    exit 0
fi

# Enforce maximum
if (( NUM_WORKSPACES > 10 )); then
    echo
    echo "Nothing was changed."
    echo "The maximum is 10 workspaces. Please use a number between 3 and 10."
    exit 0
fi

echo
echo "Configuring $NUM_WORKSPACES workspaces..."

# Disable dynamic workspaces
gsettings set org.gnome.mutter dynamic-workspaces false

# Set number of workspaces
gsettings set org.gnome.desktop.wm.preferences num-workspaces "$NUM_WORKSPACES"

# Clear all workspace switch/move bindings for workspaces 1-10
for i in {1..10}; do
    gsettings set org.gnome.desktop.wm.keybindings \
        "switch-to-workspace-$i" "[]"

    gsettings set org.gnome.desktop.wm.keybindings \
        "move-to-workspace-$i" "[]"
done

# ALWAYS disable GNOME Shell application shortcuts.
# This prevents Super+1 through Super+9 from opening pinned apps.
for i in {1..9}; do
    gsettings set org.gnome.shell.keybindings \
        "switch-to-application-$i" "[]"
done

# Configure Super+1 through Super+9
for ((i=1; i<=NUM_WORKSPACES && i<=9; i++)); do
    gsettings set org.gnome.desktop.wm.keybindings \
        "switch-to-workspace-$i" "['<Super>$i']"

    gsettings set org.gnome.desktop.wm.keybindings \
        "move-to-workspace-$i" "['<Super><Shift>$i']"
done

# Workspace 10 uses Super+0
if (( NUM_WORKSPACES >= 10 )); then
    gsettings set org.gnome.desktop.wm.keybindings \
        switch-to-workspace-10 "['<Super>0']"

    gsettings set org.gnome.desktop.wm.keybindings \
        move-to-workspace-10 "['<Super><Shift>0']"
fi

echo
echo "================================"
echo " GNOME Workspace Setup Complete"
echo "================================"
echo
echo "Workspaces configured: $NUM_WORKSPACES"
echo
echo "Shortcuts:"
echo "  Super+1 ... Super+9      → Switch to workspace 1 ... 9"
echo "  Super+Shift+1 ... 9      → Move window to workspace 1 ... 9"

if (( NUM_WORKSPACES == 10 )); then
    echo "  Super+0                  → Switch to workspace 10"
    echo "  Super+Shift+0            → Move window to workspace 10"
fi

echo
echo "GNOME Shell Super+1 through Super+9 application shortcuts: DISABLED"
echo
echo "If the shortcuts do not work immediately, log out and back in."

