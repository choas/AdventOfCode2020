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
    
    readDatabase(lines){ atLeast, atMost, letter, password in
        
        var count = 0
        password.forEach{ passwordLetter in
            if String(passwordLetter) == letter {
                count += 1
            }
        }
        
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
    
    readDatabase(lines) { pos1, pos2, letter, password in
        
        if pos1 >= 1 && pos2 >= 1 {
            
            let passwordLetterOne = password.str(at: pos1)
            let passwordLetterTwo = password.str(at: pos2)
            
            let isLetterOne = (passwordLetterOne == letter)
            let isLetterTwo = (passwordLetterTwo == letter)
            
            if exactlyOne(isLetterOne, isLetterTwo) {
                passwordCorrectCount += 1
            }
        }
    }
    
    return passwordCorrectCount
}


func readDatabase(_ lines: [String], completion: @escaping (Int, Int, String, String) -> Void) {
    
    lines.forEach{ line in
        let items = line.components(separatedBy: ":")
        let policyItems = items[0].components(separatedBy: " ")
        let atLeastAndMost = policyItems[0].components(separatedBy: "-")
        let firstNumber = Int(atLeastAndMost[0])!
        let secondNumber = Int(atLeastAndMost[1])!
        let letter = policyItems[1]
        let password = items[1]

        completion(firstNumber, secondNumber, letter, password)
    }
}

func exactlyOne(_ isLetterOne: Bool, _ isLetterTwo: Bool) -> Bool {
    return ((isLetterOne || isLetterTwo) && (isLetterOne != isLetterTwo))
}

