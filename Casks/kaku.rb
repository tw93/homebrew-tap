cask "kaku" do
  version "0.2.0"
  sha256 "9dd01fac2df72578ca0ecb243cbf3c7964a6b8c9701c6eabcd57cfef70d4ec72"

  url "https://github.com/tw93/Kaku/releases/download/V#{version}/Kaku.dmg",
      verified: "github.com/tw93/Kaku/"
  name "Kaku"
  desc "Terminal emulator optimized for AI coding workflows"
  homepage "https://github.com/tw93/Kaku"

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
