//
//  Day9.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 09.12.20.
//

import Foundation

func aocDay9Part1(fileName: String, preambleSize: Int) -> Int {

    let codes = getCodes(fileName: fileName)

    var validIndex = preambleSize

    var isValid: Bool
    repeat {
        isValid = false
        for nnn in validIndex - preambleSize ..< validIndex {
            let num1 = codes[nnn]
            for sss in nnn ..< validIndex {
                let num2 = codes[sss]
                if num1 + num2 == codes[validIndex] {
                    isValid = true
                }
            }
        }
        validIndex += 1

    } while isValid

    return codes[validIndex - 1]
}

func aocDay9Part2(fileName: String, preambleSize: Int) -> Int {

    let codes = getCodes(fileName: fileName)

    let invalidNumber = aocDay9Part1(fileName: fileName, preambleSize: preambleSize)

    var minNum = 0
    var maxNum = 0

    for nnn in 0 ..< codes.count - 1 {
        var sum = codes[nnn]
        var sss = nnn + 1
        minNum = sum
        maxNum = sum
        repeat {
            let nuu = codes[sss]
            sum += nuu
            minNum = min(minNum, nuu)
            maxNum = max(maxNum, nuu)
            sss += 1
        } while sss < codes.count && sum < invalidNumber

        if sum == invalidNumber {
            return minNum + maxNum
        }
    }

    return 0
}

private func getCodes(fileName: String) -> [Int] {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    return lines.map {line in
        return Int(line)!
    }
}
