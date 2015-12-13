import Commander
import IPA
import PathKit

Group {
  $0.command("run") { (executable: String) in
  	let executablePath = Path(executable)
  	try runExecutable(executablePath)
  }
}.run()
