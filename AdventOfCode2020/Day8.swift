//
//  Day8.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 08.12.20.
//

import Foundation

private struct Command {
    var token: String
    var param: Int
}

func aocDay8Part1(fileName: String) -> Int {

    let prog = getProg(fileName: fileName)

    return run(prog).0
}

func aocDay8Part2(fileName: String) -> Int {

    let prog = getProg(fileName: fileName)

    for line in 0 ..< prog.count {

        var progCopy = prog
        let cmd = progCopy[line]

        if cmd.token == "jmp" {
            progCopy[line] = Command(token: "nop", param: cmd.param)
        }
        if cmd.token == "nop" {
            progCopy[line] = Command(token: "jmp", param: cmd.param)
        }
        let result = run(progCopy)
        if !result.1 {
            return result.0
        }
    }
    return 0
}

private func getProg(fileName: String) -> [Command] {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    return lines.map {line in
        let items = line.components(separatedBy: " ")
        return Command(token: items[0], param: Int(items[1])!)
    }
}

private func run(_ prog: [Command]) -> (Int, Bool) {
    var lineViewed: [Int: Bool] = [:]
    var acc = 0

    var endlessloop = false
    var line = 0
    repeat {

        let cmd = prog[line]
        lineViewed[line] = true

        switch cmd.token {

        case "nop":
            line += 1

        case "acc":
            acc += cmd.param
            line += 1

        case "jmp":
            line += cmd.param

        default:
            print("?", cmd)
        }

        endlessloop = lineViewed[line] != nil && lineViewed[line]!
    } while line < prog.count && !endlessloop

    return (acc, endlessloop)
}
