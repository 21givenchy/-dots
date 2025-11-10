# NixOS Configuration with Hyprland Legacy Renderer

This NixOS configuration includes Hyprland with legacy renderer support for older hardware.

## Features

- **Hyprland v0.34.0** - Older version with legacy renderer support
- **Qtile Fallback** - Alternative window manager if Hyprland has issues
- **Waybar** - Status bar for Hyprland
- **Legacy Renderer Support** - Configured for older GPUs and software rendering

## Quick Start

### Building the Configuration

```bash
# Build and switch to the new configuration
sudo nixos-rebuild switch --flake .#imdead

# Just build without switching (test first)
sudo nixos-rebuild build --flake .#imdead
```

### First Time Setup

1. Clone this repository to your preferred location
2. Update `hardware-configuration.nix` with your system's hardware configuration
3. Edit `modules/programs.nix` to set your git email
4. Build and switch to the configuration

## Configuration Structure

```
.
├── flake.nix                    # Flake configuration with Hyprland v0.34.0
├── configuration.nix            # Main system configuration
├── home.nix                     # Home Manager configuration
├── hardware-configuration.nix   # Hardware-specific settings
└── modules/
    ├── hyprland.nix            # Hyprland window manager config
    ├── waybar.nix              # Status bar configuration
    ├── themes.nix              # GTK/Qt theming
    └── programs.nix            # Program configurations
```

## Legacy Renderer Configuration

This configuration includes several settings to support legacy hardware:

### Environment Variables Set

- `WLR_RENDERER_ALLOW_SOFTWARE=1` - Allow software rendering
- `WLR_NO_HARDWARE_CURSORS=1` - Disable hardware cursors
- Additional NVIDIA-specific variables (if applicable)

### Hyprland Settings

The Hyprland configuration includes:
- Optimized settings for older hardware
- VFR (Variable Frame Rate) enabled
- Reduced animation complexity
- Software cursor fallback

## Key Bindings

Default modifier key is `SUPER` (Windows key)

### Basic Window Management
- `SUPER + Return` - Open terminal (Alacritty)
- `SUPER + Q` - Close active window
- `SUPER + M` - Exit Hyprland
- `SUPER + E` - Open file manager (Dolphin)
- `SUPER + V` - Toggle floating mode
- `SUPER + R` - Open application launcher (Wofi)

### Navigation
- `SUPER + Arrow Keys` - Move focus between windows
- `SUPER + 1-9` - Switch to workspace 1-9
- `SUPER + SHIFT + 1-9` - Move window to workspace 1-9

### Mouse
- `SUPER + Left Click + Drag` - Move window
- `SUPER + Right Click + Drag` - Resize window

## Switching Between Hyprland and Qtile

The default session is set to Hyprland. To use Qtile instead:

1. On the login screen (SDDM), select Qtile from the session menu
2. Or edit `configuration.nix` and change:
   ```nix
   defaultSession = "qtile";  # instead of "hyprland"
   ```

## Troubleshooting

### Hyprland won't start
- Check logs: `journalctl -b -u display-manager`
- Try the Qtile fallback from the login screen
- Ensure your GPU supports OpenGL 3.3 or enable software rendering

### Performance Issues
- The legacy renderer is already enabled
- Consider reducing animation settings in `modules/hyprland.nix`
- Check if VSync is causing issues on your hardware

### Display Issues
- The configuration already sets `WLR_NO_HARDWARE_CURSORS=1`
- Try disabling blur in `modules/hyprland.nix` decoration settings

## Updating

```bash
# Update flake inputs
nix flake update

# Rebuild with new inputs
sudo nixos-rebuild switch --flake .#imdead
```

## Why Hyprland v0.34.0?

Hyprland v0.34.0 is used because it includes the legacy renderer option that was removed in later versions. This is essential for:
- Older GPUs that don't support modern rendering features
- Systems requiring software rendering fallback
- Virtual machines with limited GPU support

## Customization

### Change Theme
Edit `modules/themes.nix` to customize GTK and Qt themes.

### Modify Hyprland Settings
Edit `modules/hyprland.nix` to adjust window manager behavior, keybindings, and appearance.

### Add/Remove Packages
Edit `home.nix` to add or remove user packages.
Edit `configuration.nix` to add or remove system packages.

## Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Waybar Configuration](https://github.com/Alexays/Waybar/wiki)
