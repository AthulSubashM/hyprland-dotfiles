# Hyprland Dotfiles

My personal Hyprland dotfiles, configured for a modern and efficient Arch Linux (or similar) setup. This repository includes configurations for Hyprland, Waybar, Neovim, SwayNC, Wlogout, Wofi, and more, aiming for a sleek and productive workflow.

## Features

-   **Hyprland:** Tiling Wayland compositor with custom keybinds, window rules, and autostart applications.
-   **Waybar:** Highly customizable Wayland bar with various modules for system status, notifications, and more.
-   **Neovim:** A powerful and extensible text editor setup with LazyVim for a fast and efficient coding experience.
-   **SwayNC:** A lightweight and customizable notification daemon for Wayland.
-   **Wal:** Pywal integration for dynamic color schemes based on your wallpaper.
-   **Wlogout:** A simple and elegant logout menu for Hyprland.
-   **Wofi:** A highly configurable application launcher.
-   **Custom Scripts:** A collection of utility scripts for various tasks like floating windows, toggling Bluetooth, and managing power.

## Installation

**Note:** These dotfiles are primarily designed for Arch Linux and may require adjustments for other distributions.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/athul/hyprland-dotfiles.git ~/.config/hyprland-dotfiles
    ```

2.  **Install Dependencies:**

    Ensure you have all necessary packages installed. Key dependencies include:

    -   Hyprland
    -   Waybar
    -   Neovim (with LazyVim)
    -   SwayNC
    -   Wlogout
    -   Wofi
    -   `python-pywal` (for Wal)
    -   `hypridle`, `hyprlock`, `hyprpaper`
    -   `pavucontrol` (for audio control)
    -   `bluez`, `bluez-utils` (for Bluetooth)
    -   `networkmanager`, `network-manager-applet` (for network management)
    -   `grim`, `slurp` (for screenshots)
    -   `wl-clipboard` (for clipboard management)
    -   `xdg-desktop-portal-hyprland`

    You can install most of these on Arch Linux using `pacman` or an AUR helper like `yay`:

    ```bash
    sudo pacman -S hyprland waybar neovim swaync wlogout wofi python-pywal hypridle hyprlock hyprpaper pavucontrol bluez bluez-utils networkmanager network-manager-applet grim slurp wl-clipboard xdg-desktop-portal-hyprland
    yay -S hyprland-plugins # If you use hyprplugins
    ```

3.  **Symlink Configuration Files:**

    It's recommended to symlink the configuration directories to your `~/.config` folder. **Backup your existing configurations first!**

    ```bash
    # Backup existing configs (optional but recommended)
    mv ~/.config/hypr ~/.config/hypr.bak
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.config/swaync ~/.config/swaync.bak
    mv ~/.config/wal ~/.config/wal.bak
    mv ~/.config/waybar ~/.config/waybar.bak
    mv ~/.config/wlogout ~/.config/wlogout.bak
    mv ~/.config/wofi ~/.config/wofi.bak

    # Create symlinks
    ln -s ~/.config/hyprland-dotfiles/.config/hypr ~/.config/hypr
    ln -s ~/.config/hyprland-dotfiles/.config/nvim ~/.config/nvim
    ln -s ~/.config/hyprland-dotfiles/.config/swaync ~/.config/swaync
    ln -s ~/.config/hyprland-dotfiles/.config/wal ~/.config/wal
    ln -s ~/.config/hyprland-dotfiles/.config/waybar ~/.config/waybar
    ln -s ~/.config/hyprland-dotfiles/.config/wlogout ~/.config/wlogout
    ln -s ~/.config/hyprland-dotfiles/.config/wofi ~/.config/wofi
    ```

4.  **Set up Wallpaper and Pywal:**

    Place your desired wallpaper in a location accessible by `hyprpaper` and configure `wal` to generate color schemes. You might need to adjust the `hyprpaper.conf` and `autostart.conf` files.

    ```bash
    # Example: Set a wallpaper and generate colorscheme
    wal -i /path/to/your/wallpaper.jpg
    ```

## Usage

-   **Start Hyprland:** Log in to your Hyprland session.
-   **Keybinds:** Refer to `~/.config/hypr/key-binds.conf` for a comprehensive list of keyboard shortcuts.
-   **Waybar:** The status bar should start automatically. Click on modules for more information or actions.
-   **Wofi:** Press `SUPER + D` to launch the application launcher.
-   **Wlogout:** Press `SUPER + ESC` to bring up the logout menu.

## Customization

-   **Hyprland:** Modify `~/.config/hypr/hyprland.conf` and the files in `~/.config/hypr/settings/` to adjust window behavior, monitors, and general settings.
-   **Waybar:** Edit `~/.config/waybar/config.jsonc` and `~/.config/waybar/style.css` to change modules, styling, and themes.
-   **Neovim:** Customize your Neovim setup in `~/.config/nvim/lua/config/` and `~/.config/nvim/lua/plugins/`.
-   **Colorschemes:** Change your wallpaper and run `wal -i /path/to/new/wallpaper.jpg` to generate a new color scheme across your applications.
-   **Scripts:** Explore and modify the scripts in `~/.config/hypr/scripts/` and `~/.config/waybar/scripts/` for custom functionalities.

Feel free to adapt these dotfiles to your personal preferences and workflow!