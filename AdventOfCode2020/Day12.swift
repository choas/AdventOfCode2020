//
//  Day12.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 12.12.20.
//

import Foundation

func aocDay12Part1(fileName: String) -> Int {

    let navs = getNavigations(fileName: fileName)
    print(navs)

    let ship = Ship(direction: .east)
    navs.forEach {nav in

        switch nav.action {
        case "N":
            ship.move(.north, nav.value)
        case "S":
            ship.move(.south, nav.value)
        case "E":
            ship.move(.east, nav.value)
        case "W":
            ship.move(.west, nav.value)
        case "L":
            ship.turnLeft(degrees: nav.value)
        case "R":
            ship.turnRight(degrees: nav.value)
        case "F":
            ship.forward(value: nav.value)
        default:
            print("unknown action", nav)
        }
    }

    return ship.manhattanDistance()
}

private class Ship {
    var direction: Direction
    var pos = [Int](repeating: 0, count: 4)

    init(direction: Direction) {
        self.direction = direction
    }

    func forward(value: Int) {
        self.pos[self.direction.rawValue] += value
    }
    func move(_ direction: Direction, _ value: Int) {
        self.pos[direction.rawValue] += value
    }
    func turnLeft(degrees: Int) {
        var steps: Int = -degrees / 90
        if steps < 0 {
            steps = 4 + steps
        }
        self.direction = Direction(rawValue: (self.direction.rawValue + steps) % 4)!
        print(self.direction)
    }
    func turnRight(degrees: Int) {
        turnLeft(degrees: -degrees)
    }
    func manhattanDistance() -> Int {
        return abs(self.pos[Direction.east.rawValue] - self.pos[Direction.west.rawValue]) +
            abs(self.pos[Direction.south.rawValue] - self.pos[Direction.north.rawValue])
    }
}

private enum Direction: Int {
    case north, east, south, west
}

struct Navigation {
    var action: String
    var value: Int
}

private func getNavigations(fileName: String) -> [Navigation] {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    return lines.map {line in
        return Navigation(action: line.str(at: 0), value: Int(line[1...])!)
    }
}
