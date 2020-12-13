//
//  Day13.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 13.12.20.
//

import Foundation

func aocDay13Part1(fileName: String) -> Int {

    let note = getNote(fileName: fileName)

    var waits = note.busIds.map {busId in
        return Wait(minutes: busId - note.timestamp % busId, busId: busId)
    }
    waits.sort {
        $0.minutes < $1.minutes
    }

    return waits[0].minutes * waits[0].busId
}

private struct Note {
    var timestamp: Int
    var busIds: [Int]
}

private struct Wait {
    var minutes: Int
    var busId: Int
}

private func getNote(fileName: String) -> Note {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let timestamp = Int(lines[0])!
    let busIds = lines[1].components(separatedBy: ",")
        .filter {busId in
            return busId != "x"
        }
        .map {busId in
            return Int(busId)!
        }
    return Note(timestamp: timestamp, busIds: busIds)
}
