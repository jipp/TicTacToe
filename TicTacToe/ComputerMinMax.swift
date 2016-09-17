//
//  ComputerMiniMax.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 13.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

let debug: Bool = false

class ComputerMinMax: PlayerClass {
    var count: Int = 0
    
    override func getMove(field: Field) -> (x: Int, y: Int) {
        var x: Int = 0
        var y: Int = 0
        
        count = 0
        
        print("\(figure) turn")
        
        (x, y) = maximizing(field: field, depth: 6, alpha: Int.min, beta: Int.max)
        
        if debug {
            print("Count: \(count)")
        }

        return (x, y)
    }
    
    func maximizing(field: Field, depth: Int, alpha: Int, beta: Int) -> (Int, Int) {
        var maxValue: Int = alpha
        var value: Int
        var x: Int = 0
        var y: Int = 0

        move: for i in 0..<field.getLines() {
            for j in 0..<field.getLines() {
                if (field.content[i][j] == Figure.empty) {
                    field.set(x: i, y: j, figure: figure)
                    value = minimizing(field: field, depth: depth-1, alpha: maxValue, beta: beta)
                    field.remove(x: i, y: j)
                    if debug {
                        print(" Position: \((j, i)) Value: \(value)")
                    }
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
        
        if debug {
            print("Position: \((y, x)) maxValue: \(maxValue)")
        }
        
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
        
        move: for i in 0..<field.getLines() {
            for j in 0..<field.getLines() {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    value = minimizing(field: field, depth: depth-1, alpha: maxValue, beta: beta)
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
        
        move: for i in 0..<field.getLines() {
            for j in 0..<field.getLines() {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = getOpponent()
                    value = maximizing(field: field, depth: depth-1, alpha: alpha, beta: minValue)
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
