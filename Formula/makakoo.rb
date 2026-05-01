# Makakoo OS Homebrew formula
#
# Pinned to v0.1.4 — Homebrew Cellar-path detection fix for `makakoo
# upgrade` + docs sweep (2026-05-02). v0.1.3 was the first release
# containing the upgrade verb but classified brew installs as Unknown
# on every invocation; v0.1.4 fixes that. Update version + sha256 lines
# at each release. SHAs come from
#   gh release download <tag> --pattern '*.sha256' --output -
# in the makakoo/makakoo-os repo.
class Makakoo < Formula
  desc "Makakoo OS — autonomous cognitive extension for any AI CLI"
  homepage "https://makakoo.com"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-apple-darwin.tar.gz"
      sha256 "36fba0058c7d754d3a5b8db92158c111df86a43c6e5be1f7af5e627d95faf9d2"
    end
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-apple-darwin.tar.gz"
      sha256 "1d9d9ca3146cd170de6acea9d55ab34d1af1142a6cff987e8de6f4a170516a51"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "71053193462a41e90f1b3a5935e96a22b3f93b9ee324eca4a4fa1260ffb2802b"
    end
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e622a962247eb9ec6666929e8fe04e84cb69c9de2bcaea173183525da5ed5cc2"
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
    assert_match "makakoo 0.1.4", shell_output("#{bin}/makakoo --version")
  end
end
