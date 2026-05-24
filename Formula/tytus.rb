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
  version "0.7.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-aarch64.tar.gz"
      sha256 "033f1b263361ddcc83b4095264b9e98f952ca116658c53d72261da48f9d0e79c"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-x86_64.tar.gz"
      sha256 "d634675383405a5e6bee705fb7111b6b63781cc6dc65654bf4d1e8ba9a22adc7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-x86_64.tar.gz"
      sha256 "292631a26924beac38ce1e4f2c1af99226cfc4f6d5cd393ba11b019d9c4f6853"
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
