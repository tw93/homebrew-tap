# Homebrew Tap

Personal Homebrew tap for [@tw93](https://github.com/tw93)'s projects.

```bash
brew tap tw93/tap
```

## Migrated Formulae

[Mole](https://github.com/tw93/mole) is now distributed through Homebrew Core:

```bash
brew install mole
```

Existing `tw93/tap/mole` installations migrate to Homebrew Core during `brew update`.

## Kaku

[Kaku](https://github.com/tw93/Kaku) is now on official Homebrew. New installs should use that cask:

```bash
brew install --cask kaku
```

This tap still ships `kakuku` for people who installed Kaku before the official cask existed. Those installs keep updating from this tap, including `brew upgrade --cask tw93/tap/kakuku` and `kaku update`.

To move an existing tap install to the official cask:

```bash
brew uninstall --cask tw93/tap/kakuku
brew install --cask kaku
```

Do not install both. The tap cask conflicts with official `kaku`.

### Keep using the tap

Homebrew 6 and later require trust for non-official taps. If Homebrew reports this cask as untrusted, trust only the Kaku cask before upgrading:

```bash
brew trust --cask tw93/tap/kakuku
```

New installs using the official `kaku` cask do not need this step. See [Homebrew tap trust](https://docs.brew.sh/Tap-Trust) for details.

```bash
brew update
brew upgrade --cask tw93/tap/kakuku
```

```bash
brew uninstall --cask tw93/tap/kakuku
brew untap tw93/tap
```
