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
        var maxRated: Int = 0
        
        print("\(figure) turn")
        for i in 0 ... field.getLines()-1 {
            for j in 0 ... field.getLines()-1 {
                if (field.content[i][j] == Figure.empty) {
                    field.content[i][j] = figure
                    ratedField = minMax(field, depth: 9, maximizingPlayer: true, figure: figure)
                    field.content[i][j] = Figure.empty
                    print(i,j)
                    if (ratedField > maxRated) {
                        x = j
                        y = i
                        maxRated = ratedField
                        print(x, y, maxRated)
                    }
                }
            }
        }
        return (x, y)
    }
    
    func minMax(field: Field, depth: Int, maximizingPlayer: Bool, figure: Figure) -> Int {
        var bestValue: Int
        var v: Int
        
        if (depth == 0 || field.draw()) {
            return 0
        }
        
        if (field.won()) {
            if (maximizingPlayer) {
                return 3
            } else {
                return -3
            }
        }
        
        if (maximizingPlayer) {
            bestValue = Int.min
            for y in 0 ... field.getLines()-1 {
                for x in 0 ... field.getLines()-1 {
                    if (field.content[y][x] == Figure.empty) {
                        field.content[y][x] = getOpponent()
                        v = minMax(field, depth: depth - 1, maximizingPlayer: false, figure: figure)
                        field.content[y][x] = Figure.empty
                        bestValue = max(bestValue, v)
                    }
                }
            }
            return bestValue
        } else {
            bestValue = Int.max
            for y in 0 ... field.getLines()-1 {
                for x in 0 ... field.getLines()-1 {
                    if (field.content[y][x] == Figure.empty) {
                        field.content[y][x] = figure
                        v = minMax(field, depth: depth - 1, maximizingPlayer: true, figure: getOpponent())
                        field.content[y][x] = Figure.empty
                        bestValue = min(bestValue, v)
                    }
                }
            }
            return bestValue
        }
    }
}