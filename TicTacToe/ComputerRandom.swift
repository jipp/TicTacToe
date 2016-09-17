//
//  ComputerRandom.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 27.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class ComputerRandom: PlayerClass {
    override func getMove(field: Field) -> (x: Int, y: Int) {
        print("\(figure) turn")
        repeat {
            x = Int(arc4random_uniform(UInt32(field.getLines())))
            y = Int(arc4random_uniform(UInt32(field.getLines())))
        } while !field.allowedMove(x: x, y: y)
        return (x, y)
    }
}
