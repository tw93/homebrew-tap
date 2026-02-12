cask "kaku" do
  version "0.2.0"
  sha256 "eaf1f7e1f30795ca92c38412b17ceba18fee975c7d9eee5585359aa88ed7dc77"

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
