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
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "70ec56712d55da62aab633401c14aca874e3d320cffe02b3ed2d5aa139a71b56"
    sha256 cellar: :any_skip_relocation, ventura:      "4b5e4f1947eefacf59a5eb6be37813ee2d7c58748fd1e78ff224de90ac86ed30"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10d2384bdf649a16fd24ca34f98f77e3cb567c30104761b052019763d4e0974b"
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
