//
//  util.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 02.12.20.
//

import Foundation

func readAoC(file fileName: String) -> String? {
    
    let documentsUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask)[0] as NSURL
    
    guard let fileUrl = documentsUrl.appendingPathComponent(fileName) else {
        print("ERROR \(fileName)")
        return nil
    }
    
    do {
        return try String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
        
    } catch {
        print("ERROR read file \(fileUrl)")
        print(error)
        return nil
    }
}

