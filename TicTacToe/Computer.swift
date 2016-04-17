//
//  Computer.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Computer: PlayerClass {
    override func getMove(field: Field) ->  (Int, Int) {
        var x: Int = -1
        var y: Int = -1
        
        print("\(figure) turn")
        (x, y) = randomMove(field)
        return (x, y)
    }
    
    func randomMove(field: Field) -> (Int, Int) {
        repeat {
            x = Int(arc4random_uniform(UInt32(field.getColumns())))
            y = Int(arc4random_uniform(UInt32(field.getRows())))
        } while !field.checkAllowed(x, y: y)
        return (x, y)
    }
}