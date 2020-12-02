//
//  AdventOfCode2020Test.swift
//  AdventOfCode2020Test
//
//  Created by Gregori, Lars on 02.12.20.
//

import XCTest

class AdventOfCode2020Test: XCTestCase {

    func testDay1() throws {
        XCTAssertEqual(aoc1_1(fileName: "aoc1_test.txt"), 514579)
        XCTAssertEqual(aoc1_1(fileName: "aoc1.txt"), 888331)
        XCTAssertEqual(aoc1_2(fileName: "aoc1_test.txt"), 241861950)
        XCTAssertEqual(aoc1_2(fileName: "aoc1.txt"), 130933530)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
