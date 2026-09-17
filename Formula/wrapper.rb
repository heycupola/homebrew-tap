# typed: false
# frozen_string_literal: true

# This formula is maintained via the heycupola/wrapper release workflow.
class Wrapper < Formula
  desc "Securely host and attach your terminal sessions across devices"
  homepage "https://www.wrapper.sh"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-arm64.tar.gz"
      sha256 "fe77304f92521c75a7b0d002b890bab8bcaf859924fc0ac542e51988bf263158"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-darwin-x86_64.tar.gz"
      sha256 "d1aeb29cfb1095b276ec1b769187673ec4192cdc3566bc6b4f00eb98911a51e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-arm64.tar.gz"
      sha256 "1e47da2897deeb13ac392640d43b4879b10513f24d012e266aee93a3dc760434"
    else
      url "https://github.com/heycupola/wrapper/releases/download/v#{version}/wrapper-linux-x86_64.tar.gz"
      sha256 "903f5946286b0492f3083647df315efb5e26192a110f32262e225f2d51122b77"
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

  def caveats
    <<~EOS
      If you previously installed with curl, $HOME/.wrapper/bin may shadow this
      Homebrew binary. `wrapper --version` then keeps reporting the curl version
      after `brew upgrade`. Re-run the curl installer, or remove $HOME/.wrapper
      and its PATH entry, then restart your shell.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wrapper --version")
  end
end
