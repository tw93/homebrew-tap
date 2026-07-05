cask "kakuku" do
  version "0.13.0"
  sha256 "6660f8b74633c06a61c42529d4bba2e513ac528136a0723357d6ba976c3ae864"

  url "https://github.com/tw93/Kaku/releases/download/V#{version}/Kaku.dmg",
      verified: "github.com/tw93/Kaku/"
  name "Kaku"
  desc "A fast, out-of-the-box terminal built for AI coding"
  homepage "https://github.com/tw93/Kaku"

  conflicts_with cask: "kaku"

  auto_updates true

  app "Kaku.app"
  binary "#{appdir}/Kaku.app/Contents/MacOS/kaku", target: "kaku"

  zap trash: [
    "~/Library/Application Support/kaku",
    "~/Library/Caches/kaku",
    "~/Library/Preferences/fun.tw93.kaku.plist",
    "~/Library/Saved Application State/fun.tw93.kaku.savedState",
  ]
end
