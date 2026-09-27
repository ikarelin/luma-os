# Aura Glass desktop profile

## Problem

LumaOS currently installs and continuously reapplies the MacTahoe GTK and
GNOME Shell themes. The desired desktop theme is now Aura Glass.

## Goal

Ship Aura Glass as the default LumaOS desktop profile while preserving LumaOS
branding, wallpapers, dock favorites, Flatpak support, and installer behavior.

## Acceptance criteria

- New live and installed users start with the Aura Glass GTK and shell theme.
- Aura Glass uses the blue accent, rounded geometry, 90% app transparency,
  Colloid Blue icons, and Adwaita cursors.
- Dash to Dock keeps the existing LumaOS layout and favorites.
- The old Tahoe theme synchronizer cannot overwrite Aura Glass.
- GDM receives the Aura Glass login theme during image construction without a
  per-user privileged background-sync service.
- The image can build from the server's local Aura Glass checkout, with a
  pinned upstream fallback.

## Constraints

- Debian 13 / GNOME 48 compatibility.
- Aura Glass update checks are disabled; distribution updates remain owned by
  LumaOS.
- Aura Glass is dark-first by upstream design. No unsupported light variant is
  fabricated in LumaOS.

## Non-goals

- Replacing LumaOS branding or wallpapers.
- Adding Aura Glass's optional extension packs.
- Changing Calamares, Plymouth, GRUB, or application selection.
