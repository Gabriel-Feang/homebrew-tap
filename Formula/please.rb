class Please < Formula
  desc "Fast, agentic terminal assistant powered by AI"
  homepage "https://github.com/Gabriel-Feang/please"
  url "https://github.com/Gabriel-Feang/please/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "265221709b1e92376d959cee8bef1c8eaf8c553517971070076c0789445ba796"
  license "MIT"
  head "https://github.com/Gabriel-Feang/please.git", branch: "main"

  depends_on "go" => :build
  depends_on "ripgrep"
  depends_on "fd"
  depends_on "tree"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"please"
    bin.install_symlink "please" => "hmm"
    bin.install_symlink "please" => "pls"
    bin.install_symlink "please" => "plz"
  end

  def caveats
    <<~EOS
      To get started, configure your OpenRouter API key:
        please -setup

      Get your API key at: https://openrouter.ai/keys

      Usage:
        please <prompt>     Start a new conversation
        hmm <follow-up>     Continue the conversation

      New in v0.2.0:
        please -help        Show all commands and tools
        please -tools       Toggle tools on/off
        please -model       Switch AI model
        please -newtool     Create custom tools via AI
    EOS
  end

  test do
    # Test help flag works
    assert_match "agentic terminal assistant", shell_output("#{bin}/please -help")
    # Test aliases exist
    assert_predicate bin/"pls", :exist?
    assert_predicate bin/"plz", :exist?
    assert_predicate bin/"hmm", :exist?
  end
end
