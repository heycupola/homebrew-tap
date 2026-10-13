# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/relic release workflow.
class Relic < Formula
  desc "End-to-end encrypted secret layer for developers"
  homepage "https://withrelic.com"
  version "0.10.1"
  license "MIT"
  preserve_rpath

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-arm64.tar.gz"
      sha256 "44fbb4cafcdd82def9307acc17f9394109bae76ee86bb51093d56ecc47bc1a02"
    else
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-x64.tar.gz"
      sha256 "abf44e6ce73752c82fb8235d81cc11f67bcb86df151b3780ce0eeaff33876857"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-linux-x64.tar.gz"
      sha256 "9bad9b2b6449056e4de7bb51b698c1b6ca3f988f16417531c9907fdba9989621"
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
