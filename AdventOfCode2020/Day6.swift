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

private func getAnswers(fileName: String) -> [GroupAnswer] {

    let lines = readAoC(file: fileName)!
    let groups = lines.components(separatedBy: "\n\n")

    var answers: [GroupAnswer] = []

    groups.forEach {group in

        var answersPerGroup: [String: Int] = [:]
        let answersPerPerson = group.components(separatedBy: "\n")

        answersPerPerson.forEach {answerPerPerson in

            answerPerPerson.forEach { char in
                let answer = answersPerGroup[String(char)]
                answersPerGroup[String(char)] = answer != nil ? answer! + 1 : 1
            }
        }
        answers.append(GroupAnswer(persons: answersPerPerson.count, answers: answersPerGroup))
    }

    return answers
}

private func sum(answers: [GroupAnswer], forAnyone: Bool) -> Int {
    var count = 0
    answers.forEach { answersPerGroup in
        count = answersPerGroup.answers.reduce(count) {counter, answer in
            let answerCount = answer.value
            if forAnyone {
                return answerCount > 0 ? counter + 1 : counter
            } else {
                return answerCount == answersPerGroup.persons ? counter + 1 : counter
            }
        }
    }
    return count
}
