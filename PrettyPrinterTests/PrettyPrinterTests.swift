//
//  PrettyPrinterTests.swift
//  PrettyPrinterTests
//
//  Created by Steve Baker on 5/4/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import PrettyPrinter

class PrettyPrinterTests: XCTestCase {

    func testPretty() {
        let dict: [String: Any] = ["name": "John", "age": 21]

        // call method under test
        let prettyString = PrettyPrinter.pretty(dict: dict)
        print(prettyString)

        let expected = "{\n  \"name\" : \"John\",\n  \"age\" : 21\n}"
        XCTAssertEqual(prettyString, expected)
    }

    func testPrettyFromFile() {

        // http://stackoverflow.com/questions/40985636/swift-unit-testing-async#40985721
        let expectations = expectation(description: "Wait for method to complete")

        DataManager.getDataFromFileWithSuccess(filename: "sample") { (data) -> Void in
            // success. Process data

            do {
                // Convert JSON data to Dictionary
                // Dictionary value type Any allows for NSNull
                guard let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    // couldn't parse file, not fault of method under test pretty
                    XCTFail()
                    return
                }
                let prettyString = PrettyPrinter.pretty(dict: dict)

                let expected = "{\n  \"feed\" : {\n    \"entry\" : [\n      {\n        \"im:name\" : {\n          \"label\" : null\n        }\n      }\n    ],\n    \"author\" : {\n      \"name\" : {\n        \"label\" : \"iTunes Store\"\n      },\n      \"uri\" : {\n        \"label\" : \"foo\"\n      }\n    }\n  }\n}"
                XCTAssertEqual(prettyString, expected)
                expectations.fulfill()

            } catch let error {
                print(error)
                // error, not fault of method under test pretty
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5) { error in
        }
    }
    
}
