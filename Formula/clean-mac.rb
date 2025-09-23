class CleanMac < Formula
  desc "Clean Mac - Deep Clean Your Mac with One Click"
  homepage "https://github.com/tw93/clean-mac"
  url "https://github.com/tw93/clean-mac/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a579f941ab52b7605fcd6d13e816db5e0fcb292211a27f83fd7ba9b04dc24e52"
  license "MIT"
  head "https://github.com/tw93/clean-mac.git", branch: "main"

  def install
    bin.install "clean.sh" => "clean"
  end

  test do
    # Test that the script is executable and shows help
    assert_match "Clean Mac", shell_output("#{bin}/clean --help", 0)
  end

  def caveats
    <<~EOS
      Clean Mac has been installed!

      Usage:
        clean          - User-level cleanup (no password required)
        clean --system - Deep system cleanup (password required)
        clean --help   - Show help message

      For Apple Silicon Macs, the tool includes M-series specific optimizations.
    EOS
  end
end