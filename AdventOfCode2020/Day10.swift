//
//  Day10.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 10.12.20.
//

import Foundation

func aocDay10Part1(fileName: String) -> Int {

    var adapters = getCodes(fileName: fileName)
    adapters.sort {
        $0 < $1
    }

    var adiff = [0, 0, 0]
    var prev = 0
    _ = adapters.map {ada in
        adiff[ada - prev - 1] += 1
        prev = ada
    }

    return adiff[0] * (adiff[2] + 1)
}

func aocDay10Part2(fileName: String) -> Int {

    return 0
}

private func getCodes(fileName: String) -> [Int] {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    return lines.map {line in
        return Int(line)!
    }
}
