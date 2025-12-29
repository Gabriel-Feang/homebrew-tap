class Please < Formula
  desc "Fast, agentic terminal assistant powered by AI"
  homepage "https://github.com/Gabriel-Feang/please"
  url "https://github.com/Gabriel-Feang/please/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "c3cb9a6a349133e5af5487abea6031917fde3e02508ce601718a47ed9ccd229f"
  license "MIT"
  head "https://github.com/Gabriel-Feang/please.git", branch: "main"

  depends_on "go" => :build
  depends_on "fd"
  depends_on "ollama"
  depends_on "ripgrep"
  depends_on "tree"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"please"
    bin.install_symlink "please" => "hmm"
    bin.install_symlink "please" => "pls"
    bin.install_symlink "please" => "plz"
  end

  def caveats
    <<~EOS
      To get started, choose your AI backend:

      Option 1: Local AI with Ollama (no API key needed)
        please -ollama

      Option 2: Cloud AI with OpenRouter
        please -setup
        Get your API key at: https://openrouter.ai/keys

      Usage:
        please <prompt>     Start a new conversation
        hmm <follow-up>     Continue the conversation

      Commands:
        please -help        Show all commands and tools
        please -tools       Toggle tools on/off
        please -model       Switch AI model
        please -ollama      Use local Ollama models
        please -openrouter  Use OpenRouter cloud models
        please -newtool     Create custom tools via AI
    EOS
  end

  test do
    # Test help flag works
    assert_match "agentic terminal assistant", shell_output("#{bin}/please -help")
    # Test aliases exist
    assert_path_exists bin/"hmm"
    assert_path_exists bin/"pls"
    assert_path_exists bin/"plz"
  end
end
