//
//  ComputerMiniMax.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 13.05.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class ComputerMinMax: PlayerClass {
    
    override func getMove(field: Field) -> (x: Int, y: Int) {
        var ratedField: Int = 0
        var maxRated: Int = Int.min
        
        print("\(figure) turn")
        for i in 0 ... field.getLines()-1 {
            for j in 0 ... field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    ratedField = maximizing(field, depth: 9)
                    field.content[i][j] = Figure.empty
                    if (ratedField > maxRated) {
                        x = i
                        y = j
                        maxRated = ratedField
                    }
                }
            }
        }
        return (x, y)
    }
    
    func maximizing(field: Field, depth: Int) -> Int {
        var bestValue: Int = Int.max
        var v: Int
        
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
                    v = minimizing(field, depth: depth-1)
                    field.content[i][j] = Figure.empty
                    bestValue = min(bestValue, v)
                }
            }
        }
        
        return bestValue
    }
    
    func minimizing(field: Field, depth: Int) -> Int {
        var bestValue: Int = Int.min
        var v: Int

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
                    v = maximizing(field, depth: depth-1)
                    field.content[i][j] = Figure.empty
                    bestValue = max(bestValue, v)
                }
            }
        }
        
        return bestValue
    }
}