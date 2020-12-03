//
//  util.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 02.12.20.
//

import Foundation

func readAoC(file fileName: String) -> String? {
    
    let homeDirectoryUrl = FileManager.default.homeDirectoryForCurrentUser
    
    let fileUrl = homeDirectoryUrl
        .appendingPathComponent("AoC2020")
        .appendingPathComponent(fileName)
    
    return try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
}
