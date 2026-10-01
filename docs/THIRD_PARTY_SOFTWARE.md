# Optional third-party software

Google Chrome is available from its official APT repository. LumaOS includes
the repository signing key and an AppStream catalog entry for GNOME Software.
The browser is not preinstalled. Chromium remains the default browser.

The public key is scoped to the Chrome source using Signed-By. Its primary
fingerprint is EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796.
Source: https://www.google.com/linuxrepositories/

AmneziaVPN currently distributes its desktop client as a Linux .run installer,
not an official Debian package repository. Its AmneziaWG PPA contains protocol
tools and kernel modules, not the desktop VPN application. No third-party
Amnezia repository is enabled in LumaOS.

Official installation instructions:
https://docs.amnezia.org/documentation/installing-app-on-linux/

To expose AmneziaVPN in GNOME Software, LumaOS would need to maintain a native
Debian package, including its service, dependencies, upgrade/removal behavior,
and AppStream metadata, and publish it in the LumaOS repository. This should
be tested separately from the upstream .run installation.
