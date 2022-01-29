//
//  JsonCoderImplTests.swift
//  TodolistMIDTests
//
//  Created by Maksim Ivanov on 29.01.2022.
//

import Combine
import XCTest
@testable import Todolist

struct TestStruct: Codable {
    let id: Int
    let name: String
}

class JsonCoderImplTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        cancellables = []
    }

    override func tearDownWithError() throws {

    }

    func test__convertToJson_and_parseFromJson__1() throws {
        let jsonCoder = JsonCoderImpl()
        let testStruct = TestStruct(id: 23, name: "XYZ")

        var error: Error?
        let expectation = self.expectation(description: "test1")

        var result: TestStruct?

        jsonCoder.convertToJson(testStruct)
            .flatMap { data in
                jsonCoder.parseFromJson(data)
            }.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            }, receiveValue: { (value: TestStruct) in
                result = value
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 9)

        XCTAssertNil(error)
        XCTAssertEqual(result!.id, testStruct.id)
        XCTAssertEqual(result!.name, testStruct.name)
    }

}
