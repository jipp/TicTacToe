//
//  Computer.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Computer: PlayerClass {
    enum Goal: Int {
        case win = 1
        case avoidLoose = -1
    }
    
    override func getMove(field: Field) ->  (Int, Int) {
        var x: Int = -1
        var y: Int = -1
        
        print("\(figure) turn")
        if (!field.allowedMove(x, y: y)) {
            (x, y) = checkMove(field, goal: Goal.win)
        }
        if (!field.allowedMove(x, y: y)) {
            (x, y) = checkMove(field, goal: Goal.avoidLoose)
        }
        if (!field.allowedMove(x, y: y)) {
            (x, y) = randomMove(field)
        }
        return (x, y)
    }
    
    func randomMove(field: Field) -> (Int, Int) {
        repeat {
            x = Int(arc4random_uniform(UInt32(field.getLines())))
            y = Int(arc4random_uniform(UInt32(field.getLines())))
        } while !field.allowedMove(x, y: y)
        return (x, y)
    }
    
    func checkMove(field: Field, goal: Goal) -> (Int, Int) {
        var vSum: Int = 0
        var hSum: Int = 0
        var dSum: Int = 0
        var rSum: Int = 0
        
        for i in 0...field.getLines()-1 {
            hSum = 0
            vSum = 0
            for j in 0...field.getLines()-1 {
                vSum += field.content[j][i].rawValue
                hSum += field.content[i][j].rawValue
            }
            if (vSum == (field.getLines()-1) * figure.rawValue * goal.rawValue) {
                for k in 0...field.getLines()-1 {
                    if (field.content[k][i] == Figure.empty) {
                        return (k,i)
                    }
                }
            }
            if (hSum == (field.getLines()-1) * figure.rawValue * goal.rawValue) {
                for k in 0...field.getLines()-1 {
                    if (field.content[i][k] == Figure.empty) {
                        return (i, k)
                    }
                }
            }
        }
        for i in 0...field.getLines()-1 {
            dSum += field.content[i][i].rawValue
            rSum += field.content[i][field.getLines() - 1 - i].rawValue
        }
        if (dSum == (field.getLines()-1) * figure.rawValue * goal.rawValue) {
            for i in 0...field.getLines()-1 {
                if (field.content[i][i] == Figure.empty) {
                    return (i, i)
                }
            }
        }
        if (rSum == (field.getLines()-1) * figure.rawValue * goal.rawValue) {
            for i in 0...field.getLines()-1 {
                if (field.content[i][field.getLines()-1-i] == Figure.empty) {
                    return (i, field.getLines()-1-i)
                }
            }
        }
        return (-1, -1)
    }
}