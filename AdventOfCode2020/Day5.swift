//
//  Day5.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 05.12.20.
//

import Foundation

func aocDay5Part1(fileName: String) -> Int {

    let seats = getSeats(fileName)

    var maxSeatId = 0
    for index in 0..<seats.count where seats[index] {
        maxSeatId = max(maxSeatId, index)
    }
    return maxSeatId
}

func aocDay5Part2(fileName: String) -> Int {

    let seats = getSeats(fileName)

    var missingSeat = -1
    for index in 1..<seats.count - 1 {
        if !seats[index] && seats[index - 1] && seats[index + 1] {
            missingSeat = index
        }
    }

    return missingSeat
}

func seatIdToNumber(seatId: String) -> Int {
    let binaryString = seatId
        .replacingOccurrences(of: "F", with: "0")
        .replacingOccurrences(of: "B", with: "1")
        .replacingOccurrences(of: "L", with: "0")
        .replacingOccurrences(of: "R", with: "1")

    return Int(binaryString, radix: 2)!
}

func getSeats(_ fileName: String) -> [Bool] {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let maxSeats = calcMaxSeats(countChars: lines[0].count)
    var seats = [Bool](repeating: false, count: maxSeats )
    lines.forEach {seatId in
        let seatIdNumber = seatIdToNumber(seatId: seatId)
        seats[seatIdNumber] = true
    }

    return seats
}

func calcMaxSeats(countChars: Int) -> Int {
    return Int(pow(Double(2), Double(countChars)))
}
