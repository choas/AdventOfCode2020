//
//  AoC2.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 02.12.20.
//

import Foundation

func aoc2_1(fileName: String) -> Int? {

    guard let data = readAoC(file: fileName) else {
        return -1
    }
    let lines = data.components(separatedBy: "\n")
    
    var passwordCorrectCount = 0
    
    lines.forEach{ line in
        let items = line.components(separatedBy: ":")
        let policyItems = items[0].components(separatedBy: " ")
        let atLeastAndMost = policyItems[0].components(separatedBy: "-")
        let atLeast = Int(atLeastAndMost[0])!
        let atMost = Int(atLeastAndMost[1])!
        let letter = policyItems[1]
        let password = items[1]
        
        //print(atLeast, atMost, letter, password)
        
        var count = 0
        password.forEach{ pl in
            if String(pl) == letter {
                count += 1
            }
        }
        
        // print(atLeast, atMost, letter, password, count, atLeast <= count && count <= atMost)

        if atLeast <= count && count <= atMost {
            passwordCorrectCount += 1
        }
    }
    
    return passwordCorrectCount
}


func aoc2_2(fileName: String) -> Int? {

    guard let data = readAoC(file: fileName) else {
        return -1
    }
    let lines = data.components(separatedBy: "\n")
    
    var passwordCorrectCount = 0
    
    lines.forEach{ line in
        let items = line.components(separatedBy: ":")
        let policyItems = items[0].components(separatedBy: " ")
        let atLeastAndMost = policyItems[0].components(separatedBy: "-")
        let atLeast = Int(atLeastAndMost[0])!
        let atMost = Int(atLeastAndMost[1])!
        let letter = policyItems[1]
        let password = items[1]
        
        let pos1 = atLeast
        let pos2 = atMost
        
        if pos1 >= 1 && pos2 >= 1 {
        
        let l1 = String(password[password.index(password.startIndex, offsetBy: pos1)])
        let l2 = String(password[password.index(password.startIndex, offsetBy: pos2)])

        let isLetter1 = (l1 == letter)
        let isLetter2 = (l2 == letter)
            
            if (isLetter1 || isLetter2) && (isLetter1 != isLetter2) {
                passwordCorrectCount += 1
            }
            
        }
    }
    
    return passwordCorrectCount
}
