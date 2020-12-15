//
//  Day15.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 15.12.20.
//

import Foundation

func aocDay15Part1(numbers: [Int]) -> Int {

    var sss: [Int] = []

    var spokeAt: [Int: [Int]] = [:]

    var ppp = 0
    for iii in 0 ..< 2020 {

        if ppp < numbers.count {
            let num = numbers[ppp]
            print(num)
            ppp += 1
            sss.append(num)
//            ssp += 1
            var sat = spokeAt[num]
            if sat == nil {
                sat = [iii]
            } else {
                sat!.append(iii)
            }
            spokeAt[num] = sat
        } else {

//            var jjj = ssp - 1
            let jjj = sss.count - 1
            var prevSpoke = sss[jjj]
            print("P", prevSpoke, spokeAt[prevSpoke], iii)

            let spp = iii - 1
            if let sat = spokeAt[prevSpoke] {
                var speek = 0
                if sat.count == 1 {
                    let speek = spp - sat[0]
                    print("Sa", speek)

                    sss.append(speek)
                    var sat = spokeAt[speek]
                    if sat == nil {
                        sat = [iii]
                    } else {
                        sat!.append(iii)
                    }
                    spokeAt[speek] = sat

                } else {
                    let numPrev1 = sat[sat.count - 1]
                    let numPrev2 = sat[sat.count - 2]
                    let speek = numPrev1 - numPrev2
                    print("Sb", speek)

                    sss.append(speek)
                    var sat = spokeAt[speek]
                    if sat == nil {
                        sat = [iii]
                    } else {
                        sat!.append(iii)
                    }
                    spokeAt[speek] = sat

                }
            }

        }

    }

    return sss[sss.count - 1]
}

private func getNumbers(fileName: String) -> [Int] {

    var numbers: [Int] = []
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    lines.forEach {line in
        line.components(separatedBy: ",").forEach {number in
            numbers.append(Int(number)!)
        }
    }

    return numbers
}
