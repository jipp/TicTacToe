//
//  Human.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Human: PlayerClass {
    override func getMove(field: Field) ->  (Int, Int) {
        var x: Int = -1
        var y: Int = -1
        var input: String
        
        print("\(figure) turn")
        repeat {
            print("Eingabe: ", terminator:"")
            input = readLine()!
            if let position = Int(input) {
                if (position > 0 && position <= field.getSize()) {
                    x = (position - 1) / field.getColumns()
                    y = (position - 1) % field.getRows()
                    break
                }
            }
        } while !field.checkAllowed(x, y: y)
        return (x, y)
    }
}