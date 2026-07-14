#!/bin/sh
set -e

echo "== Host =="
hostnamectl

echo "== Disk =="
df -h /home

echo "== Memory =="
free -h

echo "== Sudo =="
sudo -n true && echo "passwordless sudo: OK"

echo "== Build tools =="
command -v lb || true
command -v debootstrap || true
command -v xorriso || true
