//
//  Day15.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 15.12.20.
//

import Foundation

func aocDay15(numbers: [Int], end: Int) -> Int {

    var spoke = 0

    var spokeAt: [Int: [Int]] = [:]

    for gameCount in 0 ..< end {

        if gameCount < numbers.count {
            spoke = numbers[gameCount]

        } else {

            if let spokePrevAt = spokeAt[spoke] {
                if spokePrevAt.count == 1 {
                    spoke = gameCount - spokePrevAt[0] - 1
                } else {
                    let numPrev1 = spokePrevAt[spokePrevAt.count - 1]
                    let numPrev2 = spokePrevAt[spokePrevAt.count - 2]
                    spoke = numPrev1 - numPrev2
                }
            }
        }

        if spokeAt[spoke] != nil {
            spokeAt[spoke] = [spokeAt[spoke]!.last!, gameCount]
        } else {
            spokeAt[spoke] = [gameCount]
        }

    }

    return spoke
}
