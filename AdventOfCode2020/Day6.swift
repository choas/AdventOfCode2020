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
    let answers = getAnswers(lines)

    answers.forEach { answerGroup in
        count = answerGroup.answers.reduce(count) {counter, answer in
            return answer.value > 0 ? counter + 1 : counter
        }
    }

    return count
}

func aocDay6Part2(fileName: String) -> Int {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var count = 0
    let answers = getAnswers(lines)

    answers.forEach { answerPerGroup in
        count = answerPerGroup.answers.reduce(count) {counter, answer in
            return answer.value == answerPerGroup.persons ? counter + 1 : counter
        }
    }

    return count
}

struct GroupAnswer {
    var persons: Int
    var answers: [String: Int]
}

private func getAnswers(_ lines: [String]) -> [GroupAnswer] {

    var answers: [GroupAnswer] = []
    var answersPerGroup: [String: Int] = [:]
    var personCount = 0

    lines.forEach { line in
        if line.count == 0 {
            answers.append(GroupAnswer(persons: personCount, answers: answersPerGroup))
            answersPerGroup = [:]
            personCount = 0
        } else {
            personCount += 1
            line.forEach { char in
                let answer = answersPerGroup[String(char)]
                answersPerGroup[String(char)] = answer != nil ? answer! + 1 : 1
            }
        }
    }
    answers.append(GroupAnswer(persons: personCount, answers: answersPerGroup))

    return answers
}
