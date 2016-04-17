//
//  main.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

var field: Field?
var player1: Human = Human(figure: Figure.X)
var player2: Computer = Computer(figure: Figure.O)
var x: Int
var y: Int

var players: [PlayerClass] = [player1, player2]

while true {
    field = Field(z: 3)
    field!.show()
    gameLoop: for i in 0...field!.getSize() {
        (x, y) = players[i%2].getMove(field!)
        field!.set(x, y: y, figure: players[i%2].figure)
        field!.show()
        switch field!.getStatus() {
        case Status.won:
            print("\(players[i%2].figure) won\n\n")
            break gameLoop
        case Status.draw:
            print("Draw\n\n")
            break gameLoop
        default:
            break
        }
    }
}

