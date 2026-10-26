class Indexify < Formula
  desc "Search PDF, Markdown and Word documents from your terminal"
  homepage "https://github.com/arrxy/indexify"
  url "https://github.com/arrxy/indexify/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "1f0b14d4210d5c8ec0bf7352b31b4868f451311fb729495bb184cdb2ba3033e3"
  license "MIT"

  depends_on "rust" => :build

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args, "--bin", "indexify"
  end

  test do
    (testpath/"notes.md").write("A cobalt search example.")
    system bin/"indexify",
           "--home", testpath/"library",
           testpath/"notes.md",
           "--name", "demo",
           "--no-ui"

    assert_match "cobalt",
      shell_output("#{bin}/indexify --home #{testpath}/library search demo cobalt")
  end
end
