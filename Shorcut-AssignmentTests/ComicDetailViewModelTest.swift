//
//  ComicDetailViewModelTest.swift
//  Shorcut-AssignmentTests
//
//  Created by Ulkhan Amiraslanov on 08.05.22.
//

import XCTest
@testable import Shorcut_Assignment
class ComicDetailViewModelTest: XCTestCase {
    var sut: ComicDetailViewModel!

    override func setUp() {
        super.setUp()
        let data = ComicDetailDisplayData(title: "Title", description: "Description", imageURL: nil)
        sut = ComicDetailViewModelImpl(displayData: data)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testContent() {
        let expectedTitle = "Title"
        let expectedDescription = "Description"

        XCTAssertEqual(sut.displayData.title, expectedTitle)
        XCTAssertEqual(sut.displayData.description, expectedDescription)
        XCTAssertNil(sut.displayData.imageURL)
    }
}
