//
//  Day4.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 04.12.20.
//

import Foundation

func aocDay4Part1(fileName: String) -> Int {

    let passportFields = [
        "byr": { (value: String?) -> Bool in
            return value != nil
        }, // (Birth Year)
        "iyr": { (value: String?) -> Bool in
            return value != nil
        }, // (Issue Year)
        "eyr": { (value: String?) -> Bool in
            return value != nil
        }, // (Expiration Year)
        "hgt": { (value: String?) -> Bool in
            return value != nil
        }, // (Height)
        "hcl": { (value: String?) -> Bool in
            return value != nil
        }, // (Hair Color)
        "ecl": { (value: String?) -> Bool in
            return value != nil
        }, // (Eye Color)
        "pid": { (value: String?) -> Bool in
            return value != nil
        }, // (Passport ID)
        "cid": { (value: String?) -> Bool in
            return true
        }  // (Country ID)
    ]

    return automaticPassportScanner(fileName: fileName, passportFields: passportFields)
}

func aocDay4Part2(fileName: String) -> Int {

    let passportFields = [
        "byr": { (value: String?) -> Bool in
            if let value = value, let byr = Int(value) {
                return byr >= 1920 && byr <= 2002
            }
            return false
        }, // (Birth Year)
        "iyr": { (value: String?) -> Bool in
            if let value = value, let iyr = Int(value) {
                return iyr >= 2010 && iyr <= 2020
            }
            return false
        }, // (Issue Year)
        "eyr": { (value: String?) -> Bool in
            if let value = value, let eyr = Int(value) {
                return eyr >= 2020 && eyr <= 2030
            }
            return false
        }, // (Expiration Year)
        "hgt": { (value: String?) -> Bool in
            if let value = value {
                let cmI = value.components(separatedBy: "cm")
                let inI = value.components(separatedBy: "in")

                if cmI.count == 2 {
                    let cmV = Int(cmI[0])
                    return cmV != nil && cmV! >= 150 && cmV! <= 193
                }
                if inI.count == 2 {
                    let inV = Int(inI[0])
                    return inV != nil && inV! >= 59 && inV! <= 76
                }
            }
            return false
        }, // (Height)
        "hcl": { (value: String?) -> Bool in
            if let value = value {
                let hclI = value.components(separatedBy: "#")
                if hclI.count == 2 && hclI[1].count == 6 {
                    return Int(hclI[1], radix: 16) != nil
                }
            }
            return false
        }, // (Hair Color)
        "ecl": { (value: String?) -> Bool in
            return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
        }, // (Eye Color)
        "pid": { (value: String?) -> Bool in
            if let value = value, value.count == 9 {
                return Int(value) != nil
            }
            return false
        }, // (Passport ID)
        "cid": { (value: String?) -> Bool in
            return true
        }  // (Country ID)
    ]

    return automaticPassportScanner(fileName: fileName, passportFields: passportFields)
}

func automaticPassportScanner(fileName: String, passportFields: [String: (String?) -> Bool]) -> Int {
    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    var passports: [[String: String]]  = []
    var passportData: [String: String] = [:]

    lines.forEach {line in
        if line.count == 0 {
            passports.append(passportData)
            passportData = [:]
        } else {
            line.components(separatedBy: " ").forEach { keyValue in
                let kvItems = keyValue.components(separatedBy: ":")
                passportData[kvItems[0]] = kvItems[1]
            }
        }
    }
    passports.append(passportData)

    let resultPassportScan = passports.map { passport -> Bool in

        var valid = true
        passportFields.forEach { field in
            let validate = field.value
            let fieldName = field.key
            if !validate(passport[fieldName]) {
                valid = false
            }
        }
        return valid
    }

    let countValidPassports = resultPassportScan.reduce(0) { counter, isValid in
        return isValid ? counter + 1 : counter
    }

    return countValidPassports
}
