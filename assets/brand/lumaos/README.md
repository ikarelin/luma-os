# LumaOS Brand Assets

This directory contains the first production brand asset pack for LumaOS.

The chosen mark is based on `lumaos-mark-aurora-core-large.svg`: a clean,
rounded, gradient letterform without the outer ring or internal light stripes.
It should stay simple enough to work as a boot logo, app icon, favicon, and OS
identity mark.

## Source Files

| File | Use |
| --- | --- |
| `source/lumaos-mark.svg` | Primary transparent SVG mark. Use this as the source of truth. |
| `source/lumaos-app-icon.svg` | Rounded-square application/system icon version. |
| `source/lumaos-mark-mono-light.svg` | White monochrome mark for dark backgrounds. |
| `source/lumaos-mark-mono-dark.svg` | Dark monochrome mark for light backgrounds. |
| `source/lumaos-wordmark.svg` | Horizontal logo lockup for installer, website, README, and release pages. |
| `source/lumaos-boot-logo.svg` | Boot splash lockup with light text for Plymouth. |

## Export Targets

PNG exports should be generated from the source SVG files into `exports/png/`.
Recommended sizes:

| Asset | Sizes |
| --- | --- |
| App icon | 16, 24, 32, 48, 64, 128, 256, 512, 1024 px |
| Boot/Plymouth logo | 128, 256, 512 px |
| Installer logo | 256, 512 px |
| Website/favicon | 16, 32, 180, 192, 512 px |
| Plymouth lockup | 512x128, 640x160 px |

## Palette

| Token | Hex | Role |
| --- | --- | --- |
| `luma-navy` | `#071526` | Dark icon tile, boot background |
| `luma-sky` | `#6FE3FF` | Bright aurora highlight |
| `luma-blue` | `#397BFF` | Primary brand blue |
| `luma-indigo` | `#1F3BD6` | Deep gradient end |
| `luma-ink` | `#0A1020` | Dark text/mono mark |
| `luma-white` | `#FFFFFF` | Light text/mono mark |

## Packaging Direction

These files are intended to become the input for future Debian packages:

- `lumaos-artwork`
- `lumaos-branding`
- `lumaos-default-settings`
- `lumaos-calamares-settings`
