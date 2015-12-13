import Commander
import IPA
import PathKit

Group {
  $0.command("do") {
  	let executablePath = Path("/Users/boris/Desktop/freedom/.build/debug/FreedomApp")
  	let temporary = try Path.processUniqueTemporary()
  	try packageExecutable(executablePath, executablePath.lastComponent, output: temporary)
  	try temporary.delete()
  }
}.run()
