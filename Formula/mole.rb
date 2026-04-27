class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.36.2.tar.gz"
  sha256 "06551fae6a014ecf799cf700da5e420d0a55b151f757f6ad89aa0a70aa4abd98"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos

  # Pre-built binaries
  resource "binaries" do
    on_arm do
      url "https://github.com/tw93/Mole/releases/download/V1.36.2/binaries-darwin-arm64.tar.gz"
      sha256 "c2539effe2aa20889ec504243772718555ba84e54890409b92ee4a1f0d28d70f"
    end

    on_intel do
      url "https://github.com/tw93/Mole/releases/download/V1.36.2/binaries-darwin-amd64.tar.gz"
      sha256 "a62f43574cb759161686e3c7367c81be0b93e37c257453368ef395acb7e300a8"
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
