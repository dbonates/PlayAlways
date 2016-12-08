import Foundation

struct PlayAlways {

	var dateString: String {
		let date = Date()
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = "Ymd_HMS"
		return dateFormat.string(from: date)
	}

	var documentsDir: String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
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

	func createPlayground() -> Bool {

		// essencial Playground structure:
		// |- folder with name.playground
	    // |-- contents.xcplayground
	    // |-- section-1.swift

		let currentDir = URL(fileURLWithPath: documentsDir).appendingPathComponent(dateString + ".playground")
		
		if createPlaygroundFolder(currentDir.path) &&
		writeFile("contents.xcplayground", at: currentDir.path, content: contentHeader) &&
		writeFile("section-1.swift", at: currentDir.path, content: iOSImportHeader) { return true }
		return false
	}
}
