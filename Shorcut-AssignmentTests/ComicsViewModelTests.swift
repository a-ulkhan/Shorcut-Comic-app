//
//  ComicsViewModelTests.swift
//  ComicsViewModelTests
//
//  Created by Ulkhan Amiraslanov on 07.05.22.
//

import XCTest
@testable import Shorcut_Assignment
class ComicsViewModelTests: XCTestCase {
    var providerMock: ComicProviderMock!
    var sut: ComicListViewModel!

    override func setUp() {
        super.setUp()
        providerMock = ComicProviderMock()
        sut = ComicListViewModelImpl(provider: providerMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        providerMock = nil
    }

    func testLoaded() {
        let expectation = XCTestExpectation(description: "Data recieved")
        var error: String = ""
        var dataSource: ComicDataSource?
        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }

        sut.onError = { errorString in
            error = errorString
        }
        sut.getComics()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(error, "")
        XCTAssertNotNil(dataSource)
    }

    func testErrorCases() {
        var error: String = ""
        var dataSource: ComicDataSource?
        providerMock.shouldFailWith = .failedRequest
        let expectation = XCTestExpectation(description: "Data recieved")
        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }

        sut.onError = { errorString in
            expectation.fulfill()
            error = errorString
        }

        sut.getComics()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(error, NetworkError.failedRequest.errorReason)
        XCTAssertNil(dataSource)
    }

    func testNumberOfRow() {
        let expectedResult = 12
        let expectation = XCTestExpectation(description: "Data recieved")
        var dataSource: ComicDataSource?
        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }

        sut.getComics()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(dataSource)
        XCTAssertEqual(dataSource?.numberOfRows(in: 0), expectedResult)
    }

    func testNumberOfSection() {
        let expectedResult = 1
        let expectation = XCTestExpectation(description: "Data recieved")
        var dataSource: ComicDataSource?
        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }

        sut.getComics()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(dataSource)
        XCTAssertEqual(dataSource?.numberOfSection, expectedResult)
    }

    func testIfContentExist() {
        let expectation = XCTestExpectation(description: "Data recieved")
        var dataSource: ComicDataSource?

        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }
        sut.getComics()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(dataSource)
        // section 0, row 2
        var content: ComicCellModel? {
            if case .comic(let content) = dataSource?.item(at: IndexPath(row: 2, section: 0)) {
                return content
            }

            return nil
        }
        XCTAssertNotNil(content)
    }

    func testIfContentIsComic() {
        let expectation = XCTestExpectation(description: "Data recieved")
        var dataSource: ComicDataSource?
        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }

        sut.getComics()
        wait(for: [expectation], timeout: 0.1)

        var isComic: Bool {
            if case .comic = dataSource?.item(at: IndexPath(row: 2, section: 0)) {
                return true
            }
            return false
        }
        XCTAssertNotNil(dataSource)
        XCTAssertTrue(isComic)
    }

    func testRandomRowContent() {
        let expectedResult = 3
        let expectation = XCTestExpectation(description: "Data recieved")
        var dataSource: ComicDataSource?
        sut.onDataRecieved = { recievedDataSource in
            dataSource = recievedDataSource
            expectation.fulfill()
        }

        sut.getComics()
        wait(for: [expectation], timeout: 0.1)
        // section 0, row 2
        var content: ComicCellModel? {
            if case .comic(let content) = dataSource?.item(at: IndexPath(row: 2, section: 0)) {
                return content
            }
            return nil
        }
        XCTAssertNotNil(dataSource)
        XCTAssertEqual(content?.number, expectedResult)
    }
}
