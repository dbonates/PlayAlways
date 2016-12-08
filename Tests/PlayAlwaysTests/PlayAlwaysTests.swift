import XCTest
@testable import PlayAlways

class PlayAlwaysTests: XCTestCase {
    
    let currentDirectoryPath = FileManager.default.currentDirectoryPath
    let pg = PlayAlways(forMac: false)        

    func testGotValidDocumentPath() {
        XCTAssertEqual(pg.currentDir, currentDirectoryPath)
    }

    func testValidDateString() {
        XCTAssertFalse(pg.dateString.isEmpty, "not a valid string date")   
    }

    func testFullValidPath() {
        let writePath = URL(fileURLWithPath: pg.currentDir).appendingPathComponent(pg.dateString + ".playground") 
           XCTAssertEqual(writePath.path, currentDirectoryPath + "/" + pg.dateString + ".playground")        
    }

    static var allTests : [(String, (PlayAlwaysTests) -> () throws -> Void)] {
        return [
            ("testGotValidDocumentPath", testGotValidDocumentPath),
            ("testValidDateString", testValidDateString),
            ("testFullValidPath", testFullValidPath)
        ]
    }
}