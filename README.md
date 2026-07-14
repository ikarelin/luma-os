# Luma Linux

Luma Linux is an experimental custom Linux distribution based on Debian 13
"trixie" with GNOME, Calamares, Chromium, and original Luma branding.

The project goal is a polished desktop for people who want a calm,
macOS-familiar workflow on an open Debian base: a top panel, dock-first
navigation, rounded GNOME applications, good firmware support, and clear
defaults without proprietary Apple assets.

> Status: early alpha. The ISO builds and boots, but installer behavior,
> branding, and package selection are still under active iteration.

## Target

- Base: Debian 13 "trixie"
- Desktop: GNOME
- Installer: Calamares
- Browser: Chromium
- Image type: hybrid live ISO
- Architecture: amd64
- Archive areas: `main contrib non-free non-free-firmware`
- Local package repository: optional local APT repo for future `luma-*`
  packages

## What Makes Luma Different

- GNOME defaults tuned toward a macOS-like top-panel and dock workflow.
- MacTahoe GTK, GNOME Shell, cursor, and icon themes are installed during the
  image build and exposed through the `LumaTahoe` system aliases.
- Chromium instead of Firefox in the default application set.
- Calamares installer with Luma-specific bootloader handling for removable EFI
  media.
- Project package repository support from the start.
- Original wallpapers, marks, and theme concepts, avoiding Apple trademarks and
  proprietary assets.

## Repository Layout

```text
auto/                         live-build entrypoints
config/                       live-build configuration
config/package-lists/         Debian package selections
config/includes.chroot/       files copied into the live system
config/hooks/                 live-build hooks
scripts/                      remote build and local repository helpers
docs/                         build notes, project decisions, publishing notes
assets/brand-concepts/        early visual identity concepts
```

## Quick Build

On the build host:

```sh
cd /home/ikarelin/luma_linux
./scripts/run-detached-build.sh
```

Check status:

```sh
./scripts/build-status.sh
```

Follow the log:

```sh
tail -f build-run.log
```

The generated ISO should appear as:

```text
luma-linux-alpha-amd64.hybrid.iso
```

Detailed build notes are in [docs/BUILD_REMOTE.md](docs/BUILD_REMOTE.md) and
[docs/USER_BUILD_COMMANDS.md](docs/USER_BUILD_COMMANDS.md).

## Local Package Repository

Luma can consume a local APT repository during image builds:

```text
http://192.168.1.81:8080/luma-linux/repo
ftp://192.168.1.81/luma-linux/repo
```

See [docs/LOCAL_REPOSITORY.md](docs/LOCAL_REPOSITORY.md).

## Design Boundary

Luma Linux should feel polished and familiar, but it must not ship Apple
trademarks, Apple wallpapers, Apple icons, or other proprietary assets. The
visual work should be original and only broadly inspired by translucency,
clarity, rounded surfaces, and a dock-first desktop workflow.

See [TRADEMARKS.md](TRADEMARKS.md).

## License

Unless noted otherwise, project scripts, configuration, documentation, and
original SVG concepts are licensed under the MIT License. See [LICENSE](LICENSE).

Generated raster brand concepts are prototypes for review and should not be
treated as final release assets until explicitly approved.
