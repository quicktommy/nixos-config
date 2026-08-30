# Tommy's NixOS Configuration

My personal NixOS configuration built around **Hyprland + Noctalia**, managed with Nix flakes and Git.

The goal is to keep my desktop setup reproducible and version-controlled while keeping machine-specific hardware configuration out of the repository.

## What This Includes

- **NixOS 26.05**
- **Hyprland**
- **Noctalia**
- **Kitty**
- **Yazi**
- **Zen Browser**
- **Fish**
- **Steam**
- **Discord**
- **Spotify**
- **Nautilus**
- Custom wallpapers
- Custom Hyprland configuration
- Noctalia community templates and palettes

## Repository Structure

```text
/etc/nixos/
├── configuration.nix
├── flake.nix
├── deploy-home.sh
├── README.md
├── .gitignore
│
└── home/
    ├── hypr/
    │   ├── hyprland.lua
    │   ├── xdph.conf
    │   └── config/
    ├── kitty/
    │   ├── kitty.conf
    │   └── themes/
    ├── noctalia/
    │   ├── settings.toml
    │   ├── community-palettes/
    │   └── community-templates/
    └── Wallpapers/
```

## Hardware Configuration

`hardware-configuration.nix` is intentionally **not tracked by Git**.

NixOS generates this file for each individual machine. It can contain hardware-specific information such as:

- Filesystems and UUIDs
- Disk configuration
- Kernel modules
- CPU-specific configuration
- Hardware-related settings

The file is ignored using `.gitignore`.

The main configuration imports the local file from:

```nix
/etc/nixos/hardware-configuration.nix
```

Because the hardware configuration exists outside the Git flake source, rebuilding uses impure evaluation:

```bash
sudo nixos-rebuild switch --impure --flake /etc/nixos#nixos
```

## Installing on a Fresh Machine

A fresh NixOS installation already creates `/etc/nixos` and generates a machine-specific `hardware-configuration.nix`.

Because of this, the repository should **not** be cloned directly into `/etc/nixos`.

### 1. Generate the Hardware Configuration

If the NixOS installer has not already generated it, generate one for the current machine:

```bash
sudo nixos-generate-config --root /
```

This creates:

```text
/etc/nixos/configuration.nix
/etc/nixos/hardware-configuration.nix
```

The `hardware-configuration.nix` file remains local to the machine and is not committed to Git.

### 2. Get Git

If Git is not already installed:

```bash
nix-shell -p git
```

Verify it:

```bash
git --version
```

### 3. Clone the Configuration

Clone the repository into your home directory:

```bash
git clone https://github.com/quicktommy/nixos-config.git ~/nixos-config
```

### 4. Copy the Configuration

Copy the repository contents into `/etc/nixos`:

```bash
sudo cp -a ~/nixos-config/. /etc/nixos/
```

This copies the version-controlled configuration while leaving the machine's existing `hardware-configuration.nix` in place.

### 5. Build the System

Apply the configuration:

```bash
sudo nixos-rebuild switch --impure --flake /etc/nixos#nixos
```

The configuration will install the packages and enable the services defined in `configuration.nix`.

After the first successful rebuild, Git is installed as part of the system configuration.

## Applying Changes

After changing the configuration, rebuild the system with:

```bash
sudo nixos-rebuild switch --impure --flake /etc/nixos#nixos
```

The activation script automatically deploys the version-controlled files from `home/` into the appropriate locations in the user's home directory.

## Git Workflow

Check the current state:

```bash
git status
```

Review changes:

```bash
git diff
```

Stage and commit:

```bash
git add .
git commit -m "Describe the change"
```

Push to the remote repository:

```bash
git push
```

Machine-specific files should remain untracked.

## Machine-Specific Configuration

Hardware configuration is kept outside the repository so that the same personal configuration can be used on different machines.

Monitor configuration is currently one of the remaining areas that can depend on the hardware of the machine. The goal is to keep hardware-dependent settings separate from the shared personal configuration as the project evolves.

## Configuration Philosophy

This repository is a **personal NixOS configuration**, not a general-purpose NixOS distribution.

It focuses on:

- Reproducibility
- Declarative system configuration
- Version control
- Keeping personal preferences intact
- Keeping hardware-specific data out of Git
- Easy recovery after reinstalling NixOS

**My setup, but declarative.**