cask "kakuku" do
  version "0.4.0"
  sha256 "36d21702c2f973d3439de0d2fecdf8690e0d26b01f1b203b77a1e9df9a761caa"

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
