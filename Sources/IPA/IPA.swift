import Chores
import PathKit

enum Errors: ErrorType {
	case PlistBuddyFailed(message: String)
}

private let PLIST_BUDDY = "/usr/libexec/PlistBuddy"

private func bundleSignature(plistPath: Path) throws -> String {
	let result = >[PLIST_BUDDY, "-c", "Print CFBundleSignature", plistPath.description]
	if result.result != 0 {
		// FIXME: Passing the error leads to a SIG11 sometimes, bug in Chores?
		throw Errors.PlistBuddyFailed(message: result.stderr)
	}
	return result.stdout
}

private func prepareDestination(source: Path, _ destination: Path) throws -> Path { 
	var actualDestination = destination
	if destination.isDirectory {
		actualDestination = destination + source.lastComponent
	}

	if actualDestination.exists {
		try actualDestination.delete()
	}

	return actualDestination
}

private func copy(source: Path, _ destination: Path) throws {
	try source.copy(prepareDestination(source, destination))
}

private func move(source: Path, _ destination: Path) throws -> Path {
	let destination = try prepareDestination(source, destination)
	try source.move(destination)
	return destination
}

public func packageExecutable(executable: Path, _ productName: String, output: Path = ".") throws {
	let bundlePath = output + Path("\(productName).app")
	let plistPath = Path("\(productName)-Info.plist")

	if !bundlePath.exists || !bundlePath.isDirectory {
		try bundlePath.mkdir()	
	}

	try writeInfoPlist(plistPath, productName, executableName: executable.lastComponent)
	
	let signature = try bundleSignature(plistPath)
	try (bundlePath + "PkgInfo").write("AAPL\(signature)\n")

	try copy(executable, bundlePath)

	let destination = try move(plistPath, bundlePath + "Info.plist")
	>["plutil", "-convert", "binary1", destination.description]
}
