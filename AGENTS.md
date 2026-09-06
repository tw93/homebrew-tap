# Homebrew Tap Agent Guide

This repository owns the `kakuku` cask in `Casks/kakuku.rb` and the Mole migration to Homebrew Core in `tap_migrations.json`. README documents user install commands.

- Keep the cask version, release URL, and SHA-256 tied to the same published Kaku DMG. A source commit or release title does not prove downloaded bytes.
- Preserve the `kaku` command target, cask conflict, and existing migration unless the task explicitly changes them.
- Check Ruby syntax with `ruby -c Casks/kakuku.rb` and JSON syntax with `python3 -m json.tool tap_migrations.json`.
- Cask changes also need the published DMG's checksum and install contract checked. Do not run installation, upgrade, uninstall, or zap as a read-only audit.
