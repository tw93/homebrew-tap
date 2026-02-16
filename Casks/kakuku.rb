cask "kakuku" do
  version "0.3.1"
  sha256 "3bb969c07e5c48d98c17fcfe2759b3595344495b9a8ded3145361b27deb6e18c"

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
