# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/relic release workflow.
class Relic < Formula
  desc "End-to-end encrypted secret layer for developers"
  homepage "https://relic.so"
  version "0.6.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-arm64.tar.gz"
      sha256 "41e4bc6f45f9b1885a5b018375b1170431dbdbda42373f80357b6ebbeeb6c8df"
    else
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-x64.tar.gz"
      sha256 "adb6f145ee7f9d0b6284abf25f5c992bb37199e4f75d64265055bbf20701ae76"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-linux-x64.tar.gz"
      sha256 "a25a03d4e3a36f70b07034aeeb76123cd7b3609474e719eb32cbf9c9a1edecba"
    end
  end

  def install
    bin.install "relic"
    lib.install Dir["librelic_runner.*"]
    lib.install Dir["relic_runner.dll"] if OS.windows?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/relic --version")
  end
end
