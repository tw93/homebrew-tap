class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.47.1.tar.gz"
  sha256 "5f5c8a01c67b644e7bba65a9b39d61461ab0543a2dfa9e755b54cfacdf21fa10"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos

  # Pre-built binaries
  resource "binaries" do
    on_arm do
      url "https://github.com/tw93/Mole/releases/download/V1.47.1/binaries-darwin-arm64.tar.gz"
      sha256 "d978cd07e13cc3bb8e7c729fe9eff7d12362c8656d09e7fde14d6b8ef3cfd13f"
    end

    on_intel do
      url "https://github.com/tw93/Mole/releases/download/V1.47.1/binaries-darwin-amd64.tar.gz"
      sha256 "97a0870e486ee866899c340e9575dffd8fa9c773cf68157c41fc2199be730291"
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
