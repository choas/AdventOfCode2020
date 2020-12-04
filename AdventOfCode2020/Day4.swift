//
//  Day4.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 04.12.20.
//

import Foundation

func aocDay4Part1(fileName: String) -> Int {
    
    let required = 1
    let optional = 0
    
    let passportFields = [
        "byr": required, // (Birth Year)
        "iyr": required, // (Issue Year)
        "eyr": required, // (Expiration Year)
        "hgt": required, // (Height)
        "hcl": required, // (Hair Color)
        "ecl": required, // (Eye Color)
        "pid": required, // (Passport ID)
        "cid": optional  // (Country ID)
    ]
    
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")
    
    var passports: [[String:String]]  = []
    var passportData: [String:String] = [:]
    
    lines.forEach{line in
        if line.count == 0 {
            passports.append(passportData)
            passportData = [:]
        } else {
            line.components(separatedBy: " ").forEach{ kv in
                let kvItems = kv.components(separatedBy: ":")
                passportData[kvItems[0]] = kvItems[1]
            }
        }
    }
    passports.append(passportData)
    
    let resultPassportScan = passports.map{ p -> Bool in
        
        var valid = true
        passportFields.forEach{ field in
            if field.value == required && p[field.key] == nil {
                //                print(i.key)
                valid = false
            }
        }
        return valid
    }
    
    let countValidPassports = resultPassportScan.reduce(0){ counter, isValid in
        return isValid ? counter + 1 : counter
    }
    //    print(rrr, count)
    
    return countValidPassports
}
