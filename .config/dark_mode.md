# Sway Dark Mode Checklist

Goal: Ensure GTK, Qt, Electron, and modern Wayland applications start in dark mode and avoid white flashbang windows.

## Install Required Packages

```bash
sudo pacman -S \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    adw-gtk-theme \
    qt6ct
```

## Verify Portal

```bash
systemctl --user status xdg-desktop-portal
```

Expected:

```text
Active: active (running)
```

## Enable Global Dark Preference

Set:

```bash
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
```

Verify:

```bash
gsettings get org.gnome.desktop.interface color-scheme
```

Expected:

```text
'prefer-dark'
```

## Configure GTK3

Create:

```bash
mkdir -p ~/.config/gtk-3.0
```

`~/.config/gtk-3.0/settings.ini`

```ini
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=adw-gtk3-dark
```

## Configure GTK4

Create:

```bash
mkdir -p ~/.config/gtk-4.0
```

`~/.config/gtk-4.0/settings.ini`

```ini
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=adw-gtk3-dark
```

## Verify GTK Theme Exists

```bash
ls /usr/share/themes | grep adw
```

Expected:

```text
adw-gtk3
adw-gtk3-dark
```

If missing:

```bash
sudo pacman -S adw-gtk-theme
```

## Configure Qt Applications

Add to `~/.profile` or `~/.zprofile`:

```bash
export QT_QPA_PLATFORMTHEME=qt6ct
```

Configure:

```bash
qt6ct
```

Choose a dark style.

Logout and login afterwards.

## Verify Current Theme

Check dark preference:

```bash
gsettings get org.gnome.desktop.interface color-scheme
```

Check GTK theme:

```bash
gsettings get org.gnome.desktop.interface gtk-theme
```

Expected:

```text
'prefer-dark'
'adw-gtk3-dark'
```

## Browser Settings

### Firefox

Settings → General → Website Appearance → Dark

### Chromium

Launch with:

```bash
chromium --force-dark-mode
```

or enable dark mode in browser settings.

## Common Problems

### GTK app opens white

Check:

```bash
gsettings get org.gnome.desktop.interface color-scheme
cat ~/.config/gtk-3.0/settings.ini
cat ~/.config/gtk-4.0/settings.ini
```

### Theme configured but missing

Check:

```bash
ls /usr/share/themes
```

If `adw-gtk3-dark` is absent:

```bash
sudo pacman -S adw-gtk-theme
```

### Portal not running

Check:

```bash
systemctl --user status xdg-desktop-portal
```

## Quick Verification Commands

```bash
gsettings get org.gnome.desktop.interface color-scheme
gsettings get org.gnome.desktop.interface gtk-theme
systemctl --user status xdg-desktop-portal
ls /usr/share/themes | grep adw
```

Expected state:

```text
✓ prefer-dark
✓ adw-gtk3-dark
✓ xdg-desktop-portal running
✓ adw-gtk-theme installed
```
