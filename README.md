
<div align="center">
  <img alt="An icon representing a six-sided dice, showing a three" src="data/icons/128.svg" />
  <h1>Roll-It</h1>
  <h3>Simply roll a dice</h3>
</div>

<span align="center"> <img class="center" src="https://github.com/ellie-commons/rollit/blob/main/data/screenshots/screenshot1.png" alt="A screenshot of a window displaying a dice result and a history of past rolls"></span>
</div>

## Installation

Roll-It is designed and developed primarily for [elementary OS]. The latest stable release is available via AppCenter.

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg?new)](https://appcenter.elementary.io/io.github.ellie_commons.rollit) 


It is the updated, older codebase of Chance, which once was an elementary OS, but is now on Flathub and for GNOME systems:

The code is originally from @zelikos, who allowed us to update it for elementary OS

[<img src="https://flathub.org/assets/badges/flathub-badge-en.svg" width="160" alt="Download on Flathub">](https://flathub.org/apps/dev.zelikos.rollit)

## 💝 Donations

On the right you can donate to various contributors:
 - Akzel/Zelikos, the original author
 - teamcons, the main devs and maintainers behind this updated


## 🏗️ Building

Installation is as simple as installing the above, downloading and extracting the zip archive, changing to the new repo's directory,
and run the following command:

### On elementary OS or with its appcenter remote installed

```bash
flatpak-builder --force-clean --user --install-deps-from=appcenter --install builddir ./io.github.ellie_commons.rollit.yml
```

### On other systems:

First, install the elementary Flatpak runtime & SDK:

```bash
flatpak remote-add --if-not-exists appcenter https://flatpak.elementary.io/repo.flatpakrepo
flatpak install appcenter io.elementary.Platform//8.2 io.elementary.Sdk//8.2
```

Then follow the elementary OS instructions