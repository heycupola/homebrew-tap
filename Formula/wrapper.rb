# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "7e56c3438e49354b54fd8ea6874e58b2bc75c2524bd56e0ce0a196f9bd065180"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "6fd546d7f9482bf85d8d2f993cd9f445c936abbda2c28dac3d90773da60b92fc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "f1475913d74f01856f6a43b6ce84a0a398c6bed4f70e0957f427b4d34f144c29"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "c1c6a767c6d14a3485f35668ddc24f97682b36cff2cad15152a10ac3024f306b"
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
