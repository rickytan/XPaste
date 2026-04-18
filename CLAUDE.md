# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

XPaste is a macOS Xcode Source Editor Extension that provides text transformation utilities for Xcode. It includes:
- **XPasteExtension**: Text transformations (Base64, Unicode, URL encoding, JSON to ObjC literals, string literals)
- **XSortExtension**: Import statement sorting for Objective-C and Swift
- **XPaste**: Host macOS app for enabling extensions and managing preferences

## Bundle Identifiers

- Main App: `com.xtension.xpaste`
- XPasteExtension: `com.xtension.xpaste.XPasteExtension`
- XSortExtension: `com.xtension.xpaste.XSortExtension`
- App Group: `group.com.xtension.xpaste`

## Build Commands

```bash
# Build the project
xcodebuild -workspace XPaste.xcworkspace -scheme XPaste -configuration Release build

# Build specific target
xcodebuild -workspace XPaste.xcworkspace -scheme XPasteExtension build
xcodebuild -workspace XPaste.xcworkspace -scheme XSortExtension build

# Using fastlane
bundle install              # Install Ruby dependencies
bundle exec fastlane build  # Build the app
bundle exec fastlane beta   # Build + notarize
bundle exec fastlane release # Build, notarize, upload to GitHub Releases
```

## CI/CD

GitHub Actions workflow in `.github/workflows/build.yml`:
- Triggered on push to master, PRs, and version tags (`v*`)
- Downloads certificates via fastlane match from `git@github.com:QRCodeSnap/Certificates.git`
- Builds and notarizes on tag releases
- Uploads to GitHub Releases on tag push

Required GitHub Secrets:
- `APPLE_ID`, `TEAM_ID`
- `MATCH_PASSWORD` (certificates encryption password)
- `MATCH_GIT_PRIVATE_KEY` (SSH key for cert repo)
- `APPLE_APP_SPECIFIC_PASSWORD` (for notarization)

## Architecture

### Extension Pattern
Both extensions use XcodeKit framework. Commands implement `XCSourceEditorCommand` protocol:
- `RTBaseCommand` (XPasteExtension) provides a template method pattern — subclasses override `replacementString:` to return transformed text
- Commands are registered in Info.plist under `XCSourceEditorCommandDefinitions`

### Shared Preferences
Extensions and host app share settings via `NSUserDefaults` with suite name `cn.rickytan.XPaste.defaults`.

### Import Sorting (XSortExtension)
`RTSortImportCommand` parses import statements, groups by `<>` vs `""`, sorts alphabetically, and handles `#if/#endif` blocks. Supports both Objective-C (`#import`) and Swift (`import`).

## File Organization

- `XPaste/` — Host app (AppDelegate, ViewController for preferences UI)
- `XPasteExtension/` — Text transformation commands
- `XSortExtension/` — Import sorting command
- Each extension has its own `Info.plist` defining command definitions and menu placements

## Key Files

- `XPasteExtension/RTBaseCommand.m` — Template method for all text commands
- `XPasteExtension/RTUtilities.m` — Helper functions for buffer selection
- `XSortExtension/RTSortImportCommand.m` — Import sorting logic with regex matching