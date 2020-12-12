//
//  Day11.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 11.12.20.
//

import Foundation

func aocDay11Part1(fileName: String) -> Int {

    var nextSeats = getSeats(fileName: fileName)

    var changed = true
    repeat {
        (nextSeats, changed) = getNextSeats(seats: nextSeats)
        // printSeats(nextSeats)
    } while changed

    return nextSeats.reduce(0) {counter, seatrow in
        return counter + seatrow.reduce(0) {counter, seat in
            return seat == Seat.ooo ? counter + 1 : counter
        }
    }
}

private func getNextSeats(seats: [[Seat]]) -> ([[Seat]], Bool) {
    var nextSeats = [[Seat]](repeating: [Seat](repeating: Seat.unknown, count: seats[0].count), count: seats.count)

    var isSeatChanged = false
    for rrr in 0 ..< seats.count {
        for ccc in 0 ..< seats[rrr].count {
            let seat = seats[rrr][ccc]
            nextSeats[rrr][ccc] = seat

            if seat != Seat.floor {
                let neighbours = getNeighbours(row: rrr, col: ccc, seats: seats)

                if neighbours == 0 {
                    nextSeats[rrr][ccc] = Seat.ooo
                } else if neighbours >= 4 {
                    nextSeats[rrr][ccc] = Seat.empty
                }

                if nextSeats[rrr][ccc] != seat {
                    isSeatChanged = true
                }

            }

        }
    }

    return (nextSeats, isSeatChanged)
}

private func printSeats(_ seats: [[Seat]]) {
    for rrr in 0 ..< seats.count {
        var rowline = ""
        for ccc in 0 ..< seats[rrr].count {
            let seat = seats[rrr][ccc]
            rowline += "\(seat.rawValue)"
        }
        print(rowline)
    }
    print("----")
}

private func getNeighbours(row: Int, col: Int, seats: [[Seat]]) -> Int {

    var count = 0
    for rrr in row - 1 ... row + 1 {
        for ccc in col - 1 ... col + 1 {

            if (rrr == row && ccc == col) ||
                (rrr < 0) || (rrr >= seats[0].count) ||
                (ccc < 0) || (ccc >= seats.count) {
                // ignore
            } else {

                if seats[rrr][ccc] == Seat.ooo {
                    count += 1
                }
            }
        }
    }
    return count
}

enum Seat: String {
    case floor = "."
    case empty = "L"
    case ooo = "#"
    case unknown = "?"
}

private func getSeats(fileName: String) -> [[Seat]] {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var seats = [[Seat]](repeating: [Seat](repeating: Seat.unknown, count: lines[0].count), count: lines.count)

    for rrr in 0 ..< lines.count {
        seats[rrr] = lines[rrr].map { ccc -> Seat in
            return Seat(rawValue: String(ccc))!
        }
    }

    return seats
}
