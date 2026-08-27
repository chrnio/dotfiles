# GNOME Workspace Keyboard Setup

This reproduces the workspace configuration we applied.

## Set a fixed number of workspaces

```bash
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10
```

## Clear existing workspace bindings

```bash
for i in {1..10}; do
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "[]"
done
```

## Bind Super+1..9, Super+0, and their move bindings

Workspaces 1 through 9 use `Super+1` through `Super+9`.
Workspace 10 uses `Super+0`.

`Super+Shift+1` through `Super+Shift+9` move the current window to
workspaces 1 through 9, while `Super+Shift+0` moves it to workspace 10.

```bash
for i in {1..9}; do
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
done

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"
```

## Remove GNOME Shell application shortcuts

GNOME reserves `Super+1` through `Super+9` for switching to pinned
applications. Clear those bindings so the workspace shortcuts take
precedence.

```bash
for i in {1..9}; do
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done
```

## Verify bindings

```bash
gsettings list-recursively | grep "<Super>"
```

If shortcuts still do not work after changing these settings, log out
and back in.
