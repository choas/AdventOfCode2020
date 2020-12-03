//
//  AoC2020day3.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 03.12.20.
//

import Foundation

struct Command {
    var horizontalSteps: Int // from letf to right
    var verticalSteps: Int // from top to bottom
}

func aocDay3Part1(fileName: String) -> Int {
    
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let command = Command(horizontalSteps: 3, verticalSteps: 1)
    
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
