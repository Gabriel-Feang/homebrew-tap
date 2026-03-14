class Tune < Formula
  desc "AI-powered command output filter for coding agents"
  homepage "https://github.com/partitura-ai/tune"
  version "1.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/partitura-ai/tune/releases/download/v1.4.0/tune-darwin-arm64.tar.gz"
      sha256 "36f2b3f61de24b832b2d7a147daf2ebe93171815f6767614e0dd477aecb8c809"

      def install
        bin.install "tune-darwin-arm64" => "tune"
      end
    else
      url "https://github.com/partitura-ai/tune/releases/download/v1.4.0/tune-darwin-amd64.tar.gz"
      sha256 "e2abf5d0946037b3aa569b50a445805fb55788fc88628335232dba7715913774"

      def install
        bin.install "tune-darwin-amd64" => "tune"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/partitura-ai/tune/releases/download/v1.4.0/tune-linux-arm64.tar.gz"
      sha256 "e3ed010fed9c0d1d652fd8a48639096aff2d880d1ae3edb09dac3685baab62dc"

      def install
        bin.install "tune-linux-arm64" => "tune"
      end
    else
      url "https://github.com/partitura-ai/tune/releases/download/v1.4.0/tune-linux-amd64.tar.gz"
      sha256 "82f3cbb29c7d9b9aa54f656c81ca69a909a66ecf503ffaada79422dd1ce92e6c"

      def install
        bin.install "tune-linux-amd64" => "tune"
      end
    end
  end

  def caveats
    <<~EOS
      To get started:

        tune config                 # Interactive setup
        tune add go git npm         # Register commands to filter
        eval "$(tune init)"         # Activate in current shell

      Add to your shell profile for persistence:
        echo 'eval "$(tune init)"' >> ~/.zshrc

      Set your API key:
        tune config apikey <key>    # Or set OPENROUTER_API_KEY env var
    EOS
  end

  test do
    assert_match "tune 1.4.0", shell_output("#{bin}/tune --version")
  end
end
