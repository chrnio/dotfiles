# GNOME Workspace Keyboard Setup

This reproduces the workspace configuration we applied.

## Set a fixed number of workspaces

``` bash
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 8
```

## Clear existing workspace bindings

``` bash
for i in {1..8}; do
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "[]"
done
```

## Bind Super+1..8 and Super+Shift+1..8

``` bash
for i in {1..8}; do
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
done
```

## Remove GNOME Shell application shortcuts

GNOME reserves `Super+1` through `Super+8` for switching to pinned
applications. Clear those bindings so the workspace shortcuts take
precedence.

``` bash
for i in {1..8}; do
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
done
```

## Verify bindings

``` bash
gsettings list-recursively | grep "<Super>"
```

If shortcuts still do not work after changing these settings, log out
and back in.
