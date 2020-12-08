//
//  Day7.swift
//  AdventOfCode2020
//
//  Created by Gregori, Lars on 07.12.20.
//

import Foundation

struct LRules {
    var bag: Bag
    var contains: [Bag]
}

func aocDay7Part1(fileName: String) -> Int {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let rules = createRules(lines: lines)

    var bagMap: [String: LRules] = [:]
    rules.forEach {rule in
        bagMap[rule.bag.name] = rule
        // print(rule.bag.name, rule.contains)
    }

    var consgb: [String: Bool] = [:]
    var consgbCount: [String: Int] = [:]
    rules.forEach { rule in

        let has = hasShiny(with: rule.bag, bagMap: bagMap, spc: "")
        print(rule.bag.name, has)
        if rule.bag.name != "shiny_gold" && has > 0 {
            consgb[rule.bag.name] = true
            consgbCount[rule.bag.name] = has
        }

    }

    print(consgb)
    print(consgbCount)

    let count = consgbCount.values.reduce(0) { counter, ccc in

        if ccc > 0 {
            return counter + 1
        }
        return counter
    }

    return count
}

private func createRules(lines: [String]) -> [LRules] {
    return lines.map { line -> LRules in

        let items = line.components(separatedBy: "contain")
        let bag = items[0]
        let contains = items[1].replacingOccurrences(of: ".", with: "")
            .components(separatedBy: ",")

        let bag2 = cbag(bagStr: bag)
        let con2 = contains.map {con in
            return cbag(bagStr: con)
        }

        return LRules(bag: bag2, contains: con2)
    }

}

func aocDay7Part2(fileName: String) -> Int {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let rules = createRules(lines: lines)

    var bagMap: [String: LRules] = [:]
    rules.forEach {rule in
        bagMap[rule.bag.name] = rule
        // print(rule.bag.name, rule.contains)
    }
    print(bagMap["shiny_gold"])

    let rule = bagMap["shiny_gold"]!

    var consgb: [String: Bool] = [:]
    var consgbCount: [String: Int] = [:]
//    rules.forEach { rule in

        let has = hasShiny2(with: rule.bag, bagMap: bagMap, spc: "")
        print(rule.bag.name, has)
        if has > 0 { //rule.bag.name != "shiny_gold" && has > 0 {
            consgb[rule.bag.name] = true
            consgbCount[rule.bag.name] = has
        }

//    }

    print(consgb)
    print(consgbCount)

    let count = consgbCount.values.reduce(0) { counter, ccc in

        if ccc > 0 {
            return counter + ccc
        }
        return counter
    }

    return count
}

func hasShiny2(with bag: Bag, bagMap: [String: LRules], spc: String) -> Int {

    let name = bag.name
    print(spc, ">", name, bag.count)
    if name == "no_other" {
        return 1
    }

    var sss = 1
    if let bbb = bagMap[name] {
        sss = bbb.contains.reduce(0) { counter, bagC in

            var hasC = hasShiny2(with: bagC, bagMap: bagMap, spc: spc + "  ") + counter

            if name == "shiny_gold" {
                // hasC += bagC.count
                print(spc, "<<", name, hasC, bagC.count)

            } else {
                print(spc, "<", name, hasC)

            }

            return hasC
        }
        //return sss
    }

    let eee = 1
    print(spc, "CC", name, bag.count, sss, bag.count * sss + eee)
    if name == "shiny_gold" {
        return sss - 1
    }
    return bag.count * sss + eee
}

func qqqhasShiny2(with bag: Bag, bagMap: [String: LRules], spc: String) -> Int {

    //print("hasShiny", name)
    let counterR = 0
    let name = bag.name

    print(spc, name)

    if name == "no_other" {
        return 1 //counterR
//    } else if name == "shiny_gold" {
//        return bag.count //counterR + 1 //bag.count
    }

    if let bbb = bagMap[name] { //} != nil {
        // print("-->", bag.name, bagMap[bag.name])
        print(spc, "   -->", name, ":", counterR)
        let sss = bbb.contains.reduce(counterR) { counter, bagC in

            var hasC = hasShiny2(with: bagC, bagMap: bagMap, spc: spc + "  ") // * bagC.count

            if bagC.name != "no_other" {
                hasC *= bagC.count
                //print(spc, "      --> S")
                //return counter
            } else {
                print(spc, "**", bag.count, hasC)
//                return hasC
            }

            print(spc, "      -->", bagC.count, bagC.name, hasC)
            return counter + hasC

        }
        print(spc, "sss", sss)
        return sss
    }
    print(spc, "<<", name)
    return counterR

}

func hasShiny(with bag: Bag, bagMap: [String: LRules], spc: String) -> Int {

    //print("hasShiny", name)
    let counterR = 0
    let name = bag.name

    ///print(spc, name)

    if name == "no_other" {
        return counterR
    } else if name == "shiny_gold" {
        return bag.count //counterR + 1 //bag.count
    }

    if let bbb = bagMap[name] { //} != nil {
        // print("-->", bag.name, bagMap[bag.name])
        ///print(spc, "   -->", name, ":", counterR)
        return bbb.contains.reduce(counterR) { counter, bagC in

            var hasC = hasShiny(with: bagC, bagMap: bagMap, spc: spc + "  ") // * bagC.count

            if bagC.name != "shiny_gold" {
                hasC *= bagC.count
                //print(spc, "      --> S")
                //return counter
            }

            ///print(spc, "      -->", bagC.count, bagC.name, hasC)
            return counter + hasC

        }
    }
    return counterR

}

struct Bag {
    var count: Int
    var name: String
}

func cbag(bagStr: String) -> Bag {
    let items = bagStr.trimmingCharacters(in: [" "]).components(separatedBy: " ")
    var count: Int = 1
    var name: String
    if items.count == 4 {
        count = items[0] == "no" ? 0 : Int(items[0])!
        name = "\(items[1])_\(items[2])"
    } else {
        name = "\(items[0])_\(items[1])"
    }
    return Bag(count: count, name: name)
}
