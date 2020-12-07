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
    var shinyGoldBags: Int
}

func aocDay7Part1(fileName: String) -> Int {

    let lines = readAoC(file: fileName)!.components(separatedBy: "\n")

    let rules = lines.map { line -> LRules in

        let items = line.components(separatedBy: "contain")
        let bag = items[0] // String(items[0]).trimmingCharacters(in: [" "])
        let contains = items[1].replacingOccurrences(of: ".", with: "")
            //.trimmingCharacters(in: [" "])
            .components(separatedBy: ",")

        let bag2 = cbag(bagStr: bag)
        let con2 = contains.map {con in
            return cbag(bagStr: con)
        }
        let sgb = con2.reduce(0) {counter, conbag in

            if conbag.name == "shiny_gold" {
                return counter + conbag.count
            }
            return counter
        }

        return LRules(bag: bag2, contains: con2, shinyGoldBags: sgb)
    }
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

func getShiny(with rule: LRules, bagMap: [String: LRules]) -> Int {

    return rule.contains.reduce(0) {counterR, bag in
        if bag.name == "no_other" {
            return counterR
        } else if bag.name == "shiny_gold" {
            return counterR + 1 //bag.count
        }

        if let bbb = bagMap[bag.name] { //} != nil {
            // print("-->", bag.name, bagMap[bag.name])
            return counterR + getShiny(with: bbb, bagMap: bagMap)
        }
        return counterR
    }

}

struct Bag {
    var count: Int
    var name: String
}

func cbag(bagStr: String) -> Bag {
    let items = bagStr.trimmingCharacters(in: [" "]).components(separatedBy: " ")
    var count: Int = 0
    var name: String
    if items.count == 4 {
        count = items[0] == "no" ? 0 : Int(items[0])!
        name = "\(items[1])_\(items[2])"
    } else {
        name = "\(items[0])_\(items[1])"
    }
    return Bag(count: count, name: name)
}
