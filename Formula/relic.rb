# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/relic release workflow.
class Relic < Formula
  desc "End-to-end encrypted secrets for developers and AI agents"
  homepage "https://withrelic.com"
  version "0.11.1"
  license "MIT"
  preserve_rpath

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-arm64.tar.gz"
      sha256 "0f634cdea2bd0217a592e1d6e868db2ddb270f4fe03f52e97ace9e5203280b98"
    else
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-x64.tar.gz"
      sha256 "9b1af6ac1a965b99b83ada901d04df9bdc3148eb495cb0a1839caa08013f1c8c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-linux-x64.tar.gz"
      sha256 "1fc41d645ec558580ae9a7f409b7adb763525a4d5ee521343def8df37ac9e0ac"
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
