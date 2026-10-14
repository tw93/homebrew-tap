cask "kakuku" do
  version "0.23.0"
  sha256 "caaeeaecb4f7d2760bb0db36dbd57618913d2ed3ecd70bbc6de7c77486ec1e81"

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
