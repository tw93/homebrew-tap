# Homebrew Tap

Personal Homebrew tap for [@tw93](https://github.com/tw93)'s projects.

## Installation

```bash
brew tap tw93/tap
```

## Migrated Formulae

[Mole](https://github.com/tw93/mole) is now distributed through Homebrew Core:

```bash
brew install mole
```

Existing `tw93/tap/mole` installations migrate to Homebrew Core during `brew update`.

## Available Casks

### [Kaku](https://github.com/tw93/Kaku)

macOS-native terminal emulator optimized for AI coding workflows.

```bash
brew install --cask tw93/tap/kakuku
```

**Usage:**

```bash
kaku start
kaku update
```

## Updating

```bash
brew update
brew upgrade --cask tw93/tap/kakuku
```

## Uninstalling

```bash
brew uninstall --cask tw93/tap/kakuku
brew untap tw93/tap
```
