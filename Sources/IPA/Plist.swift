import PathKit

private func writePlist(file: Path, _ contents: String) throws {
    let plistContents = [
"<?xml version=\"1.0\" encoding=\"UTF-8\"?>",
"<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">",
"<plist version=\"1.0\">",
"<dict>"] + [contents] + ["</dict>", "</plist>"]

    try file.write(plistContents.joinWithSeparator("\n"))
}

func writeInfoPlist(file: Path, _ productName: String, executableName: String?) throws {
    let execName = executableName ?? productName
    let contents = [
"   <key>CFBundleDevelopmentRegion</key>",
"   <string>en</string>",
"   <key>CFBundleDisplayName</key>",
"   <string>\(productName)</string>",
"   <key>CFBundleExecutable</key>",
"   <string>\(execName)</string>",
"   <key>CFBundleIdentifier</key>",
    // TODO: Make Bundle ID configurable
"   <string>org.vu0.\(productName)</string>",
"   <key>CFBundleInfoDictionaryVersion</key>",
"   <string>6.0</string>",
"   <key>CFBundleName</key>",
"   <string>\(productName)</string>",
"   <key>CFBundlePackageType</key>",
"   <string>APPL</string>",
"   <key>CFBundleShortVersionString</key>",
"   <string>1.0</string>",
"   <key>CFBundleSignature</key>",
"   <string>????</string>",
"   <key>CFBundleVersion</key>",
"   <string>1.0</string>",
"   <key>LSRequiresIPhoneOS</key>",
"   <true/>",
"   <key>UIRequiredDeviceCapabilities</key>",
"   <array>",
"       <string>armv7</string>",
"   </array>",
"   <key>UISupportedInterfaceOrientations</key>",
"   <array>",
"       <string>UIInterfaceOrientationPortrait</string>",
"       <string>UIInterfaceOrientationLandscapeLeft</string>",
"       <string>UIInterfaceOrientationLandscapeRight</string>",
"   </array>",
    // TODO: Make other Info.plist keys configurable
    ].joinWithSeparator("\n")

    try writePlist(file, contents)
}

func writeResourceRules(file: Path) throws {
    let contents = [
"        <key>rules</key>",
"        <dict>",
"                <key>.*</key>",
"                <true/>",
"                <key>Info.plist</key>",
"                <dict>",
"                        <key>omit</key>",
"                        <true/>",
"                        <key>weight</key>",
"                        <real>10</real>",
"                </dict>",
"                <key>ResourceRules.plist</key>",
"                <dict>",
"                        <key>omit</key>",
"                        <true/>",
"                        <key>weight</key>",
"                        <real>100</real>",
"                </dict>",
"        </dict>",
    ].joinWithSeparator("\n")

    try writePlist(file, contents)
}
