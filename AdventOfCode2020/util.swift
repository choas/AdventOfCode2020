// SPDX-FileCopyrightText: 2020 Lars Gregori
//
// SPDX-License-Identifier: MIT

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

    // swiftlint:disable force_try
    return try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
}

extension StringProtocol {
    func str(at offsetBy: Int) -> String {
        String(self[index(startIndex, offsetBy: offsetBy)])
    }
}
