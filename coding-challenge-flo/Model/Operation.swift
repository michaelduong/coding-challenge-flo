//
//  Operation.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/11/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

enum Operation {
    case fill(Jug)
    case empty(Jug)
    case transfer(Jug, Jug)
}

extension Operation {
    var name: String {
        switch self {
        case .fill(let jug):
            return "Fill \(jug.identifier)"
        case .empty(let jug):
            return "Empty \(jug.identifier)"
        case .transfer(let fromJug, let toJug):
            return "Transfer \(fromJug.identifier) to \(toJug.identifier)"
        }
    }
}
