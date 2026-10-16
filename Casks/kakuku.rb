cask "kakuku" do
  version "0.23.1"
  sha256 "e3af3f1694c14e5083f42e7c16a494b26e4c66b720b1a336f6b6a35572080261"

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
