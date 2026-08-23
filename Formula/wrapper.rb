# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "12fb477047b6c2ec20ce040ce06664224a7886bf0d7938b63e9d6d32955a01cd"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "765a8199104cf340ef4c14ea2a4b228cf67e2f684eb7c5980f39de2b40a9cb39"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "92765c20cee46bc4e41a12510650a13018bee07fd515615b8fba30307cfd08bb"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "0326903482d14da5041d3001546bccdc4eed3fa1689c6ffa08dba099fd745cc2"
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
