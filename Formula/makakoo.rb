# Makakoo OS Homebrew formula — source of truth.
#
# This file mirrors the live formula at
#   github.com/traylinx/homebrew-tap/Formula/makakoo.rb
# Bump `version` + the four `sha256` lines at each release. SHAs come
# from the .sha256 sidecar files attached to the GitHub release:
#
#   gh release download v<NEW> -R makakoo/makakoo-os \
#     --pattern '*.sha256' --output -
#
# Then mirror this file into the homebrew-tap repo (see
# `docs/RELEASING.md`). Until the live tap is bumped, brew users stay
# on the previous version.
class Makakoo < Formula
  desc "Makakoo OS — autonomous cognitive extension for any AI CLI"
  homepage "https://makakoo.com"
  version "0.1.15"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-apple-darwin.tar.gz"
      sha256 "677bef140616c1baf3c4566eb134b30b03d3b7763d589f6dadaf9bdfd3ba3c5e"
    end
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-apple-darwin.tar.gz"
      sha256 "a6cf6d2d4e61fb05344998508ad79e045fab35c070fc7c3d253172f18e3c2a98"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c3f281ef7c206889b4d271352c27220284334f8ce13662813009deeba469470"
    end
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92c833fd65adb347985c6b6a1c9ae3705d8a7688a2c19939bb66dc49e7553a9a"
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
    assert_match "makakoo 0.1.15", shell_output("#{bin}/makakoo --version")
  end
end
