//
//  main.swift
//  SkipList
//
//  Created by Samuel Sottieaux.
//  Copyright © 2017 Samuel Sottieaux. All rights reserved.
//

import Foundation

// MARK: - Tests

extension SkipList {
    
    static func generate(p: Double, nbr: Int) -> SkipList {
        let list = SkipList(p: p)
        
        for _ in 0...nbr {
            let nbr = Int.random
            list.insert(nbr, newValue: "\(nbr)")
        }
        
        return list
    }
    
    func testSearchTime() -> Int {
        let keyToSearch = Int.random
        insert(keyToSearch, newValue: "\(keyToSearch)")
        
        let startDate = Date()
        _ = search(keyToSearch)
        let duration = Int(Double(Date().timeIntervalSince(startDate)) * 10000000.0)
        
        return duration
    }
    
    func testSearchTimeAverage(_ times: Int = 10000) -> Int {
        var totSearchTime = 0
        for _ in 0..<times {
            totSearchTime += testSearchTime()
        }
        return totSearchTime / times
    }
    
    func testDelete() {
        let keyToSearch = Int.random
        insert(keyToSearch, newValue: "\(keyToSearch)")
        print("search before delete: \(String(describing: search(keyToSearch)))")
        delete(keyToSearch)
        print("search after delete: \(String(describing: search(keyToSearch)))")
    }
    
}

// MARK: - Playground

print("START: \(Date())")

var skiplists: [SkipList] = [] // avoid deinit before print(table)

var table = "".padding()

let ps: [Double] = [1/16, 1/8, 1/4, 1/2, 3/4]
for p in ps {
    table += String(p).padding()
}
table += "\n"

for nbr in [10000, 100000, 1000000, 10000000] {
    print("--- \(nbr) ---\n")
    table += String(nbr).padding()
    for p in ps {
        print("start generate for p: \(p)")
        let start = Date()
        let list = SkipList.generate(p: p, nbr: nbr)
        skiplists.append(list)
        print(list)
        table += String(list.testSearchTimeAverage()).padding()
        let end = Date().timeIntervalSince(start)
        print("generated in \(end)\n")
    }
    table += "\n"
    print()
}

print(table)

print("END: \(Date())")
