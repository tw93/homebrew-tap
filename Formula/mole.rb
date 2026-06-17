class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.43.1.tar.gz"
  sha256 "352b2ca03c07d938bf2eb4a8d592ea92e25f6456499f7430d7c87102f3c83f13"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos

  # Pre-built binaries
  resource "binaries" do
    on_arm do
      url "https://github.com/tw93/Mole/releases/download/V1.43.1/binaries-darwin-arm64.tar.gz"
      sha256 "c98c34ea5b6e968ca59187b22e49ebda90e7ca7d786d8576a98e8128a82e1bd5"
    end

    on_intel do
      url "https://github.com/tw93/Mole/releases/download/V1.43.1/binaries-darwin-amd64.tar.gz"
      sha256 "a5ca0aaad301b932f99f446f0bf806308ccae5c2e75b70ccca3c7de26263bc5a"
    end
  end

  def install
    # Detect architecture
    arch_suffix = Hardware::CPU.arm? ? "arm64" : "amd64"

    # Use pre-built binaries
    resource("binaries").stage do
      ohai "Using pre-built binaries (#{arch_suffix})"
      (buildpath/"bin").install "analyze-darwin-#{arch_suffix}" => "analyze-go"
      (buildpath/"bin").install "status-darwin-#{arch_suffix}" => "status-go"
    end

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

    # Generate shell completions
    generate_completions_from_executable(bin/"mole", "completion")
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
