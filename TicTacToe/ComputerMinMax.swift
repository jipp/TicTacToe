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
                    print("check field:", i, j)
                    field.content[i][j] = figure
                    ratedField = minMax(field, depth: 1, maximizingPlayer: true, figure: figure)
                    field.content[i][j] = Figure.empty
                    if (ratedField > maxRated) {
                        x = i
                        y = j
                        maxRated = ratedField
                        print(" maxRated:", maxRated)
                    }
                }
            }
        }
        print(" ", x, y)
        return (x, y)
    }
    
    func minMax(field: Field, depth: Int, maximizingPlayer: Bool, figure: Figure) -> Int {
        var bestValue: Int
        var v: Int
        
        print(" depth:", depth, "maximizingPlayer:", maximizingPlayer)
        if (field.won()) {
            if (maximizingPlayer) {
                print(" 3")
                return 3
            } else {
                print(" -3")
                return -3
            }
        }
        
        if (depth == 0 || field.draw()) {
            print(" return 0")
            return 0
        }

        if (maximizingPlayer) {
            bestValue = Int.min
            for i in 0...field.getLines()-1 {
                for j in 0...field.getLines()-1 {
                    if (field.content[i][j] == Figure.empty) {
                        field.content[i][j] = figure
                        v = minMax(field, depth: depth - 1, maximizingPlayer: false, figure: getOpponent())
                        field.content[i][j] = Figure.empty
                        bestValue = max(bestValue, v)
                    }
                }
            }
            return bestValue
        } else {
            bestValue = Int.max
            for i in 0...field.getLines()-1 {
                for j in 0...field.getLines()-1 {
                    if (field.content[i][j] == Figure.empty) {
                        field.content[i][j] = getOpponent()
                        v = minMax(field, depth: depth - 1, maximizingPlayer: true, figure: figure)
                        field.content[i][j] = Figure.empty
                        bestValue = min(bestValue, v)
                    }
                }
            }
            return bestValue
        }
    }
}