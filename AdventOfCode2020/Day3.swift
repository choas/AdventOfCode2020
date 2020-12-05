// SPDX-FileCopyrightText: 2020 Lars Gregori
//
// SPDX-License-Identifier: MIT

//
//  AoC2020day3.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 03.12.20.
//

import Foundation

func aocDay3Part1(fileName: String) -> Int {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let command = Command(horizontalSteps: 3, verticalSteps: 1)

    return countTrees(command, lines)
}

func aocDay3Part2(fileName: String) -> Int {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let commands = [
        Command(horizontalSteps: 1, verticalSteps: 1),
        Command(horizontalSteps: 3, verticalSteps: 1),
        Command(horizontalSteps: 5, verticalSteps: 1),
        Command(horizontalSteps: 7, verticalSteps: 1),
        Command(horizontalSteps: 1, verticalSteps: 2)
    ]
    var allfoundTrees: [Int] = []

    commands.forEach {command in
        let foundTrees = countTrees(command, lines)
        allfoundTrees.append(foundTrees)
    }
    return allfoundTrees.reduce(1, *)
}

struct Command {
    var horizontalSteps: Int // from left to right
    var verticalSteps: Int // from top to bottom
}

private func countTrees(_ command: Command, _ lines: [String]) -> Int {
    var vpos = 0
    var hpos = 0
    var foundTrees = 0

    repeat {
        vpos += command.verticalSteps
        hpos = (hpos + command.horizontalSteps) % lines[vpos].count
        let item = lines[vpos].str(at: hpos)
        if item == "#" {
            foundTrees += 1
        }
    } while vpos < (lines.count - command.verticalSteps)

    return foundTrees
}
