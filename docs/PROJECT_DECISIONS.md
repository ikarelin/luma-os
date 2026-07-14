# Project Decisions

## 2026-07-04: Base Distribution

Chosen base: Debian 13 "trixie".

Reasons:

- Debian 13 is stable and has long support.
- Debian live images and `live-build` provide a direct path to custom ISO work.
- GNOME gives the closest default shape for the target desktop: rounded GTK
  applications, a top panel, overview workflow, and a straightforward path to a
  dock through Dash-to-Dock.
- The build host runs Deepin, which is close enough to Debian-style tooling to
  make `apt`, `debootstrap`, and `live-build` practical.

Alternatives considered:

- Ubuntu 26.04 LTS / Kubuntu base: strong hardware support, but more Canonical
  policy and trademark surface.
- Fedora KDE: fresher KDE, but a shorter support window and RPM build workflow.
- openSUSE with KIWI: powerful image tooling, but a larger workflow shift for
  the current Deepin build host.

## Name

Chosen project name: Luma Linux.

Reasons:

- Short and memorable.
- Suggests light, clarity, and glass-like visual treatment.
- Does not directly reference Apple, macOS, Tahoe, Aqua, or other protected
  branding.

## Visual Direction

The design target is a refined translucent desktop:

- light/dark themes
- soft window decorations
- dock-first workflow
- compact top panel
- polished login screen
- original wallpapers and icons
- clear avoidance of proprietary Apple assets

## 2026-07-04: Dock Implementation

Do not depend on Latte Dock. The project has moved to GNOME, where
Dash-to-Dock is the first dock implementation to try. Plank can be evaluated
later, but Dash-to-Dock fits GNOME Shell and Wayland better.

## 2026-07-04: First ISO Package Scope

Do not use broad desktop task packages for the alpha ISO. They pull very large
application sets. Start with an explicit GNOME package list and add
applications deliberately.

Use `fonts-noto-core` and `fonts-noto-ui-core` instead of the broad
`fonts-noto` meta package to avoid pulling very large font families during early
build iteration.

## 2026-07-05: Desktop Pivot To GNOME

Move from KDE Plasma to GNOME for the alpha direction.

Reasons:

- GNOME applications use rounded GTK surfaces that better match the desired
  polished desktop feel.
- GNOME already has a macOS-like top panel.
- Dash-to-Dock can provide a dock-like workflow with less custom panel work.
- The first alpha should use Chromium instead of Firefox.

Chromium is acceptable for Luma Linux as an open-source browser package, but
the project must not use Google Chrome branding or imply a Google-distributed
browser.

## 2026-07-05: Project Package Repository

Create a local APT repository on the build host before publishing packages to a
public mirror.

Initial local endpoints:

- `http://192.168.1.81:8080/luma-linux/repo`
- `ftp://192.168.1.81/luma-linux/repo`

Use nginx for HTTP and vsftpd for read-only anonymous FTP. The initial alpha
repository can be unsigned and referenced with `[trusted=yes]`; before public
distribution, add a Luma archive signing key and ship it through a
`luma-archive-keyring` package.

Enable all Debian archive areas needed for desktop hardware support:

- `main`
- `contrib`
- `non-free`
- `non-free-firmware`

## 2026-07-05: Calamares GRUB Install On Removable EFI Media

Install GRUB through a Luma wrapper configured in Calamares:

```text
grubInstall: "luma-grub-install"
```

The wrapper adds `--removable` for EFI installs. This avoids failures on
SD-card/USB-like target media where GRUB cannot rely on a normal firmware NVRAM
boot entry. BIOS installs still call `grub-install` without `--removable`.

## 2026-07-06: Disable Live-Build Debian Installer

Use Calamares as the only graphical installer for the alpha ISO and set:

```text
--debian-installer none
```

The live-build Debian Installer stage is redundant for Luma and was fragile on
the build host when DNS temporarily failed during `lb installer_debian-installer`.

## 2026-07-06: Installer Fixes From First GNOME ISO Test

Fixes after testing the GNOME ISO:

- Use `--image-name luma-linux-alpha` because live-build appends architecture.
- Put `en_US.UTF-8` first in `--bootappend-live` so Calamares starts in
  American English by default.
- Install GRUB EFI/BIOS platform binaries in the live image instead of letting
  Calamares install them over the network. Use `grub2-common`,
  `grub-pc-bin`, and `grub-efi-amd64-bin`; do not install both conflicting
  metapackages `grub-pc` and `grub-efi-amd64`.
- Override Debian's `calamares-bootloader-config` helper so it does not run
  `apt-get install grub-efi` during installation.
- Check `update-grub` and `grub-mkconfig` as executable files inside the target
  chroot, because `command -v` must be run through a shell and cannot be
  executed directly by `chroot`.
- Create `/boot/grub` in the target before running `update-grub`/`grub-mkconfig`
  because Calamares runs `bootloader-config` before the final bootloader module.
- Keep only the latest installed kernel package before building the ISO, so the
  boot menu does not show stale kernel versions.

## 2026-07-06: Desktop And Laptop Hardware Coverage

Add explicit firmware coverage for common desktop and notebook hardware:
Realtek, Intel, Qualcomm Atheros, Broadcom/Cypress, MediaTek/Ralink, Libertas,
and TI Wi-Fi/Bluetooth families; Intel, AMD, and NVIDIA graphics firmware;
Intel SOF audio firmware; and Intel/AMD CPU microcode.

The package list intentionally avoids server-specific driver bundles for now,
but favors broad consumer hardware support in the live session and installed
system. Realtek firmware is especially important for USB Wi-Fi adapters using
modules such as `rtw88_8821cu`.

Add `gnome-shell-extension-user-theme`, `gnome-shell-extension-manager`, and
Thunderbird to support theme work and a complete default desktop.
