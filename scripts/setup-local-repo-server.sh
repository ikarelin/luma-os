#!/bin/sh
set -e

REPO_ROOT="${LUMA_REPO_ROOT:-/srv/luma-linux/repo}"
REPO_OWNER="${LUMA_REPO_OWNER:-${SUDO_USER:-$USER}}"
PROJECT_DIR="${LUMA_PROJECT_DIR:-/home/ikarelin/luma_linux}"

if [ "$(id -u)" -ne 0 ]; then
  exec sudo "$0" "$@"
fi

apt-get update
apt-get install -y nginx vsftpd apt-utils dpkg-dev

install -d -o "$REPO_OWNER" -g "$REPO_OWNER" /srv/luma-linux
install -d -o "$REPO_OWNER" -g "$REPO_OWNER" "$REPO_ROOT/pool/main"
install -d -o "$REPO_OWNER" -g "$REPO_OWNER" "$REPO_ROOT/dists/trixie/main/binary-amd64"
chown -R "$REPO_OWNER:$REPO_OWNER" /srv/luma-linux

cat > /etc/nginx/conf.d/luma-linux-repo.conf <<'EOF'
server {
    listen 8080;
    server_name _;
    root /srv;

    location /luma-linux/repo/ {
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        try_files $uri $uri/ =404;
    }
}
EOF

cp /etc/vsftpd.conf /etc/vsftpd.conf.luma-backup 2>/dev/null || true
cat > /etc/vsftpd.conf <<'EOF'
listen=NO
listen_ipv6=YES
anonymous_enable=YES
local_enable=NO
write_enable=NO
anon_root=/srv
no_anon_password=YES
hide_ids=YES
pasv_enable=YES
seccomp_sandbox=NO
EOF

if [ -x "$PROJECT_DIR/scripts/update-local-repo.sh" ]; then
  sudo -u "$REPO_OWNER" LUMA_REPO_ROOT="$REPO_ROOT" "$PROJECT_DIR/scripts/update-local-repo.sh"
fi

nginx -t
systemctl enable --now nginx
systemctl restart nginx
systemctl enable --now vsftpd
systemctl restart vsftpd

echo "Luma local repository server is ready:"
echo "  http://192.168.1.81:8080/luma-linux/repo"
echo "  ftp://192.168.1.81/luma-linux/repo"
