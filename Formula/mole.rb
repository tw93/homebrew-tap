class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.17.0.tar.gz"
  sha256 "327717e53c4d61d4a2f076b3f9b8dc9f79f2d95c1bb135d38be0110e38bc6089"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos
  # Go is required for fallback building (auto-installed by Homebrew)
  depends_on "go" => :build

  # Pre-built binaries (faster installation, ~2s vs ~30s)
  resource "binaries" do
    on_arm do
      url "https://github.com/tw93/mole/releases/download/V1.16.1/binaries-darwin-arm64.tar.gz"
      sha256 "eb25d1910c956365edf2406fde41cbc64db1280d7f2ab46c25363ede08a02073"
    end

    on_intel do
      url "https://github.com/tw93/mole/releases/download/V1.16.1/binaries-darwin-amd64.tar.gz"
      sha256 "2d855d2f6fd8ba865e16dfe78842fe05682641f2871e78dccc7f514f2e4cc72d"
    end
  end

  def install
    # Detect architecture
    arch_suffix = Hardware::CPU.arm? ? "arm64" : "amd64"

    # Try to use pre-built binaries first (faster, ~2s)
    binaries_available = false
    begin
      resource("binaries").stage do
        ohai "Using pre-built binaries (#{arch_suffix})"
        (buildpath/"bin").install "analyze-darwin-#{arch_suffix}" => "analyze-go"
        (buildpath/"bin").install "status-darwin-#{arch_suffix}" => "status-go"
        binaries_available = true
      end
    rescue => e
      # Resource download failed, fallback to build
      ohai "Pre-built binaries unavailable, building from source..."
      opoo e.message if verbose?
    end

    # Fallback: build from source if binaries not available (~30s)
    unless binaries_available
      ohai "Building binaries from source using Go"
      system "go", "build", "-ldflags=-s -w", "-o", "bin/analyze-go", "./cmd/analyze"
      system "go", "build", "-ldflags=-s -w", "-o", "bin/status-go", "./cmd/status"
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
