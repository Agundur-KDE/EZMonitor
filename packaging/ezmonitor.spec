%ifarch aarch64
%undefine source_date_epoch_from_changelog
%endif

Name:           ezmonitor
Version:        0.1.1
Release:        1%{?dist}
Summary:        KDE Plasma 6 panel widget for APsystems EZ1 solar power monitoring

License:        GPL-3.0-or-later
URL:            https://github.com/Agundur-KDE/EZMonitor


BuildRequires:  cmake
BuildRequires:  gcc-c++
BuildRequires:  qt6-base-devel
BuildRequires:  qt6-declarative-devel
BuildRequires:  kf6-extra-cmake-modules


Requires:       plasma6-workspace

%description
EZMonitor is a lightweight KDE Plasma 6 widget that queries an APsystems EZ1
microinverter's local JSON API and shows live solar panel power output and
daily yield, directly in the Plasma panel. No cloud service involved, all
data stays local.

Source0: _service

%prep

rm -rf ./*

shopt -s nullglob
picked=""
for d in %{_sourcedir}/EZMonitor-* %{_sourcedir}/ezmonitor-* %{_sourcedir}/EZMonitor ; do
  if [ -d "$d" ] && [ -f "$d/CMakeLists.txt" ]; then
    picked="$d"
    break
  fi
done

if [ -n "$picked" ]; then
  cp -a "$picked"/. .
else
  for f in %{_sourcedir}/* ; do
    base="$(basename "$f")"
    case "$base" in
      *.spec|*.dsc|*.changes|*.obsinfo|_service|service_attic|screenshot|*.patch)
        continue ;;
    esac
    cp -a "$f" .
  done
fi

%build
%cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_INSTALL_PREFIX=%{_prefix}
%cmake_build

%install
%cmake_install


%files
%license LICENSE
%doc README.md
%{_datadir}/plasma/plasmoids/de.agundur.ezmonitor/
%{_datadir}/icons/hicolor/scalable/apps/ezmonitor.svg

%changelog
* Wed Jul 08 2026 Alec <info@agundur.de> - 0.1.1
- First automated OBS release via GitHub Actions (obs_scm pinned to the tag)
- Fixed License metadata (was "GPL", LICENSE file was even the wrong license
  text entirely — LGPL addendum instead of GPL-3.0-or-later)
- Added a real app icon from the repo's own unused sun-fill.svg (was
  borrowing the unrelated "electron" icon)
- Fixed URL (was pointing at a non-existent opencode.net address)
- Fixed %prep (was %setup -q expecting a tarball obs_scm never produces)
