# spec file for package pil-git-scripts
#
# Copyright (c) 2020 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#
Name:           pil-git-scripts
Version:        0.10
Release:        0
Summary:	PIL scripts handling basic git tasks
# FIXME: Select a correct license from https://github.com/openSUSE/spec-cleaner#spdx-licenses
License:        MIT
# FIXME: use correct group, see "https://en.opensuse.org/openSUSE:Package_group_guidelines"
Group:          Extra
Source0:        scripts/git_remote_status.sh
Source1:        scripts/graph_log.sh
Source2:        scripts/push_branch.sh
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
Simple collection of basic scripts to handle common 
git tasks.

%prep
#%setup -q

%build

%install
# from https://fedoraproject.org/wiki/Packaging:RPM_Source_Dir
install -m 755 %{SOURCE0} $RPM_BUILD_ROOT/usr/local/bin
install -m 755 %{SOURCE1} $RPM_BUILD_ROOT/usr/local/bin
install -m 755 %{SOURCE2} $RPM_BUILD_ROOT/usr/local/bin

%files
%defattr(-,root,root)
%doc ChangeLog README LICENSE


%changelog
# from https://www.suse.com/c/building-simple-rpms-arbitary-files/
* Sun Aug 01 2010  Your name here
- 0.10 r0 First release

