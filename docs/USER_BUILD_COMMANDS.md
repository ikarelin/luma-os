# User Build Commands

Run these commands on the build host:

```sh
cd /home/ikarelin/luma_linux
```

## Start A Build

```sh
./scripts/run-detached-build.sh
```

This runs:

- `./auto/clean`
- `./auto/config`
- `./auto/build`

The build continues in the background and writes to:

```text
build-run.log
```

## Check Status

```sh
./scripts/build-status.sh
```

For a live log:

```sh
tail -f build-run.log
```

## Stop A Build

```sh
./scripts/stop-build.sh
```

If a build was interrupted during package installation, wait a minute before
starting another one so `apt` and `dpkg` can finish cleanup.

## Output

The ISO appears in:

```text
/home/ikarelin/luma_linux/
```

The current image name pattern is:

```text
luma-linux-alpha-amd64.hybrid.iso
```
