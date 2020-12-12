//
//  Day11.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 11.12.20.
//

import Foundation

func aocDay11Part1(fileName: String) -> Int {
    return countOccupiedSeats(fileName: fileName, tooOccupied: 4, lookAtDirectNeighbour: true)
}

func aocDay11Part2(fileName: String) -> Int {
    return countOccupiedSeats(fileName: fileName, tooOccupied: 5, lookAtDirectNeighbour: false)
}

private func countOccupiedSeats(fileName: String, tooOccupied: Int, lookAtDirectNeighbour: Bool) -> Int {

    var nextSeats = readFerryData(fileName: fileName)

    var changed: Bool
    repeat {
        (nextSeats, changed) = next(
            ferry: nextSeats,
            tooOccupied: tooOccupied,
            lookAtDirectNeighbour: lookAtDirectNeighbour)
        // nextSeats.printSeats()
    } while changed

    return nextSeats.reduce(0) {counter, seatrow in
        return counter + seatrow.reduce(0) {counterAtRow, seat in
            return seat == .occupied ? counterAtRow + 1 : counterAtRow
        }
    }
}

private typealias Ferry = [[Seat]]

private enum Seat: String {
    case floor = "."
    case empty = "L"
    case occupied = "#"
    case unknown = "?"
}

private enum Direction: Int {
    // swiftlint:disable identifier_name
    case left, leftUp, up, rightUp, right, rightDown, down, leftDown
}

private func readFerryData(fileName: String) -> Ferry {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var ferry = Ferry(repeating: [Seat](repeating: Seat.unknown, count: lines[0].count), count: lines.count)

    for row in 0 ..< lines.count {
        ferry[row] = lines[row].map { col -> Seat in
            return Seat(rawValue: String(col))!
        }
    }

    return ferry
}

private func next(ferry: Ferry, tooOccupied: Int, lookAtDirectNeighbour: Bool) -> (Ferry, Bool) {
    var next = Ferry(repeating: [Seat](repeating: Seat.unknown, count: ferry[0].count), count: ferry.count)

    var hasSeatsChanged = false
    for row in 0 ..< ferry.count {
        for col in 0 ..< ferry[row].count {
            let seat = ferry[row][col]
            next[row][col] = seat

            if seat != .floor {
                let position = Position(row: row, col: col)
                let neighbours = countNeighbours(
                        at: position,
                        of: ferry,
                        lookAtDirectNeighbour)

                if neighbours == 0 {
                    next[row][col] = .occupied
                } else if neighbours >= tooOccupied {
                    next[row][col] = .empty
                }

                if next[row][col] != seat {
                    hasSeatsChanged = true
                }
            }
        }
    }

    return (next, hasSeatsChanged)
}

private struct Position {
    var row: Int
    var col: Int
}

private func countNeighbours(at position: Position, of ferry: Ferry, _ lookAtDirectNeighbour: Bool) -> Int {

    let row = position.row
    let col = position.col

    var rowDown = row - 1
    var rowUp   = row + 1
    var colDown = col - 1
    var colUp   = col + 1
    let neighbour = Neighbour()

    repeat {
        neighbour.seat(.left, ferry.seat(rowDown, col))
        neighbour.seat(.leftUp, ferry.seat(rowDown, colDown))
        neighbour.seat(.up, ferry.seat(row, colDown))
        neighbour.seat(.rightUp, ferry.seat(rowUp, colDown))
        neighbour.seat(.right, ferry.seat(rowUp, col))
        neighbour.seat(.rightDown, ferry.seat(rowUp, colUp))
        neighbour.seat(.down, ferry.seat(row, colUp))
        neighbour.seat(.leftDown, ferry.seat(rowDown, colUp))

        rowDown -= 1
        rowUp   += 1
        colDown -= 1
        colUp   += 1
    } while !lookAtDirectNeighbour && (rowDown >= 0 || rowUp < ferry[0].count || colDown >= 0 || colUp < ferry.count)

    return neighbour.countOccupied()
}

private class Neighbour {
    var seats: [Seat]

    init() {
        seats = [Seat](repeating: Seat.unknown, count: 8)
    }
    func seat(_ dir: Direction, _ seat: Seat) {
        let pos = dir.rawValue
        if seat != .floor && seat != .unknown && seats[pos] == .unknown {
            seats[pos] = seat
        }
    }
    func countOccupied() -> Int {
        return seats.reduce(0) { counter, seat in
            if seat == .occupied {
                return counter + 1
            }
            return counter
        }
    }
}

extension Ferry {
    fileprivate func seat(_ row: Int, _ col: Int) -> Seat {
        if row < 0 || col < 0 || row >= self[0].count || col >= self.count {
            return .unknown
        }
        return self[row][col]
    }
    func printSeats() {
        for row in 0 ..< self.count {
            var rowline = ""
            for col in 0 ..< self[row].count {
                let seat = self[row][col]
                rowline += "\(seat.rawValue)"
            }
            print(rowline)
        }
        print("----")
    }
}
