# PIL Git scripts

Debian .deb package containing set of custom scripts for common Git tasks.

Current scripts are:
- `git_remote_status.sh` - will query remote repository for status (for example if there are new commits to be pulled)
- `graph_log.sh` - will show nice decorated graph (text mode) of commits
- `push_branch.sh` - will push current branch to origin named `origin`

NOTE: All above commands are supposed to be invoked withing git repository
(directory or parent with valid `.git/` repo in it).


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


