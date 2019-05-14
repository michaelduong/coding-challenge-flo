//
//  JugRiddleSolver.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/12/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

struct JugRiddleSolver {
    let firstJug: Jug
    let secondJug: Jug
    
    // Runs algorithm on right side then left side
    // Returns whichever strategy has the lesser steps (more efficient)
    func states(fromDesiredAmount desiredAmount: Gallon) -> [State] {
        let rightStrategyStates = states(fromJug: firstJug, toJug: secondJug, desiredAmount: desiredAmount)
        let leftStrategyStates = states(fromJug: secondJug, toJug: firstJug, desiredAmount: desiredAmount)
        
        return rightStrategyStates.count < leftStrategyStates.count
            ? rightStrategyStates
            : leftStrategyStates
    }
    
    private func states(fromJug: Jug, toJug: Jug, desiredAmount: Gallon) -> [State] {
        var fromJug = fromJug;
        var toJug = toJug;
        
        var states: [State] = []
        
        while true {
            if fromJug.isEmpty {
                fromJug.fill()
                let state = State(xJug: fromJug, yJug: toJug, operation: .fill(fromJug))
                states.append(state)
            }
            
            if fromJug.filledAmount == desiredAmount {
                break
            }
            
            fromJug.transfer(to: &toJug)
            let state = State(xJug: fromJug, yJug: toJug, operation: .transfer(fromJug, toJug))
            states.append(state)
            
            if fromJug.filledAmount == desiredAmount || toJug.filledAmount == desiredAmount {
                break
            }
            
            if toJug.isFull {
                toJug.empty()
                let state = State(xJug: fromJug, yJug: toJug, operation: .empty(toJug))
                states.append(state)
            }
        }
        
        return states
    }
}

