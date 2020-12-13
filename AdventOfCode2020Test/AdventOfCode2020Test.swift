// SPDX-FileCopyrightText: 2020 Lars Gregori
//
// SPDX-License-Identifier: MIT

//
//  AdventOfCode2020Test.swift
//  AdventOfCode2020Test
//
//  Created by Gregori, Lars on 02.12.20.
//

import XCTest

class AdventOfCode2020Test: XCTestCase {

    func zzztestDay1() throws {
        XCTAssertEqual(aoc1_1(fileName: "aoc1_test.txt"), 514579)
        XCTAssertEqual(aoc1_1(fileName: "aoc1.txt"), 888331)
        XCTAssertEqual(aoc1_2(fileName: "aoc1_test.txt"), 241861950)
        XCTAssertEqual(aoc1_2(fileName: "aoc1.txt"), 130933530)
    }

    func zzztestDay2() throws {
        XCTAssertEqual(aoc2_1(fileName: "aoc2_test.txt"), 2)
        XCTAssertEqual(aoc2_1(fileName: "aoc2.txt"), 603)
        XCTAssertEqual(aoc2_2(fileName: "aoc2_test.txt"), 1)
        XCTAssertEqual(aoc2_2(fileName: "aoc2.txt"), 404)
    }

    func zzztestDay3() throws {
        XCTAssertEqual(aocDay3Part1(fileName: "aoc3_test.txt"), 7)
        XCTAssertEqual(aocDay3Part1(fileName: "aoc3.txt"), 200)
        XCTAssertEqual(aocDay3Part2(fileName: "aoc3_test.txt"), 336)
        XCTAssertEqual(aocDay3Part2(fileName: "aoc3.txt"), 3737923200)
    }

    func zzztestDay4() throws {
        XCTAssertEqual(aocDay4Part1(fileName: "aoc4_test.txt"), 2)
        XCTAssertEqual(aocDay4Part1(fileName: "aoc4.txt"), 192)
        XCTAssertEqual(aocDay4Part2(fileName: "aoc4_test2invalid.txt"), 0)
        XCTAssertEqual(aocDay4Part2(fileName: "aoc4_test2valid.txt"), 4)
        XCTAssertEqual(aocDay4Part2(fileName: "aoc4.txt"), 101)
    }

    func zzztestDay5() throws {
        XCTAssertEqual(seatIdToNumber(seatId: "FBFBBFFRLR"), 357)
        XCTAssertEqual(seatIdToNumber(seatId: "BFFFBBFRRR"), 567)
        XCTAssertEqual(seatIdToNumber(seatId: "FFFBBBFRRR"), 119)
        XCTAssertEqual(seatIdToNumber(seatId: "BBFFBBFRLL"), 820)
        XCTAssertEqual(aocDay5Part1(fileName: "aoc5_test.txt"), 820)
        XCTAssertEqual(aocDay5Part1(fileName: "aoc5.txt"), 801)
        XCTAssertEqual(aocDay5Part2(fileName: "aoc5.txt"), 597)
    }

    func zzztestDay6() throws {
        XCTAssertEqual(aocDay6Part1(fileName: "aoc6_test.txt"), 11)
        XCTAssertEqual(aocDay6Part1(fileName: "aoc6.txt"), 6625)
        XCTAssertEqual(aocDay6Part2(fileName: "aoc6_test.txt"), 6)
        XCTAssertEqual(aocDay6Part2(fileName: "aoc6.txt"), 3360)
    }

    func zzztestDay7() throws {
        XCTAssertEqual(aocDay7Part1(fileName: "aoc7_test.txt"), 4)
        XCTAssertEqual(aocDay7Part1(fileName: "aoc7.txt"), 348)
//        XCTAssertEqual(aocDay7Part2(fileName: "aoc7_test.txt"), 32)
//        XCTAssertEqual(aocDay7Part2(fileName: "aoc7_test_part2.txt"), 126)
    }

    func zzztestDay8() throws {
        XCTAssertEqual(aocDay8Part1(fileName: "aoc8_test.txt"), 5)
        XCTAssertEqual(aocDay8Part1(fileName: "aoc8.txt"), 1337)
        XCTAssertEqual(aocDay8Part2(fileName: "aoc8_test.txt"), 8)
        XCTAssertEqual(aocDay8Part2(fileName: "aoc8.txt"), 1358)
    }

    func zzztestDay9() throws {
        XCTAssertEqual(aocDay9Part1(fileName: "aoc9_test.txt", preambleSize: 5), 127)
        XCTAssertEqual(aocDay9Part1(fileName: "aoc9.txt", preambleSize: 25), 1124361034)
        XCTAssertEqual(aocDay9Part2(fileName: "aoc9_test.txt", preambleSize: 5), 62)
        XCTAssertEqual(aocDay9Part2(fileName: "aoc9.txt", preambleSize: 25), 129444555)
    }

    func zzztestDay10() throws {
        XCTAssertEqual(aocDay10Part1(fileName: "aoc10_test1.txt"), 35)
        XCTAssertEqual(aocDay10Part1(fileName: "aoc10_test2.txt"), 220)
        XCTAssertEqual(aocDay10Part1(fileName: "aoc10.txt"), 2470)
    }

    func zzztestDay11() throws {
        XCTAssertEqual(aocDay11Part1(fileName: "aoc11_test.txt"), 37)
        XCTAssertEqual(aocDay11Part1(fileName: "aoc11.txt"), 2476)
        XCTAssertEqual(aocDay11Part2(fileName: "aoc11_test.txt"), 26)
        //XCTAssertEqual(aocDay11Part2(fileName: "aoc11.txt"), 2257)
    }

    func zzztestDay12() throws {
        XCTAssertEqual(aocDay12Part1(fileName: "aoc12_test.txt"), 25)
        XCTAssertEqual(aocDay12Part1(fileName: "aoc12.txt"), 445)
        XCTAssertEqual(aocDay12Part2(fileName: "aoc12_test.txt"), 286)
        XCTAssertEqual(aocDay12Part2(fileName: "aoc12.txt"), 42495)
    }
    func testDay13() throws {
        XCTAssertEqual(aocDay12Part1(fileName: "aoc12_test.txt"), 25)
    }
}
