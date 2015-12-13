import Chores
import PathKit
import Regex

private extension String {
	var lines: [String] {
		return self.characters.split("\n").map(String.init)
	}
}

func availableSDKVersion(osName: String = "iOS") -> String? {
	let osRegex = Regex("\t\(osName).*")
	let versionRegex = Regex("\(osName) ([0-9]\\.[0-9])")

	let result = >["xcodebuild", "-showsdks"]
	let versions = result.stdout.lines.filter { osRegex.matches($0) }.map { 
		versionRegex.match($0)?.captures.first }.flatMap { $0 }

	return versions.first
}

func developerDirectory() -> Path {
	let result = >["xcode-select", "--print-path"]
	let developerPath = Path(result.stdout)
	assert(developerPath.exists)
	return developerPath
}

public func runExecutable(executablePath: Path) throws {
  	let temporary = try Path.processUniqueTemporary()
  	let bundlePath = try packageExecutable(executablePath, executablePath.lastComponent, output: temporary)
  	runInSimulator(bundlePath)
  	try temporary.delete()
}

public func runInSimulator(applicationBundlePath: Path, simulatorName: String = "iPhone 6") {
	let simCmd: Path = "/Library/RubyMotion/bin/ios/sim"
	assert(simCmd.exists)
	let result = >[simCmd.description, "2", "1", simulatorName, availableSDKVersion()!,
		developerDirectory().description, applicationBundlePath.description]
	print(result.stdout)
	print(result.stderr)
}
