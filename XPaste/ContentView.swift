import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // App Icon
            if let appIcon = NSImage(named: "app-icon") {
                Image(nsImage: appIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
            }

            // Enable Button
            Button(action: {
                let task = Process()
                task.launchPath = "/usr/bin/open"
                task.arguments = ["-b", "com.apple.systempreferences", "/System/Library/PreferencePanes/Extensions.prefPane"]
                try? task.run()
            }) {
                Text("Enable XcodePaste")
                    .font(.headline)
            }
            .frame(width: 200, height: 40)

            // Description
            Text("Enable XcodePaste in System Settings → Extensions to use it in Xcode")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            // Bottom row: Help, Privacy, EULA
            HStack(spacing: 16) {
                Button(action: {
                    NSWorkspace.shared.open(URL(string: "https://github.com/rickytan/XPaste")!)
                }) {
                    Image(systemName: "questionmark.circle")
                        .font(.title2)
                }
                .buttonStyle(.plain)

                Button("Privacy") {
                    NSWorkspace.shared.open(URL(string: "https://xcodepaste.github.io/privacy.html")!)
                }
                .font(.caption)
                .foregroundColor(.blue)

                Button("EULA") {
                    NSWorkspace.shared.open(URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                }
                .font(.caption)
                .foregroundColor(.blue)
            }

            // Copyright
            Text("Copyright © Ricky Tan 2026")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(20)
        .frame(width: 400, height: 360)
    }
}

#Preview {
    ContentView()
}
