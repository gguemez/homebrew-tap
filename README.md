# gguemez/tap

Homebrew casks for my own apps.

## Trackpad Companion

Precision Touchpad gestures for macOS — a userspace bridge from a PTP HID
device to native macOS gesture events.

```
brew tap gguemez/tap
brew install --cask trackpad-companion
```

Source and issues:
<https://github.com/gguemez/macos-trackpad-companion>

### Uninstalling

```
brew uninstall --cask trackpad-companion
```

This stops the LaunchAgent *before* removing the bundle, which matters: a
Precision Touchpad on the spec Input Mode path goes dormant the moment
nothing is driving it, and macOS may be configured to ignore the built-in
trackpad while an external pointing device is attached. Removing the app
from under a running daemon can leave the machine with no pointer at all.

Add `--zap` to also remove the config file, the log, and any staged
updates.

## Notes

The cask's `version` and `sha256` are written by the app's own
`scripts/publish.sh`, from the same artifact it uploads — never by hand.
A cask edited manually is one that drifts behind the release it claims
to install.
