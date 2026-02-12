cask "kaku" do
  version "0.2.0"
  sha256 "84111bc36e698184cdd66f84950a3ca7ad5ded6344b0a5a07d86e4b31a412670"

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
