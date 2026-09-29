# Aura Glass integration plan

- [x] Inspect the current LumaOS theme hooks and Aura Glass installer.
- [x] Replace the MacTahoe build hook with a pinned Aura Glass installer hook.
- [x] Update GNOME defaults and remove the Tahoe runtime synchronizer.
- [x] Add Aura Glass runtime/build dependencies and a local cache updater.
- [x] Update user-facing build documentation.
- [x] Run shell syntax and repository consistency checks.
- [x] Sync the branch to the build server, populate the local cache, and build
  an ISO through the Aura Glass hook. The clean build and a complete chroot
  hook test passed on 2026-09-29. The resulting hybrid ISO supports BIOS and
  UEFI boot and has SHA-256
  `6edb0838c7bb5ba9e66c3ea45d27a9a890bb4006808c1fe7a4c87b39240a95ee`.

## Decision

Use Aura Glass Minimal rather than its optional extension packs. The foundation
already installs User Themes, Open Bar, Blur My Shell, Custom OSD, and the Aura
helper. This avoids overlapping workflow extensions while retaining LumaOS's
existing Dash to Dock configuration.

The installer runs once against `/etc/skel` inside the live-build chroot. This
produces a complete default profile for the live user, the Calamares-created
user, and future users without requiring a network connection at first login.
