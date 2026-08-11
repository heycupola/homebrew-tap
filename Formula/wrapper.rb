# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "505caf30f696e1e1ae50bc2c77bb1396fcb9b23e1ee873815d90870637ad7278"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "fd28627749a34ff40c21464162779885e19c031d21003121a50570cefda53599"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "12d816c32fe07f2205b13567f395718d9a23b1751b882077f497cab29f25ae12"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "2aeb581ea1585b7727af8b94d8f71b3af97b524403e150fc9f1ab2330254ff90"
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
