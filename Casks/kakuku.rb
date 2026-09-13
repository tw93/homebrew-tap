cask "kakuku" do
  version "0.20.0"
  sha256 "5801d14ff80cf69fd59655ae9529a50ffc827f57555661bd525eb65f862df8a4"

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
end
