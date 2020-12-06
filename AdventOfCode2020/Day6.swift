//
//  Day6.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 06.12.20.
//

import Foundation

func aocDay6Part1(fileName: String) -> Int {
    let answers = getAnswers(fileName: fileName)
    return sum(answers: answers, forAnyone: true)
}

func aocDay6Part2(fileName: String) -> Int {
    let answers = getAnswers(fileName: fileName)
    return sum(answers: answers, forAnyone: false)
}

struct GroupAnswer {
    var persons: Int
    var answers: [String: Int]
}

private func sum(answers: [GroupAnswer], forAnyone: Bool) -> Int {
    var count = 0
    answers.forEach { answersPerGroup in
        count = answersPerGroup.answers.reduce(count) {counter, answer in
            if forAnyone {
                return answer.value > 0 ? counter + 1 : counter
            } else {
                return answer.value == answersPerGroup.persons ? counter + 1 : counter
            }
        }
    }
    return count
}

private func getAnswers(fileName: String) -> [GroupAnswer] {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

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
