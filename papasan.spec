%define revcount %(git rev-list HEAD | wc -l)
%define treeish %(git rev-parse --short HEAD)
%define localmods %(git diff-files --exit-code --quiet  || date +.m%%j%%H%%M%%S)

%define srcdir   %{getenv:PWD}

Summary: Papasan REST server
Name: papasan
Version: 1.0
Release: %{revcount}.%{treeish}%{localmods}
Distribution: Redgates/Services
Group: System Environment/Daemons
License: MIT
Vendor: redgates.com
Packager: Karl Redgate <Karl.Redgate@gmail.com>
BuildArch: noarch

%define _topdir %(echo $PWD)/rpm
BuildRoot: %{_topdir}/BUILDROOT

Requires: nodejs
Requires: npm
Requires: jq
Requires(preun): chkconfig
Requires(post): chkconfig

%description
Config and scripts for the Papasan service and
related command line tools.

%prep
%build

%install
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/init/
%{__install} --mode=755 %{srcdir}/init/*.conf $RPM_BUILD_ROOT/etc/init

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/sysconfig/
%{__install} --mode=644 %{srcdir}/sysconfig/* $RPM_BUILD_ROOT/etc/sysconfig/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/cron.d/
%{__install} --mode=644 %{srcdir}/cron.d/* $RPM_BUILD_ROOT/etc/cron.d/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/bash_completion.d
%{__install} --mode=644 %{srcdir}/completions/* $RPM_BUILD_ROOT/etc/bash_completion.d/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/profile.d/
%{__install} --mode=644 %{srcdir}/profile.d/* $RPM_BUILD_ROOT/etc/profile.d/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/rsyslog.d/
%{__install} --mode=644 %{srcdir}/rsyslog.d/* $RPM_BUILD_ROOT/etc/rsyslog.d/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/etc/update-motd.d/
%{__install} --mode=755 %{srcdir}/update-motd.d/* $RPM_BUILD_ROOT/etc/update-motd.d/

# Node.JS is idiotic about locating "modules" and it does not agree
# with the standard RHEL/CentOS installs which put modules in /usr/lib/node_modules
# Node.JS will not look in that directory - but does look in the /usr/lib/node
# Here we create a workaround symlink - so that we are not propogating ENV vars all
# over the place.
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/lib/
ln -s node_modules $RPM_BUILD_ROOT/usr/lib/node

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/lib/node_modules/papasan/lib
%{__install} --mode=755 %{srcdir}/lib/node_modules/papasan/*.* $RPM_BUILD_ROOT/usr/lib/node_modules/papasan
%{__install} --mode=755 %{srcdir}/lib/node_modules/papasan/lib/* $RPM_BUILD_ROOT/usr/lib/node_modules/papasan/lib

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/lib/node_modules/uuid/lib
%{__install} --mode=755 %{srcdir}/lib/node_modules/uuid/*.* $RPM_BUILD_ROOT/usr/lib/node_modules/uuid
%{__install} --mode=755 %{srcdir}/lib/node_modules/uuid/lib/* $RPM_BUILD_ROOT/usr/lib/node_modules/uuid/lib

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/lib/node_modules/pipeline/lib
%{__install} --mode=755 %{srcdir}/lib/node_modules/pipeline/*.* $RPM_BUILD_ROOT/usr/lib/node_modules/pipeline

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/libexec/papasan/dr
%{__install} --mode=755 %{srcdir}/libexec/papasan/dr/* $RPM_BUILD_ROOT/usr/libexec/papasan/dr/
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/libexec/papasan/setup
%{__install} --mode=755 %{srcdir}/libexec/papasan/setup/* $RPM_BUILD_ROOT/usr/libexec/papasan/setup/
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/libexec/papasan/aws
%{__install} --mode=755 %{srcdir}/libexec/papasan/aws/* $RPM_BUILD_ROOT/usr/libexec/papasan/aws/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/libexec/papasan/steward
%{__install} --mode=755 %{srcdir}/libexec/papasan/steward/* $RPM_BUILD_ROOT/usr/libexec/papasan/steward/

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/sbin
%{__install} --mode=755 %{srcdir}/sbin/* $RPM_BUILD_ROOT/usr/sbin

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/usr/share/man/man1/
%{__install} --mode=755 %{srcdir}/share/man/man1/*.1 $RPM_BUILD_ROOT/usr/share/man/man1/

( cd %{srcdir} ; tar cf - share/papasan ) | ( cd $RPM_BUILD_ROOT/usr ; tar xvf - )
( cd %{srcdir} ; tar cf - var ) | ( cd $RPM_BUILD_ROOT/ ; tar xvf - )

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/var/run/spawn/
#
#
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/var/lib/papasan/
%{__install} --mode=755 /dev/null $RPM_BUILD_ROOT/var/lib/papasan/network

%{__install} --directory --mode=755 $RPM_BUILD_ROOT/var/cache/papasan/customer/
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/var/cache/papasan/aws/
%{__install} --directory --mode=755 $RPM_BUILD_ROOT/var/db/papasan/{customer,protected-host,recovery-host,recovery-point,recovery-network}

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,0755)
%attr(0555,root,root) /usr/sbin/papasan
/etc/init/papasan.conf
/usr/lib/node_modules/papasan
/usr/lib/node_modules/uuid
/usr/lib/node_modules/pipeline
/usr/lib/node
/usr/libexec/papasan/
/etc/sysconfig/
/etc/bash_completion.d/
/etc/cron.d/
/etc/profile.d/
/etc/rsyslog.d/
/etc/update-motd.d/
/usr/share/man/
/usr/share/papasan/
%attr(0775,ec2-user,ec2-user) /var/cache/papasan/customer/
%attr(0775,papasan,papasan) /var/cache/papasan/aws/
%attr(0775,papasan,papasan) /var/db/papasan/
%attr(0775,papasan,papasan) /var/run/spawn/
%attr(0775,papasan,papasan) /var/lib/papasan/
%config /var/lib/papasan/network

%pre

function group_exists() {
    getent group $* > /dev/null 2>&1
}

function user_exists() {
    getent passwd $* > /dev/null 2>&1
}

group_exists papasan || groupadd papasan || :
user_exists papasan || useradd papasan -g papasan --create-home --shell /bin/false || :

# Only do this is ec2 user is present?
usermod --groups papasan ec2-user

%post
[ "$1" -gt 1 ] && {
    : Upgrading
}

[ "$1" = 1 ] && {
    : New install
}

/usr/libexec/papasan/setup/update-aliases

: ignore test return value

%preun
[ "$1" = 0 ] && {
    : cleanup
}

: ignore test return value

%postun

[ "$1" = 0 ] && {
    : This is really an uninstall
    groupmems --group papasan --del papasan
    groupdel papasan
}

: ignore test errs

%changelog

* Fri Sep 12 2014 Karl.Redgate <www.redgates.com>
- Initial release

# dis-vim:syntax=plain
# vim:autoindent expandtab sw=4
