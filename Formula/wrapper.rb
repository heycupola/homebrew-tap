# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "dcd827d12c3eafc7e8d2bba3cd086fec0f5a9b88c156978106129680141572c5"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "14190d6a17393b0420d069ebbc50d1d3a424e999d1b2185f1944c31ff75bcdd9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "e7575c3ded0315a25c7a9fc9dc3253dab1692a106cac2303f521d71a47fc3994"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "426cbc232c73bd9d8e79da92c3c5bf7b5647a7a818e983e2cf2c9f41bbd793ba"
    end
  end

  def install
    # Homebrew flattens a single top-level directory, so `bin/` archives
    # stage as `wrapper` + helper at the root.
    cd "bin" if File.exist?("bin/wrapper")
    bin.install "wrapper"
    helpers = Dir["wrapper-pty-helper-*"]
    odie "missing wrapper-pty-helper binary" if helpers.empty?
    bin.install helpers
  end

  def caveats
    <<~EOS
      If you previously installed with curl, $HOME/.wrapper/bin may shadow this
      Homebrew binary. `wrapper --version` then keeps reporting the curl version
      after `brew upgrade`. Re-run the curl installer, or remove $HOME/.wrapper
      and its PATH entry, then restart your shell.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wrapper --version")
  end
end
