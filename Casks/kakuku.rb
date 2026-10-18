cask "kakuku" do
  version "0.25.0"
  sha256 "4d37c8e3f0bb683521e55e23be087f9e0263fabdc250864d76850bcb5a357e83"

  url "https://github.com/tw93/Kaku/releases/download/V#{version}/Kaku.dmg"
  name "Kaku"
  desc "Fast, out-of-the-box terminal built for AI coding"
  homepage "https://github.com/tw93/Kaku"

  auto_updates true
  conflicts_with cask: "kaku"
  depends_on :macos

  app "Kaku.app"
  binary "#{appdir}/Kaku.app/Contents/MacOS/kaku", target: "kaku"

  zap trash: [
    "~/Library/Application Support/kaku",
    "~/Library/Caches/kaku",
    "~/Library/Preferences/fun.tw93.kaku.plist",
    "~/Library/Saved Application State/fun.tw93.kaku.savedState",
  ]

  caveats <<~EOS
    Kaku is now on official Homebrew as `kaku`. New installs should use:
      brew install --cask kaku
    This tap remains for existing `tw93/tap/kakuku` installs.
  EOS
end
