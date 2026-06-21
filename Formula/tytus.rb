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
  version "0.7.69"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-aarch64.tar.gz"
      sha256 "8b82cb7cbfe1f3f03bb09623868c536f3cb3540b14123fca22f1adcb4b82a42d"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-x86_64.tar.gz"
      sha256 "eacce4a99feaf90ed2029357e6bcfa40543404ef4100856916c33ebbc758a813"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-aarch64.tar.gz"
      sha256 "3944426e5a4858f11e27586b1872224afa133b216a07d4c34f991c19bf63cfb5"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-x86_64.tar.gz"
      sha256 "a0655fb82bf67ac2474318eec4b2e6884b86553876901d5b2d36da65444a5848"
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
