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
        var ratedField: Int = 0
        var maxRated: Int = Int.min
        
        count = 0
        
        print("\(figure) turn")
        for i in 0 ... field.getLines()-1 {
            for j in 0 ... field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    ratedField = maximizing(field, depth: 9, alpha: Int.min, beta: Int.max)
                    field.content[i][j] = Figure.empty
                    if (ratedField > maxRated) {
                        x = i
                        y = j
                        maxRated = ratedField
                    }
                }
            }
        }
        
        print("Count:", count)
        return (x, y)
    }
    
    func maximizing(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        var maxValue: Int = Int.max
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
                    value = minimizing(field, depth: depth-1, alpha: Int.max, beta: beta)
                    field.content[i][j] = Figure.empty
                    maxValue = min(maxValue, value)
                }
            }
        }
        
        return maxValue
    }
    
    func minimizing(field: Field, depth: Int, alpha: Int, beta: Int) -> Int {
        var minValue: Int = Int.min
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
                    value = maximizing(field, depth: depth-1, alpha: alpha, beta: Int.min)
                    field.content[i][j] = Figure.empty
                    minValue = max(minValue, value)
                }
            }
        }
        
        return minValue
    }
}