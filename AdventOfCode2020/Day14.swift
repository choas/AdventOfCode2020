//
//  Day14.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 14.12.20.
//

import Foundation

func aocDay14Part1(fileName: String) -> Int {

    let prgs = getProgram(fileName: fileName)

    var memory = [Int](repeating: 0, count: 64 * 1024)

    prgs.forEach { prg in
        prg.mem.forEach {mem in

            let binaryPrgMem = String(mem.value, radix: 2)
            var binaryValue = ""
            var indexMask = prg.mask.count - 1
            var indexMem = binaryPrgMem.count - 1
            repeat {
                let mstr = prg.mask.str(at: indexMask)
                if mstr != "X" {
                    binaryValue = mstr + binaryValue
                } else {
                    if indexMem >= 0 {
                        binaryValue = binaryPrgMem.str(at: indexMem) + binaryValue
                    } else {
                        binaryValue = "0" + binaryValue
                    }
                }
                indexMask -= 1
                indexMem -= 1
            } while indexMask >= 0
            let value = Int(binaryValue, radix: 2)!
            memory[mem.address] = value
        }
    }

    return memory.reduce(0) {counter, vvv in
        return counter + vvv
    }
}

func aocDay14Part2(fileName: String) -> Int {

    let prgs = getProgram(fileName: fileName)

    var memory: [Double: Double] = [:]

    prgs.forEach { prg in
        prg.mem.forEach {mem in

            let (maskFloating, countFloating) = createMaskFloating(mask: prg.mask, memAddress: mem.address)

            for floatingNumber in 0 ..< Int(pow(Double(2), Double(countFloating))) {
                var binaryAddress = ""
                let binaryFloatingNumber = String(floatingNumber, radix: 2)
                var indexBinaryFloatingNumber = binaryFloatingNumber.count - 1
                var indexMaskFloating = maskFloating.count - 1
                repeat {

                    let maskFloatingChar = maskFloating.str(at: indexMaskFloating)
                    if maskFloatingChar == "X" {
                        if indexBinaryFloatingNumber >= 0 {
                            binaryAddress = binaryFloatingNumber.str(at: indexBinaryFloatingNumber) + binaryAddress
                        } else {
                            binaryAddress = "0" + binaryAddress
                        }
                        indexBinaryFloatingNumber -= 1
                    } else {
                        binaryAddress = maskFloatingChar + binaryAddress
                    }

                    indexMaskFloating -= 1
                } while indexMaskFloating >= 0

                let address36 = address36bit(binaryAddress)
                memory[address36] = Double(mem.value)
            }
        }
    }

    let sumValues: Double = memory.reduce(0) {counter, memoryItem in
        counter + memoryItem.value
    }

    print(sumValues, Int(sumValues))
    return Int(sumValues)
}

func createMaskFloating(mask: String, memAddress: Int) -> (String, Int) {

    let memAddress = String(memAddress, radix: 2)
    var maskFloating = ""
    var indexMask = mask.count - 1
    var indexMemAddress = memAddress.count - 1

    var countFloating = 0

    repeat {
        let maskChar = mask.str(at: indexMask)
        if maskChar == "1" {
            maskFloating = "1" + maskFloating
        } else if maskChar == "0" {
            if indexMemAddress >= 0 {
                maskFloating = memAddress.str(at: indexMemAddress) + maskFloating
            } else {
                maskFloating = "0" + maskFloating
            }
        } else {
            maskFloating = "X" + maskFloating
            countFloating += 1
        }
        indexMask -= 1
        indexMemAddress -= 1
    } while indexMask >= 0

    return (maskFloating, countFloating)
}

func address36bit(_ binaryAddress: String) -> Double {
    let binaryAddressPart1 = binaryAddress[0..<32]
    let binaryAddressPart2 = binaryAddress[32...]

    let addressPart1 = Double(Int(binaryAddressPart1, radix: 2)!)
    let addressPart2 = Double(Int(binaryAddressPart2, radix: 2)!)

    return Double(addressPart1 * 16) + addressPart2
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
            let memTokens = line.components(separatedBy: "[")
            let memAddressTokens = memTokens[1].components(separatedBy: "]")
            let memValueTokens = memTokens[1].components(separatedBy: " = ")
            let address = Int(memAddressTokens[0])!
            let value = Int(memValueTokens[1])!
            prg!.mem.append(Mem(address: address, value: value))
        }
    }
    prgs.append(prg!)

    return prgs
}
