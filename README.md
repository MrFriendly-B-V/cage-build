# Cage-Build
Makefile for building [Cage](https://github.com/Hjdskes/cage) and it's dependencies.

## Systemd service
A systemd service file is provided for use in the demo unit with Smartbathroom.
To use it without smartbathroom, remove the `After` and `Wants` lines for it.
The systemd service requires the user `cage` to exist, furthermore it requires
Firefox to be installed.