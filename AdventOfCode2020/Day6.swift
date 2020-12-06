//
//  Day6.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 06.12.20.
//

import Foundation

func aocDay6Part1(fileName: String) -> Int {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var count = 0
    var answers: [String: Bool] = [:]

    lines.forEach { line in
        if line.count == 0 {
            count = answers.reduce(count) {counter, answer in
                return answer.value ? counter + 1 : counter
            }
            answers = [:]
        } else {
            line.forEach { char in
                answers[String(char)] = true
            }
        }
    }
    return answers.reduce(count) {counter, answer in
        return answer.value ? counter + 1 : counter
    }
}

func aocDay6Part2(fileName: String) -> Int {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var count = 0
    var answers: [String: Int] = [:]

    var personCount = 0
    lines.forEach { line in

        if line.count == 0 {
            count = answers.reduce(count) {counter, answer in
                return answer.value == personCount ? counter + 1 : counter
            }
            answers = [:]
            personCount = 0
        } else {
            personCount += 1
            line.forEach { char in
                let answer = answers[String(char)]
                answers[String(char)] = answer != nil ? answer! + 1 : 1
            }
        }
    }
    return answers.reduce(count) {counter, answer in
        return answer.value == personCount ? counter + 1 : counter
    }
}
