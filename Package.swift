import PackageDescription

let package = Package(
    name: "IPA",
    targets: [
      Target(name: "yolo", dependencies: [.Target(name: "IPA")]),
    ],
    dependencies: [
      .Package(url: "https://github.com/neonichu/Chores", majorVersion: 0),
      .Package(url: "https://github.com/kylef/Commander", majorVersion: 0),
      .Package(url: "https://github.com/kylef/PathKit", majorVersion: 0),
    ]
)
