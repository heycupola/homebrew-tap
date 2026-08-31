# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "37b75a9fe8a5b2cd927b59dafdfec8d8c65e2d73be2e5c495012b926a0946474"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "3fd8970ecd85d6a575abbf435ab5a940e90a4ee7124122f677c82a8088284b3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "9c6361a418f5704f71ebc6cf17e6ff89aa4fb0bf5bef161f8f09a3c250e952d2"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "37087fe1e7233aeafd82c763d46bfbb433ee35665e9db9878a1bece8aa934670"
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
