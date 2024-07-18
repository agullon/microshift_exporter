#!/bin/bash

set -x

# create rpm build dir
rm -rf ~/rpmbuild/
mkdir -p ~/rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS,tmp}
cd ~/rpmbuild

# copy yaml file
cp ../microshift_exporter/microshift_exporter.yaml SOURCES/microshift-exporter.yaml

cat <<EOF > SPECS/microshift-exporter.spec
Summary: A MicroShift exporter
Name: microshift-exporter
Version: 0.0.1
Release: 1
License: GPL+
SOURCE0 : %{name}.yaml
URL: http://github.com/agullon/microshift-exporter

%description
%prep
%setup -q
%build
%install
%clean
%files
%changelog

EOF

rpmlint SPECS/microshift-exporter.spec

rpmbuild -bs -v SPECS/microshift-exporter.spec

tree ~/rpmbuild

rpm -ql SRPMS/microshift-exporter-0.0.1-1.src.rpm
