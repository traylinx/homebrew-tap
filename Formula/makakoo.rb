# Makakoo OS Homebrew formula
#
# Pinned to v0.1.3 — upgrade verb + Kimi adapter (2026-05-02). Update
# version + sha256 lines at each release. SHAs come from
#   gh release download <tag> --pattern '*.sha256' --output -
# in the makakoo/makakoo-os repo.
class Makakoo < Formula
  desc "Makakoo OS — autonomous cognitive extension for any AI CLI"
  homepage "https://makakoo.com"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-apple-darwin.tar.gz"
      sha256 "191d985293a92311a6db13fef4ebe5fb01d5b7598c96a41861cbb50d258d72fe"
    end
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-apple-darwin.tar.gz"
      sha256 "fcdbcd2f86c591d3e5fc8df73c8790dbfb9c631bfa9bc3fbaef34c28a3c2d20a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af8fdd8562bbe7eccd052f8c8b712f5e0b63913938ec68c9b0cead0e5be8787c"
    end
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe15a60b4393e4bd57517abc035d7b03f5b18d5d406092a237805d76cc3cd2cc"
    end
  end

  def install
    bin.install "makakoo"
    bin.install "makakoo-mcp"
    # Bundled runtime data — the binary's resolve_distros_dir() and
    # plugins_core_root() fall back to <exe>/../share/makakoo/ which
    # under Homebrew resolves to #{prefix}/share/makakoo/ (= pkgshare).
    pkgshare.install "distros"
    pkgshare.install "plugins-core"
  end

  test do
    assert_match "makakoo 0.1.3", shell_output("#{bin}/makakoo --version")
  end
end
