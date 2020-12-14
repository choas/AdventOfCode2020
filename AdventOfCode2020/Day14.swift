//
//  Day14.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 14.12.20.
//

import Foundation

func aocDay14Part1(fileName: String) -> Int {

    let prgs = getProgram(fileName: fileName)

    var mem = [Int](repeating: 0, count: 64 * 1024)

    prgs.forEach { prg in
        prg.mem.forEach {mmm in

            let bin = String(mmm.value, radix: 2)
            var bin2 = ""
            var pppM = prg.mask.count - 1
            var pppV = bin.count - 1
            repeat {
                let mstr = prg.mask.str(at: pppM)
                if mstr != "X" {
                    bin2 = mstr + bin2
                } else {
                    if pppV >= 0 {
                        bin2 = bin.str(at: pppV) + bin2
                    } else {
                        bin2 = "0" + bin2
                    }
                }
                pppM -= 1
                pppV -= 1
            } while pppM >= 0
            let vvv2 = Int(bin2, radix: 2)!
            mem[mmm.address] = vvv2
        }
    }

    return mem.reduce(0) {counter, vvv in
        return counter + vvv
    }
}

private struct Mem {
    var address: Int
    var value: Int
}

private struct Program {
    var mask: String
    var mem: [Mem]
}

private func getProgram(fileName: String) -> [Program] {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var prgs: [Program] = []
    var prg: Program?

    lines.forEach {line in
        if line.starts(with: "mask") {
            if prg != nil {
                prgs.append(prg!)

            }
            let mask = line.components(separatedBy: " = ")[1]
            prg = Program(mask: mask, mem: [])
        } else {
            let ttt = line.components(separatedBy: "[")
            let ttt2 = ttt[1].components(separatedBy: "]")
            let ttt3 = ttt[1].components(separatedBy: " = ")
            let address = Int(ttt2[0])!
            let value = Int(ttt3[1])!
            prg!.mem.append(Mem(address: address, value: value))
        }
    }
    prgs.append(prg!)

    return prgs
}
