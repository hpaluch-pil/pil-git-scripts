# PIL Git scripts

Here is Debian `.deb` and/or CentOS/openSUSE `.rpm` package
containing set of custom scripts for common Git tasks.

DISCLAIMER: These scripts are provided "as is" without any warranty! Use them on
your own risk!

Current scripts are:
- `git_remote_status.sh` - will query remote repository for status (for example if there are new commits to be pulled)
- `graph_log.sh` - will show nice decorated graph (text mode) of commits
- `push_branch.sh` - will push current branch to origin named `origin`

NOTE: All above commands are supposed to be invoked within git repository
(directory or parent with valid `.git/` repo in it).

# How to use Debian .deb package

Tested on Debian10.


First import Public Bintray key:

```bash
sudo apt-get install -y gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80  --recv-keys 379CE192D401AB61
```

Then create repository
file `/etc/apt/sources.list.d/pil_packages.list` with contents:

```
deb https://dl.bintray.com/hpaluch8192/pil-packages buster main
```

And then issue:

```bash
sudo apt-get update
```
NOTE: Ensure that there are no errors and/or warning(s) on GPG keys.

```bash
sudo apt-get install pil-git-scripts
```
And look into `/usr/local/bin/` for installed scripts.

# How to use .RPM package

If you just want to install this packages from JFrog Bintray repository,
then do this:

## Use RPM package from CentOS 7

```bash
sudo curl -o /etc/yum.repos.d/bintray-hpaluch8192-pil-packages-rpms.repo \
     https://bintray.com/hpaluch8192/pil-packages-rpms/rpm
sudo yum update
sudo yum makecache
sudo yum install pil-git-scripts
```

## Use RPM package from openSUSE LEAP 15.2

```bash
sudo curl -o /etc/zypp/repos.d/bintray-hpaluch8192-pil-packages-rpms.repo \
     https://bintray.com/hpaluch8192/pil-packages-rpms/rpm
sudo zypper ref
sudo zypper in pil-git-scripts
```

# How to build .deb package

## Build Setup
Tested on Debian10:

```bash
sudo apt-get install equivs libparse-debianchangelog-perl
```

## Building .deb package

Just invoke helper script:

```bash
./build_deb.sh
```

On success there should be generated `.deb` package *in this directory*
(not in parent).

To see contents of created `.deb` package use `dpkg -c`, for example:

```bash
dpkg -c pil-git-scripts_0.12_all.deb
```

## System installation

NOTE: It is preferred to use repository - see top of this README
for instructions.

To install directly this package without repository you need to:

```bash
# build current package
./build_deb.sh
# satisfy installation dependecy - required only with direct use of dpkg
sudo apt-get install git
# now install generated package
sudo dpkg -i pil-git-scripts_0.12_all.deb
# you can verify insallation using commands:
dpkg -l pil-git-scripts
dpkg -L pil-git-scripts
```

## Release tips

Package version is gathered from ChangeLog file so one must add
new entry there before making new release.

TIP: Use `date -R` to get ChangeLog compliant date format.


# How to build RPM packages

## Building RPM using mock

It is possible to build RPMs in chroot using `mock(1)` command. It is
supported, for example, on CentOS and even on Debian10.


For Debian install:

```bash
sudo apt-get install mock
```

For CentOS try:

```bash
sudo yum install mock
```

Add yourself to `mock` group:
```bash
sudo /usr/sbin/usermod -G mock -a $USER
```
Relogin to ensure that you are really in group `mock`.

Now you need to initialize chroot (only for the 1st time):
```bash
mock -r epel-7-x86_64 --init
```
Then run this script and follow instructions:
```bash
./prepare_for_mock.sh
```

## Native build under openSUSE LEAP 15.2

Install these packages:

```bash
sudo zypper in git-core rpm-build
```

## Native build under CentOS 7

Install these packages:

```bash
sudo yum install -y git rpm-build
```

## Native Building RPM (continued)

Clone this project using:

```bash
mkdir ~/projects
cd ~/projects
git clone https://github.com/hpaluch-pil/pil-git-scripts.git
cd pil-git-scripts
```

Now build RPM using script:
```bash
./build_rpm.sh
```

It should create RPM file as:

```
build/rpm-$ID/rpmbuild/RPMS/noarch/pil-git-scripts-0.12-0.noarch.rpm
```

Where `$ID` is defined under `/etc/os-release`, for example:

* `opensuse-leap` for `openSUSE LEAP 15.2`
* `centos` for `CentOS 7`


Install this RPM using standard command like:

```bash
source /etc/os-release # get $ID
sudo rpm -ivh \
	build/rpm-$ID/rpmbuild/RPMS/noarch/pil-git-scripts-0.12-0.noarch.rpm
```

