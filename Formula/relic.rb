# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/relic release workflow.
class Relic < Formula
  desc "End-to-end encrypted secret layer for developers"
  homepage "https://relic.so"
  version "0.9.2"
  license "MIT"
  preserve_rpath

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-arm64.tar.gz"
      sha256 "6c84044537fbc852cf13f0834fc05364b89e80386822c43955e177bf2e4e2e52"
    else
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-x64.tar.gz"
      sha256 "a3a6a773d38b2d08e1b3766f1f800da6ce4d5e2456a7f5b09f6165f90c48a130"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-linux-x64.tar.gz"
      sha256 "066bbb83bd8990a2abde4d4dc04640ad2698a00388b495737969e6ab2d3d3bf7"
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
