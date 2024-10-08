class TwcGo < Formula
  desc "Tiny world clock in Go!"
  homepage "https://github.com/Neved4/twc-go"
  url "https://github.com/Neved4/twc-go/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "2ada413dc14d2aede39da5dc79030260623ca91e4abbe0f5b648f700736dfec5"
  license "MIT"
  head "https://github.com/Neved4/twc-go.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "twc.go"
    bin.install_symlink "twc-go" => "twc"
    doc.install "README.md"
  end

  test do
    desired_output = "UTC  " + shell_output('date -u +"%Y-%m-%dT%H:%M:%SZ"').strip
    assert_equal desired_output, shell_output("#{bin}/twc-go -t UTC").strip
  end
end
