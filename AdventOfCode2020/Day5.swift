//
//  Day5.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 05.12.20.
//

import Foundation

func aocDay5Part1(fileName: String) -> Int {
    
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")
    
    var maxSeatId = 0
    lines.forEach{seatId in
        let seatIdNumber = seatIdToNumber(seatId: seatId)
        maxSeatId = max(maxSeatId, seatIdNumber)
    }
    return maxSeatId
}

func seatIdToNumber(seatId: String) -> Int {
    let b = seatId
        .replacingOccurrences(of: "F", with: "0")
        .replacingOccurrences(of: "B", with: "1")
        .replacingOccurrences(of: "L", with: "0")
        .replacingOccurrences(of: "R", with: "1")
    
    return Int(b, radix: 2)!
}
