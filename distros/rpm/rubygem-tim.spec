# Generated from tim-0.1.2.gem by gem2rpm -*- rpm-spec -*-
%global gem_name tim
%global rubyabi 1.9.1

Summary: Embeddable client for Aeolus Image Factory
Name: rubygem-%{gem_name}
Version: 0.3.0
Release: 1%{?dist}
Group: Development/Languages
License: MIT
URL: https://github.com/aeolus-incubator/tim
Source0: http://rubygems.org/gems/%{gem_name}-%{version}.gem
Requires: ruby(abi) = %{rubyabi}
Requires: ruby(rubygems)
Requires: ruby
Requires: rubygem(rails) => 3.2.8
Requires: rubygem(rails) < 3.3
Requires: rubygem(haml)
Requires: rubygem(nokogiri)
Requires: rubygem(oauth)
BuildRequires: ruby(abi) = %{rubyabi}
BuildRequires: rubygems-devel
BuildRequires: ruby
BuildRequires: rubygem(nokogiri)
BuildRequires: rubygem(haml)
BuildRequires: rubygem(oauth)
BuildRequires: rubygem(sqlite3)
BuildRequires: rubygem(rspec)
BuildRequires: rubygem(rspec-rails)
BuildRequires: rubygem(rails) => 3.2.8
BuildRequires: rubygem(rails) < 3.3
BuildRequires: rubygem(bundler)
BuildRequires: rubygem(minitest)
BuildRequires: rubygem(database_cleaner)
BuildRequires: rubygem(factory_girl_rails) => 4.1.0
BuildRequires: rubygem(rake)
BuildRequires: rubygem(state_machine)
BuildArch: noarch
Provides: rubygem(%{gem_name}) = %{version}

%description
Rails engine client for the Aeolus Image Factory cross-cloud virtual machine
image builder.


%package doc
Summary: Documentation for %{name}
Group: Documentation
Requires: %{name} = %{version}-%{release}
BuildArch: noarch

%description doc
Documentation for %{name}

%prep
%setup -q -c -T
mkdir -p .%{gem_dir}
gem install --local --install-dir .%{gem_dir} \
            --force %{SOURCE0}

%build

%install
mkdir -p %{buildroot}%{gem_dir}
cp -a .%{gem_dir}/* \
        %{buildroot}%{gem_dir}/

%check
pushd .%{gem_instdir}
rake db:setup
rake -f test/dummy/Rakefile test:prepare
rspec -Ispec spec
popd

%files
%dir %{gem_instdir}
%{gem_libdir}
%exclude %{gem_cache}
%{gem_spec}
%doc %{gem_instdir}/MIT-LICENSE
%doc %{gem_instdir}/README.rdoc
%{gem_instdir}/Rakefile
%{gem_instdir}/spec
%{gem_instdir}/app
%{gem_instdir}/config
%{gem_instdir}/db
%{gem_instdir}/test
%{gem_instdir}/tim.gemspec


%files doc
%doc %{gem_docdir}
%{gem_instdir}/Gemfile

%changelog
* Tue Oct 23 2012 slinaber - 0.1.2-1
- Initial package
* Tue Feb 12 2012 mtaylor - 0.1.2-2
- Added rubygem-state_machine dependency
