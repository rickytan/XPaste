fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Mac

### mac certificates

```sh
[bundle exec] fastlane mac certificates
```

Download certificates and profiles

### mac build_local

```sh
[bundle exec] fastlane mac build_local
```

Build the app (no signing required for local test)

### mac build

```sh
[bundle exec] fastlane mac build
```

Build the app with signing for distribution

### mac beta

```sh
[bundle exec] fastlane mac beta
```

Build and notarize the app

### mac release

```sh
[bundle exec] fastlane mac release
```

Build, notarize and release to GitHub

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
