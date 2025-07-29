#!/usr/bin/env bash

# --- Configuration Variables ---
git_user="todo"
git_email="todo@gmail.com"
keyboard_layout="en"
locale_default="en_US.UTF-8"
locale_override="en_US.UTF-8"
timezone="Europe/Berlin"
system="x86_64-linux" # or x86_64-linux (AMD) aarch64-linux (ARM)

home_user="$USER"
home_directory="$HOME"

# --- Bootstrap Steps ---
echo "[1/6] Ensure ~/.ssh exists"
mkdir -p "$home_directory/.ssh"
chmod 700 "$home_directory/.ssh"

echo "[2/6] Adding github.com to known_hosts"
ssh-keyscan github.com >> "$home_directory/.ssh/known_hosts"

echo "[3/6] Cloning repo..."
git clone git@github.com:stoating/nixos-config.git "$home_directory/nixos"

echo "[4/6] Generating default config with your config..."
cat > "$home_directory/nixos/devbox/_devbox.nix" <<EOF
{
  git = {
    user = "${git_user}";
    email = "${git_email}";
  };

  home = {
    user = "${home_user}";
    directory = "${home_directory}";
  };

  keyboard = {
    layout = "${keyboard_layout}";
  };

  location = {
    default = "${locale_default}";
    override = "${locale_override}";
    timezone = "${timezone}";
  };

  system = "${system}";
}
EOF

echo "[5/6] Copying hardware-configuration.nix from /etc/nixos..."
sudo cp /etc/nixos/hardware-configuration.nix "$home_directory/nixos/hosts/devbox/hardware-configuration.nix"

echo "[6/6] Rebuilding system from flake as root..."
sudo nixos-rebuild switch --flake "$home_directory/nixos#devbox"
