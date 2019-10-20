Name:           disc_challenge1
Version:        1
Release:        1%{?dist}
Summary:        Install file /etc/challenge. This file contains installation hostname and date and time

License:       	GPL 
URL:           	https://github.com/cchaduka
Source0:        disc_challenge1.tar.gz
BuildArch:	noarch
BuildRoot:	/usr/local/challenge1

%description
This RPM installs a file /etc/challenge. This file contains installation hostname and date/time

%prep
%setup -q


%build


%install
rm -rf $RPM_BUILD_ROOT
install -m 0755 -d $RPM_BUILD_ROOT/usr/local/challenge1
install -m 0755 disc_genfile1.sh $RPM_BUILD_ROOT/usr/local/challenge1/disc_genfile1.sh


%files
%defattr(-,root,root,-)
/usr/local/challenge1/disc_genfile1.sh
%post
sh /usr/local/challenge1/disc_genfile1.sh > /etc/challenge


