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
  version "0.7.68"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-aarch64.tar.gz"
      sha256 "19b493bc43fb9a5cb1a187d4e33566c57ddbbdd7df62deaae363279274541ba1"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-x86_64.tar.gz"
      sha256 "5846023c3ae1b5ead075544bb7b2295f1ab59228dad6f527ff6c6531f2bf94a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-aarch64.tar.gz"
      sha256 "5234e858f997cbc0be45558b4614985b6925aa8f2b097c96390afea599536854"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-x86_64.tar.gz"
      sha256 "0d680f9aa6cdce4858a556f3601f86d74d1c27bac901958e211e39892f2d68d5"
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
