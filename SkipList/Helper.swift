//
//  Helper.swift
//  SkipList
//
//  Created by Samuel Sottieaux on 30/07/2017.
//  Copyright © 2017 Samuel Sottieaux. All rights reserved.
//

import Foundation

// MARK: - Helper

extension SkipList: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "p: \(p), level: \(level)"
    }
    
}

extension Node: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "Node(key: \(key), value: \(value != nil ? value! : "nil"))"
    }
    
}

extension Double {
    
    static var random: Double {
        return Double(arc4random()) / Double(UINT32_MAX)
    }
    
}

extension Int {
    
    static var random: Int {
        let upperBound = Int(UINT32_MAX / 2)
        return random(0...upperBound)
    }
    
    static func random(_ range: CountableClosedRange<Int>) -> Int {
        var offset = 0
        
        if range.lowerBound < 0  {
            
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

extension String {
    
    func padding() -> String {
        return self + "\t"
    }
    
}
