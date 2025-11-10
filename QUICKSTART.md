# Quick Start Guide

## What's Been Added

Your NixOS configuration now includes **Hyprland v0.34.0** with full support for legacy renderer, which is essential for older hardware or systems that need software rendering fallback.

## Key Changes

### 1. Hyprland Configuration
- **Version**: v0.34.0 (older version with legacy renderer support)
- **Location**: `modules/hyprland.nix`
- **Features**:
  - Legacy renderer enabled via environment variables
  - Software rendering fallback (`WLR_RENDERER_ALLOW_SOFTWARE=1`)
  - Hardware cursor disabled for compatibility
  - Pre-configured keybindings and settings

### 2. Supporting Modules
- **Waybar** (`modules/waybar.nix`) - Modern status bar
- **Themes** (`modules/themes.nix`) - Dark theme for GTK/Qt
- **Programs** (`modules/programs.nix`) - Terminal and shell configs

### 3. System Integration
- Hyprland set as default session in display manager (SDDM)
- Qtile kept as fallback option
- All necessary packages installed

## How to Apply

```bash
# Navigate to your configuration directory
cd /path/to/your/-dots

# Build and switch to the new configuration
sudo nixos-rebuild switch --flake .#imdead

# If that doesn't work, try updating the flake first
nix flake update
sudo nixos-rebuild switch --flake .#imdead
```

## After Installation

1. **Reboot your system** or logout and select "Hyprland" from the session menu
2. **Test the configuration**:
   - Press `SUPER + Return` to open a terminal
   - Press `SUPER + R` to open the application launcher (Wofi)
   - Press `SUPER + E` to open the file manager

3. **If Hyprland doesn't work**:
   - Select "Qtile" from the session menu as a fallback
   - Check logs: `journalctl -xe | grep hyprland`

## Important Environment Variables

These are already set in your configuration for legacy hardware support:

```bash
WLR_RENDERER_ALLOW_SOFTWARE=1  # Enable software rendering
WLR_NO_HARDWARE_CURSORS=1      # Disable hardware cursors
NIXOS_OZONE_WL=1               # Enable Wayland for Chromium-based apps
```

## Customization

### Change Keybindings
Edit `modules/hyprland.nix` and modify the `bind` array.

### Adjust Performance
If you experience performance issues, you can:
1. Disable blur: Set `enabled = false;` in decoration.blur
2. Reduce animations: Set `enabled = false;` in animations
3. Lower gap sizes in general section

### Change Default Session
Edit `configuration.nix` and change:
```nix
defaultSession = "qtile";  # or "hyprland"
```

## Troubleshooting

### Screen tearing or flickering
- Already configured with `WLR_NO_HARDWARE_CURSORS=1`
- Try disabling VRR in monitor settings

### High CPU usage
- Disable blur and reduce animations in `modules/hyprland.nix`

### Can't login to Hyprland
- Use Qtile as fallback from the session menu
- Check if your GPU supports OpenGL 3.3: `glxinfo | grep "OpenGL version"`

## Next Steps

1. Customize your theme in `modules/themes.nix`
2. Add your own keybindings in `modules/hyprland.nix`
3. Configure additional programs in `modules/programs.nix`
4. Update your git email in `modules/programs.nix`

For more detailed information, see the main README.md file.
