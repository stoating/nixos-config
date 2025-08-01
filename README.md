# Devbox

This repository contains a Nix flake for a small NixOS "devbox". The goal is to learn
about NixOS and evaluate it as a VM-based development environment that can be
accessed over SSH with any IDE.

## Contents

- `flake.nix` – top level Nix flake definition.
- `bootstrap/devbox.sh` – bootstrap script to set up the devbox on a fresh VM.
- `hosts/devbox/` – host specific configuration for the devbox VM:
  - `_devbox.nix` – user, git and locale variables generated by the bootstrap script.
  - `configuration.nix` – NixOS system configuration.
  - `home.nix` – Home Manager configuration for the user.
  - `hardware-configuration.nix` – hardware configuration generated by `nixos-generate-config`.

## Usage

1. Create a new VM and install a minimal NixOS system.
2. Adjust variables at the top of `bootstrap/devbox.sh` if needed
   (e.g. git user, email, locales).
3. Run the bootstrap script on the VM to clone this repository and install the
   devbox configuration:
   ```bash
   ./bootstrap/devbox.sh
   ```
   The script clones the repository to `~/nixos`, writes a `_devbox.nix` with
   your settings, copies your hardware configuration, and rebuilds the system
   using the flake.
4. After the setup you can SSH into the VM and use it as a development box with
   your preferred IDE.

For a short walkthrough see [this explainer video](https://youtu.be/8CXBBitdjBU?si=5nMUPbqLpnTdaSWu).

This project is a work in progress and meant for experimenting with NixOS.
