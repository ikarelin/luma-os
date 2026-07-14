# Remote Build Notes

Remote host:

```text
ikarelin@192.168.1.81
```

Workspace:

```text
/home/ikarelin/luma_linux
```

Initial host check on 2026-07-04:

- OS: Deepin 25
- Kernel: Linux 6.18.36-amd64-desktop-rolling
- Machine: Lenovo ThinkCentre M79
- Free space on `/home`: about 416 GB
- RAM: 7.4 GiB total
- Passwordless sudo: available for `ikarelin`

## Dependencies

Install the first build dependencies:

```sh
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools isolinux syslinux-common
```

Optional packages to add later if needed:

```sh
sudo apt install qemu-system-x86 ovmf
```

## Build Commands

```sh
cd /home/ikarelin/luma_linux
./scripts/run-detached-build.sh
```

For a full purge rebuild, use:

```sh
LUMA_PURGE=1 ./scripts/run-detached-build.sh
```

The build configuration uses the CDN-backed `deb.debian.org` Debian mirrors.
If the build host has temporary routing issues, switch the mirror options in
`auto/config` to a nearby Debian mirror and rebuild with `LUMA_PURGE=1`.

## Test Command

After an ISO exists, test it with QEMU:

```sh
qemu-system-x86_64 -m 4096 -enable-kvm -cdrom lumaos-alpha-amd64.hybrid.iso
```
