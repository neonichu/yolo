import Spectre
@testable import IPA

func describeSim() {
	describe("Sim") {
		$0.it("can determine the currently available iOS SDK") {
			let sdkVersion = availableSDKVersion()
			try expect(sdkVersion) == "9.2"
		}

		$0.it("can determine the developer directory") {
			let devDir = developerDirectory()
			try expect(devDir) == "/Applications/Xcode-7.2.app/Contents/Developer"
		}
	}
} 