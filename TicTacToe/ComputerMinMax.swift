//
//  ComputerMiniMax.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 13.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class ComputerMinMax: PlayerClass {
    var count: Int = 0
    
    override func getMove(field: Field) -> (x: Int, y: Int) {
        var value: Int = 0
        var maxValue: Int = Int.min
        let beta: Int = Int.max
        
        count = 0
        
        print("\(figure) turn")
        for i in 0 ... field.getLines()-1 {
            for j in 0 ... field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    value = minimizing(field, depth: 9, alpha: Int.max, beta: beta)
                    field.content[i][j] = Figure.empty
                    if (value > maxValue) {
                        x = i
                        y = j
                        maxValue = value
                        if (maxValue >= beta) {
                            break
                        }
                    }
                }
            }
        }
        
        print("Count:", count)
        return (x, y)
    }
    
    func minimizing(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        // var minValue: Int = Int.max
        var minValue: Int = beta
        var value: Int
        
        count += 1
        
        if (field.won()) {
            return 1
        }
        if (field.draw() || depth == 0) {
            return 0
        }
        
        for i in 0...field.getLines()-1 {
            for j in 0...field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = getOpponent()
                    value = maximizing(field, depth: depth-1, alpha: alpha, beta: Int.min)
                    field.content[i][j] = Figure.empty
                    //maxValue = min(maxValue, value)
                    if (value < minValue) {
                        minValue = value
                        if (minValue <= alpha) {
                            break
                        }
                    }
                }
            }
        }
        
        return minValue
    }
    
    func maximizing(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        // var maxValue: Int = Int.min
        var maxValue: Int = alpha
        var value: Int
        
        count += 1

        if (field.won()) {
            return  -1
        }
        if (field.draw() || depth == 0) {
            return 0
        }
        
        for i in 0...field.getLines()-1 {
            for j in 0...field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    value = minimizing(field, depth: depth-1, alpha: Int.max, beta: beta)
                    field.content[i][j] = Figure.empty
                    //minValue = max(minValue, value)
                    if (value > maxValue) {
                        maxValue = value
                        if (maxValue >= beta) {
                            break
                        }
                    }
                }
            }
        }
        
        return maxValue
    }
}