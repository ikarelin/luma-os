# Release Checklist

Use this checklist before publishing an ISO.

## Build

- Build completed without live-build errors.
- ISO filename has the expected shape:

```text
luma-linux-alpha-amd64.hybrid.iso
```

- SHA256 checksum generated:

```sh
sha256sum luma-linux-alpha-amd64.hybrid.iso
```

## Boot

- Live USB boots in UEFI mode.
- Boot menu shows only one current kernel.
- GNOME session starts.
- Chromium opens.
- NetworkManager can connect to network.

## Installer

- Calamares starts in American English by default.
- Calamares can switch to Russian manually.
- Installation to target disk completes.
- GRUB installation works on removable EFI media.
- Installed system boots after reboot.

## Packaging

- No Apple, Google Chrome, Debian, or GNOME trademark misuse.
- No proprietary wallpapers or icons.
- No build logs, cache, chroot, or ISO files are committed to git.
