# Makakoo OS Homebrew formula
#
# Pinned to v0.1.2 — first version-bumped release (2026-05-01). Update
# version + sha256 lines at each release. SHAs come from
#   gh release download <tag> --pattern '*.sha256' --output -
# in the makakoo/makakoo-os repo.
class Makakoo < Formula
  desc "Makakoo OS — autonomous cognitive extension for any AI CLI"
  homepage "https://makakoo.com"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-apple-darwin.tar.gz"
      sha256 "986010b9014f8819d541421e3f0df69c984b4fb90051235b1e7183d8045d6dd2"
    end
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-apple-darwin.tar.gz"
      sha256 "1305db231ecca38f83db171602e4358b82c70162c5550185e6663bfe890b0178"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6914d6c2d54f8290e77d84e3438dfce0507869686f06463d3409b69f833ccf85"
    end
    on_arm do
      url "https://github.com/makakoo/makakoo-os/releases/download/v#{version}/makakoo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "380b93387bb6b45e582b43d910312bafd1aa594b3c8535e19ea4f8338f08422c"
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
    assert_match "makakoo 0.1.2", shell_output("#{bin}/makakoo --version")
  end
end
