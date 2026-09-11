# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "ce9390c4ab11f9063b7cf87abc73c1fe0932fb652a9d585f9c6237e1b496c7fe"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "481147ed889aa2f0ffb0fb08774e0ec1684295abbe593dc5b307eeec719fded1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "ad64b73b09736467b925cb17bef733995a282eb8b443b070acca5de530b66ae6"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "cbe7614d13f7667c2601723e6f9e1937149ecefab8878f5aba960ca6b67523d2"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/wrapper --version")
  end
end
