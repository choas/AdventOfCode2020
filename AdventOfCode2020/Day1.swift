// SPDX-FileCopyrightText: 2020 Lars Gregori
//
// SPDX-License-Identifier: MIT

//
//  AoC1.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 01.12.20.
//

import Foundation

func aoc1_1(fileName: String) -> Int? {

    let expenseReportContainsNumber = getExpenseReportContainsNumber(fileName)

    let (index1, index2) = findPair(expenseReportContainsNumber, start: 0, end: 2020)

    return index1 * index2
}

func aoc1_2(fileName: String) -> Int? {

    let expenseReportContainsNumber = getExpenseReportContainsNumber(fileName)

    var index1 = 0
    repeat {
        if expenseReportContainsNumber[index1] {
            let start = index1 + 1
            let end = 2020 - start - index1

            let (index2, index3) = findPair(expenseReportContainsNumber, start: start, end: end)
            if index2 > 0 && index3 > 0 {
                return index1 * index2 * index3
            }
        }
        index1 += 1
    } while index1 < 2020

    return nil
}

private func getExpenseReportContainsNumber(_ fileName: String) -> [Bool] {

    guard let data = readAoC(file: fileName) else {
        return Array(repeating: false, count: 1)
    }
    let lines = data.components(separatedBy: "\n")

    var expenseReportContainsNumber = Array(repeating: false, count: 2020)

    lines.forEach { numberStr in
        let number = Int(numberStr)!
        expenseReportContainsNumber[number] = true
    }

    return expenseReportContainsNumber
}

private func findPair(_ expenseReportContainsNumber: [Bool], start: Int, end: Int) -> (Int, Int) {

    var index1 = start
    var index2 = end
    repeat {
        if expenseReportContainsNumber[index1]
            && expenseReportContainsNumber[index2] {
            return (index1, index2)
        }
        index1 += 1
        index2 -= 1
    } while index1 < index2

    return (0, 0)
}
