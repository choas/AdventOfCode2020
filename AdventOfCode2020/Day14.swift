//
//  Day14.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 14.12.20.
//

import Foundation

func aocDay14Part1(fileName: String) -> Int {

    let prg = getProgram(fileName: fileName)

    var mem = [Int](repeating: 0, count: 64 * 1024)

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
        } while pppM >= 0 // && pppV >= 0
        let vvv2 = Int(bin2, radix: 2)!
        //print(bin, bin2, vvv2)
        mem[mmm.address] = vvv2
    }

    return mem.reduce(0) {counter, vvv in
        return counter + vvv
    }

//    return 0
}

private struct Mem {
    var address: Int
    var value: Int
}

private struct Program {
    var mask: String
    var mem: [Mem]
}

private func getProgram(fileName: String) -> Program {

    var lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let mask = lines[0].components(separatedBy: " = ")[1]
    var mem: [Mem] = []
    for iii in 1 ..< lines.count {
        let ttt = lines[iii].components(separatedBy: "[")
        let ttt2 = ttt[1].components(separatedBy: "]")
        let ttt3 = ttt[1].components(separatedBy: " = ")
//        print(ttt, ttt2, ttt3)
        let address = Int(ttt2[0])!
        let value = Int(ttt3[1])!
        mem.append(Mem(address: address, value: value))
    }

    return Program(mask: mask, mem: mem)
}
