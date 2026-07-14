# Local Package Repository

Luma Linux uses a local APT repository for project packages before they are
published to a public mirror.

## Local URLs

```text
http://192.168.1.81:8080/luma-linux/repo
ftp://192.168.1.81/luma-linux/repo
```

HTTP is served by nginx on port 8080 to avoid conflicts with any existing local
web services. FTP is read-only anonymous FTP served by vsftpd.

## Initial Setup

Run this on the Deepin build host when no live-build process is using apt/dpkg:

```sh
cd /home/ikarelin/luma_linux
sudo ./scripts/setup-local-repo-server.sh
```

The setup script installs:

- `nginx`
- `vsftpd`
- `apt-utils`
- `dpkg-dev`

It creates the repository under:

```text
/srv/luma-linux/repo
```

## Add Packages

Copy custom `.deb` files into:

```text
/srv/luma-linux/repo/pool/main/
```

Then regenerate metadata:

```sh
cd /home/ikarelin/luma_linux
./scripts/update-local-repo.sh
```

The first alpha repository is intentionally unsigned and consumed with
`[trusted=yes]` in live-build. Before publishing a public mirror, add a Luma
archive signing key and ship it as a keyring package.

## Live-Build Integration

The local repository is included during image build through:

```text
config/archives/luma-local.list.chroot
config/archives/luma-local.list.binary
```

The Debian base archive areas are:

```text
main contrib non-free non-free-firmware
```
