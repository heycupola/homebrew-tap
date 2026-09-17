# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "89dcf9175c750792b262375231cab548610618a6f610469cb8d3204ce28ce0dd"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "702f95bd6c3aa14b57e1a0bab30235771012fd9a18f3f2e24f49c2ce0ee1c721"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "1d44f56a2bc965fd207a52b56939e4c9851d189850be091b714e5bcfce5f6f28"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "54dc8da230247cc2fbe02803605679bd8dc205eb8292aa5611379ee2cacbe3e4"
    end
  end

  def install
    # Homebrew flattens a single top-level directory, so `bin/` archives
    # stage as `wrapper` + helper at the root.
    cd "bin" if File.exist?("bin/wrapper")
    bin.install "wrapper"
    helpers = Dir["wrapper-pty-helper-*"]
    odie "missing wrapper-pty-helper binary" if helpers.empty?
    bin.install helpers
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wrapper --version")
  end
end
