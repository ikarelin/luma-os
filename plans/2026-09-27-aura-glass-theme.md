# Aura Glass integration plan

- [x] Inspect the current LumaOS theme hooks and Aura Glass installer.
- [ ] Replace the MacTahoe build hook with a pinned Aura Glass installer hook.
- [ ] Update GNOME defaults and remove the Tahoe runtime synchronizer.
- [ ] Add Aura Glass runtime/build dependencies and a local cache updater.
- [ ] Update user-facing build documentation.
- [ ] Run shell syntax and repository consistency checks.
- [ ] Sync the branch to the build server, populate the local cache, and build
  an ISO through the Aura Glass hook.

## Decision

Use Aura Glass Minimal rather than its optional extension packs. The foundation
already installs User Themes, Open Bar, Blur My Shell, Custom OSD, and the Aura
helper. This avoids overlapping workflow extensions while retaining LumaOS's
existing Dash to Dock configuration.

The installer runs once against `/etc/skel` inside the live-build chroot. This
produces a complete default profile for the live user, the Calamares-created
user, and future users without requiring a network connection at first login.
