# PIL Git scripts

Debian .deb package containing set of custom scripts for common Git tasks.

# How to build .deb package

## Build Setup
Tested on Debian10:

```bash
sudo apt-get install equivs
```

## Building .deb package

Just invoke helper script:

```bash
./build_deb.sh
```

On succcess there should be generated `.deb` package *in this directory*
(not in parent).

To see contents of created `.deb` package use `dpkg -c`, for example:

```bash
dpkg -c pil-git-scripts_0.9_all.deb
```


