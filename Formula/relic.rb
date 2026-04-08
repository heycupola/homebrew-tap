# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/relic release workflow.
class Relic < Formula
  desc "End-to-end encrypted secret layer for developers"
  homepage "https://relic.so"
  version "0.8.0"
  license "MIT"
  preserve_rpath

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-arm64.tar.gz"
      sha256 "b39e7319d78e67d27bfe71048da9fa43be3fcba622ff15d98ab94477952f1b66"
    else
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-darwin-x64.tar.gz"
      sha256 "169ee0ae2533a9c81d117510933cceb77aa01a224b84f7574afd27d1bb87ce4d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/heycupola/relic/releases/download/v#{version}/relic-linux-x64.tar.gz"
      sha256 "33e3968c6ad42eff0efa180112a3cabcc7896a00ee2bae6d9139c88e5b2ad2f4"
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
