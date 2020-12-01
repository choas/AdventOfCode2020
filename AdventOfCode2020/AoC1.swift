//
//  AoC1_1.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 01.12.20.
//

import Foundation

func aoc1_1() -> String {
    
    guard let data = read(file: "aoc1.txt") else {
        return "ERROR"
    }
    let lines = data.split(separator: "\n")
    
    var expenseReportContainsNumber = Array(repeating: false, count: 2020)
    
    lines.forEach{ numberStr in
        let number = Int(numberStr)!
        expenseReportContainsNumber[number] = true;
    }
    
    var result: String?
    var index = 0
    repeat {
        if expenseReportContainsNumber[index] && expenseReportContainsNumber[2020 - index] {
            result = "\(index * (2020 - index))"
        }
        index += 1
    } while index < 2020/2 && result == nil
    
    return result ?? "?"
}

func aoc1_2() -> String {
    
    guard let data = read(file: "aoc1.txt") else {
        return "ERROR"
    }
    let lines = data.split(separator: "\n")
    
    var expenseReportContainsNumber = Array(repeating: false, count: 2020)
    
    lines.forEach{ numberStr in
        let number = Int(numberStr)!
        expenseReportContainsNumber[number] = true;
    }
    
    var result: String?
    var index1 = 0
    repeat {
        if expenseReportContainsNumber[index1] {
            var index2 = index1 + 1
            var index3 = 2020 - index2 - index1
            repeat {
                if expenseReportContainsNumber[index2] && expenseReportContainsNumber[index3] {
                    result = "\(index1 * index2 * index3)"
                }
                index2 += 1
                index3 -= 1
            } while index3 > index2 && result == nil
        }
        index1 += 1
    } while index1 < 2020 && result == nil
    
    return result ?? "?"
}


func read(file fileName: String) -> String? {
    
    let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0] as NSURL
    
    guard let fileUrl = documentsUrl.appendingPathComponent(fileName) else {
        print("ERROR \(fileName)")
        return nil
    }
    
    do {
        return try String(contentsOf: fileUrl as URL, encoding: String.Encoding.utf8)
        
    } catch {
        print("ERROR read file \(fileUrl)")
        return nil
    }
}
