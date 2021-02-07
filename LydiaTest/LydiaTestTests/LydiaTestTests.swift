//
//  LydiaTestTests.swift
//  LydiaTestTests
//
//  Created by Yannis VERBECQUE on 02/02/2021.
//

import XCTest
@testable import LydiaTest

class LydiaTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testDownloadTenContacts() throws {
        let contactManager = ContactManager()
        XCTAssertEqual(contactManager.resquests.count, 0)
        contactManager.downloadContacts { (isCompleted: Bool) in
            if isCompleted {
                XCTAssertEqual(contactManager.resquests.count, 1)
                XCTAssertEqual(contactManager.resquests.compactMap { $0.results }.flatMap { $0 }.count, 10)
            } else {
                XCTAssertEqual(contactManager.resquests.count, 0)
            }
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            do {
            try testDownloadTenContacts()
            } catch {}
        }
    }

}
