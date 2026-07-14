REMOTE ?= ikarelin@192.168.1.81
REMOTE_DIR ?= /home/ikarelin/luma_linux

.PHONY: sync healthcheck status build-detached stop-build repo-setup repo-update

sync:
	ssh -o BatchMode=yes $(REMOTE) "mkdir -p $(REMOTE_DIR)"
	rsync -az \
		--exclude .git \
		--exclude .DS_Store \
		--exclude build-run.log \
		--exclude build-run.pid \
		--exclude chroot \
		--exclude cache \
		--exclude binary \
		--exclude artifacts \
		--exclude '*.iso' \
		--exclude '*.zsync' \
		./ $(REMOTE):$(REMOTE_DIR)/

healthcheck:
	ssh -o BatchMode=yes $(REMOTE) "cd $(REMOTE_DIR) && ./scripts/remote-healthcheck.sh"

status:
	ssh -o BatchMode=yes $(REMOTE) "$(REMOTE_DIR)/scripts/build-status.sh"

build-detached:
	ssh -o BatchMode=yes $(REMOTE) "$(REMOTE_DIR)/scripts/run-detached-build.sh"

stop-build:
	ssh -o BatchMode=yes $(REMOTE) "$(REMOTE_DIR)/scripts/stop-build.sh"

repo-setup:
	ssh -o BatchMode=yes $(REMOTE) "cd $(REMOTE_DIR) && sudo ./scripts/setup-local-repo-server.sh"

repo-update:
	ssh -o BatchMode=yes $(REMOTE) "cd $(REMOTE_DIR) && ./scripts/update-local-repo.sh"
