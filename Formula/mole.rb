class Mole < Formula
  desc "🦡 Dig deep like a mole to clean your Mac"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/mole/archive/refs/tags/V0.1.1.tar.gz"
  sha256 "aaefd152963a4462a1f999eef675a372f4acd9af07bed59668e862867b1cca67"
  license "MIT"

  def install
    # Install main executable
    bin.install "mole"

    # Install supporting files to libexec
    libexec.install Dir["bin/*", "lib/*"]

    # Update the mole script to use the installed libexec directory
    inreplace bin/"mole",
              'SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"',
              "SCRIPT_DIR=\"#{libexec}\""
  end

  test do
    system "#{bin}/mole", "--help"
  end
end