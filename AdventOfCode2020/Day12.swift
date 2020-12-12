//
//  Day12.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 12.12.20.
//

import Foundation

func aocDay12Part1(fileName: String) -> Int {

    let navs = getNavigations(fileName: fileName)

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

func aocDay12Part2(fileName: String) -> Int {

    let navs = getNavigations(fileName: fileName)

    let ship = ShipWithWaypoints(waypointsEast: 10, waypointsNorth: 1)
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

private class ShipWithWaypoints {
    var waypoints = [Int](repeating: 0, count: 4)
    var pos = [Int](repeating: 0, count: 4)

    init(waypointsEast: Int, waypointsNorth: Int) {
        self.waypoints[Direction.east.rawValue] = waypointsEast
        self.waypoints[Direction.north.rawValue] = waypointsNorth
    }

    func forward(value: Int) {
        for dir in 0 ..< 4 {
            self.pos[dir] += self.waypoints[dir] * value
        }
    }
    func move(_ direction: Direction, _ value: Int) {
        self.waypoints[direction.rawValue] += value
    }
    func turnLeft(degrees: Int) {
        let steps: Int = -degrees / 90

        var newWaypoint = [Int](repeating: 0, count: 4)

        for dir in 0 ..< 4 {
            let newDir = steps < 0 ? 4 + steps + dir : dir + steps
            newWaypoint[newDir % 4] = self.waypoints[dir]
        }
        print(self.waypoints)

        self.waypoints = newWaypoint

        print(self.waypoints)
    }
    func turnRight(degrees: Int) {
        turnLeft(degrees: -degrees)
    }
    func manhattanDistance() -> Int {
        return abs(self.pos[Direction.east.rawValue] - self.pos[Direction.west.rawValue]) +
            abs(self.pos[Direction.south.rawValue] - self.pos[Direction.north.rawValue])
    }
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
