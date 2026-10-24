class Indexify < Formula
  desc "Search PDF, Markdown and Word documents from your terminal"
  homepage "https://github.com/arrxy/indexify"
  url "https://github.com/arrxy/indexify/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5fce3650953acb12ee4a488a4f3cbb27b98f0c9e3816861e9bad073c2ae0fb13"

  # Add a license declaration matching your chosen LICENSE file.
  # For example: license "MIT"

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
