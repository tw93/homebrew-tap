# Homebrew Tap Agent Guide

This repository owns the `kakuku` cask in `Casks/kakuku.rb` and the Mole migration to Homebrew Core in `tap_migrations.json`. README documents user install commands.

- Official Homebrew token is `kaku` (`brew install --cask kaku`). `kakuku` stays here for people who installed before that cask existed. Do not tell users official `kaku` is a different app, and do not present `tw93/tap/kakuku` as the default install.
- Keep the cask version, release URL, and SHA-256 tied to the same published Kaku DMG. A source commit or release title does not prove downloaded bytes.
- Preserve the `kaku` command target, `conflicts_with cask: "kaku"`, and the Mole migration unless the task explicitly changes them.
- Kaku releases still bump this tap through `kaku_release_published` / `bump.yml`. Do not add a `kakuku` tap migration unless the maintainer asks for it.
- Check Ruby syntax with `ruby -c Casks/kakuku.rb` and JSON syntax with `python3 -m json.tool tap_migrations.json`.
- Cask changes also need the published DMG's checksum and install contract checked. Do not run installation, upgrade, uninstall, or zap as a read-only audit.
