# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/relic release workflow.
class Relic < Formula
  desc "End-to-end encrypted secret layer for developers"
  homepage "https://relic.so"
  version "0.7.0"
  license "MIT"
  preserve_rpath

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-arm64.tar.gz"
      sha256 "173f0d79314949040dd8b41b0dc73feb8b66579ab622998b8cdbffee70d9e227"
    else
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-x64.tar.gz"
      sha256 "c47f35a05b9f414d9aaddcb941da8786617d42c204ae37d1448ffe9e9db7caa0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-linux-x64.tar.gz"
      sha256 "78da622abd8003c8be854feca911ef258d86772722ee9f77326e7e33590cd170"
    end
  end

  def install
    bin.install Dir["relic", "libopentui.*"]
    lib.install Dir["librelic_runner.*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/relic --version")
  end
end
