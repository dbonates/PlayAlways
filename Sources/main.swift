import Foundation

struct PlayAlways {

	var dateString: String {
		let date = Date()
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = "Ymd_HMS"
		return dateFormat.string(from: date)
	}

	var currentDir: String {
        return FileManager.default.currentDirectoryPath
	}

	var iOSImportHeader = "import UIKit"

	var contentHeader: String = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<playground version='1.0' sdk='iphonesimulator'>\n\t<sections>\n\t\t<code source-file-name='section-1.swift'/>\n\t</sections>\n\t<timeline fileName='timeline.xctimeline'/>\n</playground>"

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
		writeFile("section-1.swift", at: playgroundDir.path, content: iOSImportHeader) { 
			print("\n\t\u{001B}[0;32mplayground criado com sucesso.\n")
			return
		}

		print("\t\u{001B}[0;31mnão foi possível criar o playground com os parametros passados.")
	}
}

let pg = PlayAlways()
switch CommandLine.arguments.count {
	case 3:
		// create playground com nome e dir
		let playgroundName = CommandLine.arguments[1]
		let playgroundDestination = CommandLine.arguments[2]
		pg.createPlayground(fileName: playgroundName, atDestination: playgroundDestination)
	case 2:
		// only name
		let playgroundName = CommandLine.arguments[1]
		pg.createPlayground(fileName: playgroundName)
	default:
		// default name on current folder
		pg.createPlayground()
		print("\t\u{001B}[0;33mInfo:\n\t\u{001B}[0;37mPara definir um nome usar: pground nome_do_playground\n\tGerando um nome default para o playground.\n")
}

