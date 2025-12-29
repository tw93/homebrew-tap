class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.16.1.tar.gz"
  sha256 "ca5b3307867b282194a3237fa2ee408f6dc4ef17b71e1ade324d87c4a0ff15a5"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos
  depends_on "go" => :build

  def install
    # Build Go binaries (installed into libexec/bin)
    system "go", "build", "-ldflags=-s -w", "-o", "bin/analyze-go", "./cmd/analyze"
    system "go", "build", "-ldflags=-s -w", "-o", "bin/status-go", "./cmd/status"

    # Install all library files to libexec
    libexec.install "bin", "lib"

    # Install main executable
    # Modify SCRIPT_DIR to point to libexec
    inreplace "mole",
              'SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"',
              "SCRIPT_DIR=\"#{libexec}\""

    bin.install "mole"

    # Install mo alias (short command)
    inreplace "mo",
              'SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"',
              "SCRIPT_DIR=\"#{bin}\""

    bin.install "mo"
  end

  def caveats
    <<~EOS
      Mole is a macOS cleanup tool that requires administrative privileges for some operations.

      You can use either 'mole' or 'mo' command:
        mo                # Interactive menu
        mo clean          # System cleanup
        mo uninstall      # Remove applications
        mo analyze        # Disk space explorer

      To update Mole, use: mo update
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mole --version")
    assert_match "Mole", shell_output("#{bin}/mo --help")
  end
end
