//
//  BhagavadGitaTests.swift
//  BhagavadGitaTests
//
//  Created by Hari on 12/9/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

import XCTest

class BhagavadGitaTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //    func testExample() {
    //        // This is an example of a functional test case.
    //        XCTAssert(true, "Pass")
    //    }
    //
    //    func testPerformanceExample() {
    //        // This is an example of a performance test case.
    //        self.measureBlock() {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    //
    func testJSONFileReader() {
        let json = JSONFileReader.read(fromFile: "gita")
        XCTAssert(json != nil)
    }

    func testGitaBookTitle() {
        let book = Book.load()
        XCTAssert(book.bookTitle == "ശ്രീമദ് ഭഗവദ്ഗീത", "Book title is not the expected value")
    }

    func testGitaBookChapters() {
        let book = Book.load()
        XCTAssert(book.chapters.count == 20, "Number of chapters on the JSON is not correct")
    }

    func testGitaBookChaptersSections() {
        let book = Book.load()
        XCTAssert(book.chapters[0].sections.count == 8, "Number of sections in Chapter 1 on the JSON is not correct")
        XCTAssert(book.chapters[1].sections.count == 8, "Number of sections in Chapter 2 on the JSON is not correct")
        XCTAssert(book.chapters[2].sections.count == 35, "Number of sections in Chapter 3 on the JSON is not correct")
        XCTAssert(book.chapters[3].sections.count == 69, "Number of sections in Chapter 4 on the JSON is not correct")
        XCTAssert(book.chapters[4].sections.count == 43, "Number of sections in Chapter 5 on the JSON is not correct")
        XCTAssert(book.chapters[5].sections.count == 42, "Number of sections in Chapter 6 on the JSON is not correct")
        XCTAssert(book.chapters[6].sections.count == 27, "Number of sections in Chapter 7 on the JSON is not correct")
        XCTAssert(book.chapters[7].sections.count == 40, "Number of sections in Chapter 8 on the JSON is not correct")
        XCTAssert(book.chapters[8].sections.count == 30, "Number of sections in Chapter 9 on the JSON is not correct")
        XCTAssert(book.chapters[9].sections.count == 26, "Number of sections in Chapter 10 on the JSON is not correct")
        XCTAssert(book.chapters[10].sections.count == 33, "Number of sections in Chapter 11 on the JSON is not correct")
        XCTAssert(book.chapters[11].sections.count == 38, "Number of sections in Chapter 12 on the JSON is not correct")
        XCTAssert(book.chapters[12].sections.count == 52, "Number of sections in Chapter 13 on the JSON is not correct")
        XCTAssert(book.chapters[13].sections.count == 16, "Number of sections in Chapter 14 on the JSON is not correct")
        XCTAssert(book.chapters[14].sections.count == 28, "Number of sections in Chapter 15 on the JSON is not correct")
        XCTAssert(book.chapters[15].sections.count == 24, "Number of sections in Chapter 16 on the JSON is not correct")
        XCTAssert(book.chapters[16].sections.count == 19, "Number of sections in Chapter 17 on the JSON is not correct")
        XCTAssert(book.chapters[17].sections.count == 18, "Number of sections in Chapter 18 on the JSON is not correct")
        XCTAssert(book.chapters[18].sections.count == 27, "Number of sections in Chapter 19 on the JSON is not correct")
        XCTAssert(book.chapters[19].sections.count == 75, "Number of sections in Chapter 20 on the JSON is not correct")
    }
    
}
