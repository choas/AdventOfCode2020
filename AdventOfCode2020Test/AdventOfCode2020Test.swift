//
//  AdventOfCode2020Test.swift
//  AdventOfCode2020Test
//
//  Created by Gregori, Lars on 02.12.20.
//

import XCTest

class AdventOfCode2020Test: XCTestCase {

    func _testDay1() throws {
        XCTAssertEqual(aoc1_1(fileName: "aoc1_test.txt"), 514579)
        XCTAssertEqual(aoc1_1(fileName: "aoc1.txt"), 888331)
        XCTAssertEqual(aoc1_2(fileName: "aoc1_test.txt"), 241861950)
        XCTAssertEqual(aoc1_2(fileName: "aoc1.txt"), 130933530)
    }
    
    func _testDay2() throws {
        XCTAssertEqual(aoc2_1(fileName: "aoc2_test.txt"), 2)
        XCTAssertEqual(aoc2_1(fileName: "aoc2.txt"), 603)
        XCTAssertEqual(aoc2_2(fileName: "aoc2_test.txt"), 1)
        XCTAssertEqual(aoc2_2(fileName: "aoc2.txt"), 404)
    }
    
    func _testDay3() throws {
        XCTAssertEqual(aocDay3Part1(fileName: "aoc3_test.txt"), 7)
        XCTAssertEqual(aocDay3Part1(fileName: "aoc3.txt"), 200)
        XCTAssertEqual(aocDay3Part2(fileName: "aoc3_test.txt"), 336)
        XCTAssertEqual(aocDay3Part2(fileName: "aoc3.txt"), 3737923200)        
    }

    func testDay4() throws {
        XCTAssertEqual(aocDay4Part1(fileName: "aoc4_test.txt"), 2)
        XCTAssertEqual(aocDay4Part1(fileName: "aoc4.txt"), 192)
    }
    
}
