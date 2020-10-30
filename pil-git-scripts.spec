# spec file for package pil-git-scripts
# Copyrigh  (c) 2020 Pickering Interfaces, Ltd.
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
Name:           pil-git-scripts
Version:        0.10
Release:        0
Summary:	PIL scripts handling basic git tasks
# FIXME: Select a correct license from https://github.com/openSUSE/spec-cleaner#spdx-licenses
License:        MIT
# FIXME: use correct group, see "https://en.opensuse.org/openSUSE:Package_group_guidelines"
Group:		Development/Git
Source:		%{name}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
BuildArch:      noarch

%description
Simple collection of basic scripts to handle common 
git tasks.

%prep
%setup -n %{name}

%build

%install
# from https://fedoraproject.org/wiki/Packaging:RPM_Source_Dir
install -m 755 -D -t $RPM_BUILD_ROOT/usr/local/bin scripts/*.sh

%files
%defattr(-,root,root)
/usr/local/bin

%doc ChangeLog README.md LICENSE


%changelog
# from https://www.suse.com/c/building-simple-rpms-arbitary-files/
* Sun Aug 01 2010  Your name here
- 0.10 r0 First release

