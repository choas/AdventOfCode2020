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
        for firstNumberIndex in validIndex - preambleSize ..< validIndex {
            let firstNumber = codes[firstNumberIndex]
            for secondNumberIndex in firstNumberIndex ..< validIndex {
                let secondNumber = codes[secondNumberIndex]
                if firstNumber + secondNumber == codes[validIndex] {
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

    for startIndex in 0 ..< codes.count - 1 {
        let firstNumber = codes[startIndex]
        var sum = firstNumber
        minNum = firstNumber
        maxNum = firstNumber

        var secondIndex = startIndex + 1

        repeat {
            let nextNumber = codes[secondIndex]
            sum += nextNumber
            minNum = min(minNum, nextNumber)
            maxNum = max(maxNum, nextNumber)
            secondIndex += 1
        } while secondIndex < codes.count && sum < invalidNumber

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
