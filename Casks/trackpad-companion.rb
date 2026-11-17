cask "trackpad-companion" do
  version "0.9.4"
  sha256 "ca42e7fc0ef0de08488176d231d2250d3eb0dd64f8803a8f68d881e784c6abea"

  url "https://dl.bridge.guemez.net/Trackpad-Companion-#{version}.dmg"
  name "Trackpad Companion"
  desc "Bridges Precision Touchpad devices to native gesture events"
  homepage "https://github.com/gguemez/macos-trackpad-companion"

  # The same feed the app itself checks, so the cask can never advertise
  # a version that was never published.
  livecheck do
    url "https://dl.bridge.guemez.net/appcast.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # The bare symbol is the minimum, not an exact match: this is
  # LSMinimumSystemVersion 13.0 from the bundle, said in Homebrew's terms.
  depends_on macos: :ventura

  app "Trackpad Companion.app"

  # Order matters, and Homebrew applies its own: launchctl, then quit.
  # Stopping the agent first is the point — KeepAlive is
  # {SuccessfulExit = false}, so launchd would restart a process killed
  # any other way, and deleting the bundle out from under a running
  # daemon is how a machine ends up with no pointer at all: a pad on the
  # spec Input Mode path goes dormant the moment nothing drives it, and
  # macOS may be ignoring the built-in trackpad because that pad is
  # attached.
  uninstall launchctl: "net.guemez.trackpad-companion",
            quit:      "net.guemez.trackpad-companion",
            # Not zap: a LaunchAgent plist left behind points at a
            # binary that no longer exists, and launchd would go on
            # trying to run it at every login. That is machine state the
            # uninstall owns, not user data to be kept.
            trash:     "~/Library/LaunchAgents/net.guemez.trackpad-companion.plist"

  # User data, so opt-in via --zap: the config file is hand-edited and
  # comment-preserving by design.
  zap trash: [
    "~/.config/macos-trackpad-companion",
    "~/Library/Application Support/macos-trackpad-companion",
    "~/Library/Logs/macos-trackpad-companion.log",
  ]
end
