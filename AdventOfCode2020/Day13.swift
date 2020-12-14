//
//  Day13.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 13.12.20.
//

import Foundation

func aocDay13Part1(fileName: String) -> Int {

    let note = getNote(fileName: fileName)

    var waits = note.busIds
        .filter {busId in
            busId != nil
        }
        .map {busId in
            Wait(minutes: busId! - note.timestamp % busId!, busId: busId!)
        }
    waits.sort {
        $0.minutes < $1.minutes
    }

    return waits[0].minutes * waits[0].busId
}

private struct StartTime {
    var timestamp: Int
    var busId: Int
}

func aocDay13Part2(fileName: String) -> Int {

    let note = getNote(fileName: fileName)

    var startTimes: [StartTime] = [] // (repeating: 0, count: note.busIds.count)
    var startTime = 0

    note.busIds.forEach {busId in
        if let busId = busId {
            startTimes.append(StartTime(timestamp: startTime, busId: busId))
        }
        startTime += 1
    }

    print(startTimes)

    let stt = startTimes.reduce(startTimes[0]) {max, sta in
        return sta.busId > max.busId ? sta : max
    }

    startTimes.sort {
        $0.busId < $1.busId
    }

    print(startTimes)
    print("stt", stt)
//    for ttt in startTimes[0].busId ..< 1138800 step 1 { //000 { //00000 {
    var lll: [StartTime]
    var ttt = 0 //startTimes[2].timestamp //.busId

    var sssC = 0
    var dep: Int
    var busId: Int

    var ccc = 0

    ttt = 100000000000000

    repeat {
        ttt += stt.busId

        sssC = 0
        repeat {
            let sss = startTimes[sssC]
            busId = sss.busId
            dep = ttt + sss.timestamp - stt.timestamp
//            print(ttt, sss.timestamp, dep, busId)
            sssC += 1
            ccc += 1
            if ccc % 100000000 == 0 {
                print(".")
            }
        } while dep % busId == 0 && sssC < startTimes.count

        //print(dep % busId == 0, dep, busId, sssC < startTimes.count)
//         lll = startTimes.filter {sss in
//
//            let dep = ttt + sss.timestamp - stt.timestamp
//
//            return dep % sss.busId == 0
//        }

    } while dep % busId != 0 //&& sssC < startTimes.count
        //sssC < startTimes.count //lll.count != startTimes.count

    print("***", ttt - stt.timestamp, "->", sssC, startTimes.count) //ppp(lll))

    print(ccc)

    return 0
}

private func ppp(_ lll: [StartTime]) -> String {
    return lll.map {ttt in
        "\(ttt.busId):"
    }.joined()
}

private struct Note {
    var timestamp: Int
    var busIds: [Int?]
}

private struct Wait {
    var minutes: Int
    var busId: Int
}

private func getNote(fileName: String) -> Note {

    var lines = readAoC(file: fileName)!.components(separatedBy: "\n")

//    let lines = ["999", "17,x,13,19"]
//    lines = ["999", "1789,37,47,1889"]

//        lines = ["999", "17,x,13,19"]

    let timestamp = Int(lines[0])!
    let busIds = lines[1].components(separatedBy: ",")
        .map {busId in
            Int(busId)
        }
    return Note(timestamp: timestamp, busIds: busIds)
}
