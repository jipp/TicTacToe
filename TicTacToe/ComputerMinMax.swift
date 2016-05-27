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
        count = 0
        
        print("\(figure) turn")
        
        (x, y) = maximizing(field, depth: 10, alpha: Int.min, beta: Int.max)
        
        print(count)

        return (x, y)
    }
    
    func maximizing(field: Field, depth: Int, alpha: Int, beta: Int) -> (Int, Int) {
        var maxValue: Int = alpha
        var value: Int
        
        count += 1
        
        move: for i in 0...field.getLines()-1 {
            for j in 0...field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    value = minimizing(field, depth: depth-1, alpha: maxValue, beta: beta)
                    field.content[i][j] = Figure.empty
                    print(i, j, value)
                    if (value > maxValue) {
                        maxValue = value
                        x = i
                        y = j
                        if (maxValue >= beta) {
                            break move
                        }
                    }
                }
            }
        }
        print("result", x, y, maxValue)
        return (x,y)
    }

    
    func maximizing(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        var maxValue: Int = Int.min
        var value: Int
        
        count += 1
        
        if (field.won()) {
            return  -1 - depth
        }
        if (field.draw() || depth == 0) {
            return 0
        }
        
        move: for i in 0...field.getLines()-1 {
            for j in 0...field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    value = minimizing(field, depth: depth-1, alpha: maxValue, beta: beta)
                    field.content[i][j] = Figure.empty
                    if (value > maxValue) {
                        maxValue = value
                        if (maxValue >= beta) {
                            break move
                        }
                    }
                }
            }
        }
        
        return maxValue
    }

    func minimizing(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        var minValue: Int = Int.max
        var value: Int
        
        count += 1
        
        if (field.won()) {
            return 1 + depth
        }
        if (field.draw() || depth == 0) {
            return 0
        }
        
        move: for i in 0...field.getLines()-1 {
            for j in 0...field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = getOpponent()
                    value = maximizing(field, depth: depth-1, alpha: alpha, beta: minValue)
                    field.content[i][j] = Figure.empty
                    if (value < minValue) {
                        minValue = value
                        if (minValue <= alpha) {
                            break move
                        }
                    }
                }
            }
        }
        
        return minValue
    }
}