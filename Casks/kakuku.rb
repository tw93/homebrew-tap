cask "kakuku" do
  version "0.12.0"
  sha256 "21dd2c98c9c5b5601b2c018b5fb610a2e6580fc4c5d9f50b19189dcd6e129a22"

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
