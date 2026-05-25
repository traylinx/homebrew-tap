# Homebrew formula for Tytus CLI (template).
#
# Rendered into traylinx/homebrew-tap/Formula/tytus.rb on each release by
# .github/workflows/homebrew.yml + .github/scripts/render_homebrew_formula.py.
# Placeholders below are replaced with real values from SHA256SUMS.
#
# End-users install with:
#   brew tap traylinx/tap
#   brew install tytus
#
# Or the one-liner:
#   brew install traylinx/tap/tytus
#
# Build-from-source is NOT supported here; this formula uses the prebuilt
# binaries only. For a source build, use install.sh with TYTUS_FORCE_SOURCE=1.

class Tytus < Formula
  desc "Private AI pod CLI — connect any terminal to your isolated LLM gateway"
  homepage "https://get.traylinx.com"
  version "0.7.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-aarch64.tar.gz"
      sha256 "d00c3000de1131c1123ed1a39869ae1346f7cb5cfddde79b1edd8762edfa5e64"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-x86_64.tar.gz"
      sha256 "0a7fa51cfd2824aeb069bf094800e4efa78ca323d09b8555628cf1d1f70eafba"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-x86_64.tar.gz"
      sha256 "04e6f74d39384805f8ce6cf0463d661d16d15632306e59f1791a9ebb3663c666"
    end
  end

  def install
    bin.install "tytus"
    bin.install "tytus-mcp"
  end

  def caveats
    <<~EOS
      Tytus needs a passwordless sudoers entry to open the WireGuard tunnel
      without prompting for your password on every `tytus connect`. Run:

        sudo tee /etc/sudoers.d/tytus > /dev/null <<TYTUS
        #{ENV["USER"] || "yourusername"} ALL=(root) NOPASSWD: #{bin}/tytus tunnel-up /tmp/tytus/tunnel-*.json, #{bin}/tytus tunnel-down *
        TYTUS
        sudo chmod 440 /etc/sudoers.d/tytus

      Then run:
        tytus setup

      To enable MCP integration with Claude Code / OpenCode / Cursor:
        tytus link .
    EOS
  end

  test do
    assert_match "tytus", shell_output("#{bin}/tytus --version")
    assert_match "tytus-mcp", shell_output("#{bin}/tytus-mcp --version")
  end
end
