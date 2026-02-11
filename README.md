# Homebrew Tap

Personal Homebrew tap for [@tw93](https://github.com/tw93)'s projects.

## Installation

```bash
brew tap tw93/tap
```

## Available Formulae

### [Mole](https://github.com/tw93/mole)

A comprehensive macOS cleanup and application uninstall tool.

```bash
brew install tw93/tap/mole
```

**Usage:**

```bash
mole              # Interactive main menu
mole clean        # System cleanup
mole uninstall    # Remove applications
mole --help       # Show help
```

## Available Casks

### [Kaku](https://github.com/tw93/Kaku)

macOS-native terminal emulator optimized for AI coding workflows.

```bash
brew install --cask tw93/tap/kaku
```

**Usage:**

```bash
kaku start
kaku update
```

## Updating

```bash
brew update
brew upgrade mole  # or any other formula
brew upgrade --cask tw93/tap/kaku
```

## Uninstalling

```bash
brew uninstall mole
brew uninstall --cask tw93/tap/kaku
brew untap tw93/tap
```
