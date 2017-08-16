//
//  SkipList.swift
//  SkipList
//
//  Created by Samuel Sottieaux on 30/07/2017.
//  Copyright © 2017 Samuel Sottieaux. All rights reserved.
//

import Foundation

// MARK: - SkipList

typealias Nodes = [Int: Node]

class SkipList {
    
    let p: Double
    let maxLevel: Int
    let header: Node = Node(key: Int(UINT32_MAX))
    var level: Int = 1
    
    init(p: Double, maxLevel: Int = 100) {
        self.p = p
        self.maxLevel = maxLevel
    }
    
}

class Node {
    
    let key: Int
    var value: Any?
    var forward: Nodes = Nodes()
    
    init(key: Int, value: Any? = nil) {
        self.key = key
        self.value = value
    }
    
}

extension SkipList {
    
    func search(_ searchKey: Int) -> Any? {
        let (x, _) = searchNode(searchKey)
        return x?.value
    }
    
    func insert(_ searchKey: Int, newValue: Any) {
        var (x, update) = searchNode(searchKey)
        
        if x != nil {
            x!.value = newValue
        } else {
            let newLevel = randomLevel()
            if newLevel > level {
                for i in level+1...newLevel {
                    update[i] = header
                }
                level = newLevel
            }
            
            x = Node(key: searchKey, value: newValue)
            
            for i in 1...newLevel {
                x!.forward[i] = update[i]?.forward[i]
                update[i]?.forward[i] = x
            }
        }
    }
    
    func delete(_ searchKey: Int) {
        var (x, update) = searchNode(searchKey)
        
        if x != nil {
            for i in 1...level {
                if update[i]?.forward[i]?.key != x!.key {
                    break
                }
                update[i]?.forward[i] = x!.forward[i]
                x = nil
                while level > 1 && header.forward[level] == nil {
                    level -= 1
                }
            }
        }
    }
    
    func randomLevel() -> Int {
        var newLevel = 1
        
        while Double.random < p {
            newLevel += 1
        }
        
        return min(newLevel, maxLevel)
    }
    
    func searchNode(_ searchKey: Int) -> (Node?, Nodes) {
        var update = Nodes()
        var x = header
        
        for i in stride(from: level, through: 1, by: -1) {
            while let fwd = x.forward[i], fwd.key < searchKey {
                x = fwd
            }
            update[i] = x
        }
        
        if let x = x.forward[1], x.key == searchKey {
            return (x, update)
        } else {
            return (nil, update)
        }
    }
    
}
