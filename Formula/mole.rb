class Mole < Formula
  desc "Comprehensive macOS cleanup and application uninstall tool"
  homepage "https://github.com/tw93/mole"
  url "https://github.com/tw93/Mole/archive/refs/tags/V1.16.1.tar.gz"
  sha256 "ca5b3307867b282194a3237fa2ee408f6dc4ef17b71e1ade324d87c4a0ff15a5"
  license "MIT"
  head "https://github.com/tw93/mole.git", branch: "main"

  # Requires macOS-specific features
  depends_on :macos
  # Go is optional - only needed if pre-built binaries fail to download
  depends_on "go" => [:optional, :build]

  def install
    # Detect architecture
    arch_suffix = Hardware::CPU.arm? ? "arm64" : "amd64"
    version_tag = "V#{version}"

    # Try downloading pre-built binaries first (faster and no Go required)
    download_success = true

    ["analyze", "status"].each do |bin_name|
      url = "https://github.com/tw93/mole/releases/download/#{version_tag}/#{bin_name}-darwin-#{arch_suffix}"
      target = "bin/#{bin_name}-go"

      system "mkdir", "-p", "bin"

      # Attempt download with generous timeout
      if system "curl", "-fsSL", "--connect-timeout", "10", "--max-time", "60", "-o", target, url
        # Verify downloaded file is valid (>100KB sanity check)
        if File.exist?(target) && File.size(target) > 100_000
          ohai "Downloaded pre-built #{bin_name} binary (#{arch_suffix})"
          next
        end
      end

      # Download failed - need to build from source
      download_success = false
      break
    end

    # Fallback to building from source if download failed
    unless download_success
      ohai "Pre-built binaries unavailable, building from source..."

      # Verify Go is available
      if which("go").nil?
        odie <<~EOS
          Go is required to build from source but was not found.
          Please install Go with: brew install go
          Or try again later when pre-built binaries are available.
        EOS
      end

      system "go", "build", "-ldflags=-s -w", "-o", "bin/analyze-go", "./cmd/analyze"
      system "go", "build", "-ldflags=-s -w", "-o", "bin/status-go", "./cmd/status"
      ohai "Built Go binaries from source"
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
