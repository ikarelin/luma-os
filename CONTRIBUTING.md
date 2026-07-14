# Contributing

Luma Linux is in early alpha. Contributions should keep the project small,
reproducible, and legally clean.

## Principles

- Prefer Debian packages and standard live-build mechanisms.
- Keep package lists explicit; avoid broad desktop metapackages unless there is
  a clear reason.
- Do not add Apple trademarks, Apple wallpapers, Apple icons, or other
  proprietary assets.
- Prefer original SVGs for icons and logos.
- Keep build artifacts out of git.

## Before Opening A Pull Request

Run these checks locally:

```sh
sh -n auto/config auto/build auto/clean auto/purge
find scripts config/hooks config/includes.chroot/usr/sbin config/includes.chroot/usr/share/calamares/helpers -type f -perm -111 -exec sh -n {} \;
```

For image-build changes, include:

- What changed in package lists or live-build config.
- Whether the ISO was rebuilt.
- Whether the live session and Calamares installer were tested.
- Any known hardware or firmware caveats.

## Commit Style

Use short imperative commit messages:

```text
Add GNOME package list
Fix Calamares GRUB helper
Document local repository setup
```
