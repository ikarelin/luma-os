#!/bin/sh
set -e

REPO_ROOT="${LUMA_REPO_ROOT:-/srv/luma-linux/repo}"
DIST="${LUMA_REPO_DIST:-trixie}"
COMPONENT="${LUMA_REPO_COMPONENT:-main}"
ARCH="${LUMA_REPO_ARCH:-amd64}"

if ! command -v apt-ftparchive >/dev/null 2>&1; then
  echo "apt-ftparchive is missing. Install apt-utils first." >&2
  exit 1
fi

install -d "$REPO_ROOT/pool/$COMPONENT"
install -d "$REPO_ROOT/dists/$DIST/$COMPONENT/binary-$ARCH"

PACKAGES="$REPO_ROOT/dists/$DIST/$COMPONENT/binary-$ARCH/Packages"
apt-ftparchive packages "$REPO_ROOT/pool" > "$PACKAGES"
gzip -kf "$PACKAGES"

RELEASE_CONF="$(mktemp)"
trap 'rm -f "$RELEASE_CONF"' EXIT

cat > "$RELEASE_CONF" <<EOF
APT::FTPArchive::Release::Origin "Luma Linux";
APT::FTPArchive::Release::Label "Luma Linux Local";
APT::FTPArchive::Release::Suite "$DIST";
APT::FTPArchive::Release::Codename "$DIST";
APT::FTPArchive::Release::Architectures "$ARCH all";
APT::FTPArchive::Release::Components "$COMPONENT";
APT::FTPArchive::Release::Description "Local Luma Linux package repository";
EOF

apt-ftparchive -c "$RELEASE_CONF" release "$REPO_ROOT/dists/$DIST" > "$REPO_ROOT/dists/$DIST/Release"

echo "Updated $REPO_ROOT"
echo "HTTP: http://192.168.1.81:8080/luma-linux/repo"
echo "FTP:  ftp://192.168.1.81/luma-linux/repo"
