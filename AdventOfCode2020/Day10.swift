//
//  Day10.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 10.12.20.
//

import Foundation

func aocDay10Part1(fileName: String) -> Int {

    var adapters = getCodes(fileName: fileName)
    adapters.sort {
        $0 < $1
    }

    var adiff = [0, 0, 0]
    var prev = 0
    _ = adapters.map {ada in
        adiff[ada - prev - 1] += 1
        prev = ada
    }

    return adiff[0] * (adiff[2] + 1)
}

func aocDay10Part2(fileName: String) -> Int {

    var adapters = getCodes(fileName: fileName)
    adapters.sort {
        $0 < $1
    }

    var adiff: [Int: [Int]] = [:]
    var prev = 0
    for index in 0 ..< adapters.count {
        let ada = adapters[index]
        let aaa = ada - prev
        if adiff[aaa] == nil {
            adiff[aaa] = []
        }
        adiff[aaa]!.append(index)
        prev = ada
    }

    print(adapters)

    let ooo = adiff[1]!

    ooo.map { aaa in
        print(aaa, adapters[aaa])
    }

    var ppp = 0
    var ppp2 = 0
    for aaa in 0 ..< ooo.count {

        let vv1 = aaa > 0 ? adapters[ooo[aaa] - 1] : 0
        let vvE = ooo[aaa] + 1 < adapters.count ? adapters[ooo[aaa] + 1] : adapters[ooo[aaa]] + 3

        var vvEE: Int?
        if ooo[aaa] + 2 < adapters.count {
            vvEE = adapters[ooo[aaa] + 2]
        }

        if vvE - vv1 <= 3 {
            print(vvE, adapters[ooo[aaa]], vv1, aaa, ooo.count - aaa)
            ppp += 1 // ooo.count - aaa
            if vvEE != nil && vvEE! - vv1 <= 3 {
                ppp2 += 1
            }
        } else {
            print(">", vvE, vv1)
        }

    }
    print("ppp", ppp, ppp2, ooo.count)

    print(adiff)
    print(adiff[1]!.count)

    return 8 // adiff[0] * (adiff[2] + 1)
}

private func getCodes(fileName: String) -> [Int] {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    return lines.map {line in
        return Int(line)!
    }
}
