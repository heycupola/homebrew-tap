# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "7f75b4b78572c56a0c763ddc7c55ccc217a56a7c6ef037d67db857df6a3ec1cf"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "857b575c2e6d402da0d7d7b5f140b6286071a1beded5058c672febfbd7216991"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "ff5485767a631875b5449fe160af6feb86e0c894d73c784b95915a915134209e"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "9e0022a0f4fe082889d08811d0ebf456860cedb28377d2bca418864a8bf858c1"
    end
  end

  def install
    bin.install "bin/wrapper"
    bin.install Dir["bin/wrapper-pty-helper-*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wrapper --version")
  end
end
