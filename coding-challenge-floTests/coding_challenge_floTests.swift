//
//  coding_challenge_floTests.swift
//  coding-challenge-floTests
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import XCTest
@testable import coding_challenge_flo

class coding_challenge_floTests: XCTestCase {
    
    func isSolvable(_ x: Int, _ y: Int, _ z: Int) -> Bool {
        return z == 0 || ((z <= (x > y ? x : y)) && (z.isMultiple(of: gcd(x, y))))
    }
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        return b == 0 ? a : gcd(b, a % b)
    }

    // From the movie Die Hard 3
    func testDieHardCase() {
        let xJug = Jug(capacity: 5, identifier: "x")
        let yJug = Jug(capacity: 3, identifier: "y")
        let desiredAmount = 4
        
        let solver = JugRiddleSolver(firstJug: xJug, secondJug: yJug)
        let states = solver.states(fromDesiredAmount: desiredAmount)
        
        XCTAssertEqual(states.count, 6)
    }
    
    func testSolvableFunction() {
        let x = 1
        let y = 2
        let z = 3
        
        let result: Bool = isSolvable(x, y, z)
        
        XCTAssertFalse(result)
    }
    
    func testEdgeCase() {
        let x = Jug(capacity: 2, identifier: "x")
        let y = Jug(capacity: 3, identifier: "y")
        let z = 5
        
        if isSolvable(x.capacity, y.capacity, z) {
            let solver = JugRiddleSolver(firstJug: x, secondJug: y)
            let states = solver.states(fromDesiredAmount: z)
            XCTAssertNil(states, "No solution")
        }
    }
    
    func testCrazyAmountCase() {
        let x = Jug(capacity: 10004659, identifier: "x")
        let y = Jug(capacity: 10004677, identifier: "y")
        let z = 1424242
        
        if isSolvable(x.capacity, y.capacity, z) {
            let solver = JugRiddleSolver(firstJug: x, secondJug: y)
            let states = solver.states(fromDesiredAmount: z)
            XCTAssertGreaterThan(states.count, 0)
        }
    }
}
