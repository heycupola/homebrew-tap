# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "b458e34b273ec8f9d815ccd66766461f8f4e70e01669ea2297bc694b438db9ed"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "d8e01e92c768e78e40403ce4b205212559b6165860478038527b33b1d04fdb58"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "e0125015ca436175c72665582aa17a57eefc04ed0cd5bdaf32ba169f69f6a0be"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "c82a17fa98316438ab6899f0e09b2ab340bba47167d7185c1711071f6ee64544"
    end
  end

  def install
    bin.install "wrapper"
    bin.install Dir["wrapper-pty-helper-*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wrapper --version")
  end
end
