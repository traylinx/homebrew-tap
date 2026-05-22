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
  version "0.7.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-aarch64.tar.gz"
      sha256 "45dc1c505f78ae44405e5e74729de978a8e926e20cb953b31246ba9499ae3651"
    end
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-macos-x86_64.tar.gz"
      sha256 "bfc56b09971ec8ad6d78dddf0a87a3a37ced4094fd35b745a3f7814dc1a4fb37"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/traylinx/tytus-cli/releases/download/v#{version}/tytus-linux-x86_64.tar.gz"
      sha256 "9898dbf264e980857928a7f4224938c4d9b3f9420e7edd5a34c143754b411470"
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
