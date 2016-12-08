import Foundation

struct PlayAlways {

	let forMac: Bool

	var dateString: String {
		let date = Date()
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = "Ymd_HMS"
		return dateFormat.string(from: date)
	}

	var currentDir: String {
        return FileManager.default.currentDirectoryPath
	}

	var importHeader: String {
		return "//: Playground - noun: a place where people can play\n\nimport \(forMac ? "Cocoa" : "UIKit")\n\nvar str = \"Hello, playground\""
	}

	var contentHeader: String {
		return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<playground version='5.0' target-platform='\(forMac ? "macos" : "ios")'>\n\t<timeline fileName='timeline.xctimeline'/>\n</playground>\n"
	}

	func createPlaygroundFolder(_ path: String)  -> Bool {

		let fileManager = FileManager.default

		do {
		    try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)

		    return true
		}
		catch let error as NSError {
			print(error)
		}

		return false
	}

	func writeFile(_ filename: String, at: String, content: String) -> Bool {

	    let destinationPath = URL(fileURLWithPath: at).appendingPathComponent(filename)
	    
	    do {
	        try content.write(to: destinationPath, atomically: true, encoding: String.Encoding.utf8)
	        return true
	    }
	    catch let error as NSError {
	        print(error)
	    }
	    
	    return false
	}

	func createPlayground(fileName: String? = nil, atDestination: String? = nil) {

		// essencial Playground structure:
		// |- folder with name.playground
	    // |-- contents.xcplayground
	    // |-- section-1.swift

	    let choosedFileName = fileName ?? dateString
	    let destinationDir = atDestination ?? currentDir

		let playgroundDir = URL(fileURLWithPath: destinationDir).appendingPathComponent(choosedFileName + ".playground")
		
		if createPlaygroundFolder(playgroundDir.path) &&
		writeFile("contents.xcplayground", at: playgroundDir.path, content: contentHeader) &&
		writeFile("Contents.swift", at: playgroundDir.path, content: importHeader) { 
			print("\n\t\u{001B}[0;32mplayground criado com sucesso. Abrindo...\n")

			let task = Process()
	        task.launchPath = "/bin/sh"
	        task.arguments = ["-c", "open \(playgroundDir.path)"]
	        task.launch()
	        task.waitUntilExit()

			return
		}

		print("\t\u{001B}[0;31mnão foi possível criar o playground com os parametros passados.")
	}
}

let forMac = CommandLine.arguments.filter { $0.hasPrefix("-")}.contains("-mac")

var fileParameters = forMac ? Array(CommandLine.arguments[2..<CommandLine.arguments.count]) : Array(CommandLine.arguments.dropFirst())

let pg = PlayAlways(forMac: forMac)

switch fileParameters.count {
	case 2:
		// create playground com nome e dir
		let playgroundName = fileParameters[0]
		let playgroundDestination = fileParameters[1]
		pg.createPlayground(fileName: playgroundName, atDestination: playgroundDestination)
	case 1:
		// only name
		let playgroundName = fileParameters[0]
		pg.createPlayground(fileName: playgroundName)
	default:
		// default name on current folder
		print("\n\tCriando um playground no diretório atual...")
		pg.createPlayground()
		print("\t\u{001B}[0;33mComo usar:\n\t\u{001B}[0;37mpground [-mac] [nome_do_playground] [destino]")
}

