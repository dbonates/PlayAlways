import XCTest
@testable import PlayAlways

class PlayAlwaysTests: XCTestCase {
    
    let pg = PlayAlways()        

    func testGotValidDocumentPath() {
        XCTAssertEqual(pg.documentsDir, "/Users/daniel.bonates/Documents")
    }

    func testValidDateString() {
        XCTAssertFalse(pg.dateString.isEmpty, "not a valid string date")   
    }

    func testFullValidPath() {
        let writePath = URL(fileURLWithPath: pg.documentsDir).appendingPathComponent(pg.dateString + ".playground") 
           XCTAssertTrue(writePath is URL)        
    }

    func DISABLED_testShouldCreatePlayground() {
         XCTAssertTrue(pg.createPlayground()) 
    }

    static var allTests : [(String, (PlayAlwaysTests) -> () throws -> Void)] {
        return [
            ("testGotValidDocumentPath", testGotValidDocumentPath),
            ("testValidDateString", testValidDateString),
            ("testFullValidPath", testFullValidPath),
            // ("testShouldCreatePlayground", testShouldCreatePlayground)
        ]
    }
}