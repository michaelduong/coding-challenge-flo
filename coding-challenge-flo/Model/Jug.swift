//
//  Jug.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/11/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

typealias Gallon = Int

struct Jug {
    let capacity: Gallon
    private(set) var filledAmount: Gallon = 0
    let identifier: String
    
    init(capacity: Gallon, identifier: String) {
        self.capacity = capacity
        self.identifier = identifier
    }
}

// MARK: - Operations
extension Jug {
    // Fills the jug from source
    mutating func fill() {
        filledAmount = capacity
    }
    
    // Empties out the jug
    mutating func empty() {
        filledAmount = 0
    }
    
    // Transfer amount from one jug to another
    mutating func transfer(to jug: inout Jug) {
        let requiredAmount = (jug.capacity - jug.filledAmount)
        let availableAmount = min(filledAmount, requiredAmount)
        
        filledAmount -= availableAmount
        jug.filledAmount += availableAmount
    }
}

// MARK: - Equatable
extension Jug: Equatable {
    static func == (lhs: Jug, rhs: Jug) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: - Accessors
extension Jug {
    var isEmpty: Bool {
        return filledAmount == 0
    }
    
    var isFull: Bool {
        return filledAmount == capacity
    }
}
