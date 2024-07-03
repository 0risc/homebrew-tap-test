class TwcGo < Formula
  desc "Tiny world clock in Go!"
  homepage "https://github.com/Neved4/twc-go"
  url "https://github.com/Neved4/twc-go/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "0948a87943e57231be5afc8936be71822e4366f80ae559f4b054c390caaf5fba"
  license "MIT"
  head "https://github.com/Neved4/twc-go.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/0risc/homebrew-tap-test/releases/download/twc-go-1.1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "69a1e751953178173b3c015aab24fa51c6bf1e238f69c51a40f4373fc8321a4f"
    sha256 cellar: :any_skip_relocation, ventura:      "df6a85c11fd47adc0c96dee09f885a8ff9973f56dc535a29eed33659c6096770"
    sha256 cellar: :any_skip_relocation, monterey:     "0cd182a941f605e10ba2fd7ccc6c2e1616a0d509224e6bb07d1492cc413a13c3"
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
