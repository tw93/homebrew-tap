class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.16.1.tar.gz"
  sha256 "ca5b3307867b282194a3237fa2ee408f6dc4ef17b71e1ade324d87c4a0ff15a5"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos
  # Go is optional - only needed if pre-built binaries are unavailable
  depends_on "go" => [:optional, :build]

  # Pre-built binaries (available starting from V1.16.2)
  resource "binaries" do
    on_arm do
      url "https://github.com/tw93/mole/releases/download/V1.16.1/binaries-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # Placeholder, will be updated by workflow
    end

    on_intel do
      url "https://github.com/tw93/mole/releases/download/V1.16.1/binaries-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000" # Placeholder, will be updated by workflow
    end
  end

  def install
    # Detect architecture
    arch_suffix = Hardware::CPU.arm? ? "arm64" : "amd64"

    # Try to use pre-built binaries first (faster, no Go required)
    binaries_available = false
    begin
      resource("binaries").stage do
        ohai "Using pre-built binaries (#{arch_suffix})"
        (buildpath/"bin").install "analyze-darwin-#{arch_suffix}" => "analyze-go"
        (buildpath/"bin").install "status-darwin-#{arch_suffix}" => "status-go"
        binaries_available = true
      end
    rescue => e
      # Resource not available (e.g., old version or download failed)
      ohai "Pre-built binaries unavailable, building from source..."
      opoo e.message if verbose?
    end

    # Fallback: build from source if binaries not available
    unless binaries_available
      if which("go").nil?
        odie <<~EOS
          Go is required to build from source but was not found.
          Please install Go with: brew install go
        EOS
      end

      system "go", "build", "-ldflags=-s -w", "-o", "bin/analyze-go", "./cmd/analyze"
      system "go", "build", "-ldflags=-s -w", "-o", "bin/status-go", "./cmd/status"
      ohai "Built binaries from source using Go"
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
