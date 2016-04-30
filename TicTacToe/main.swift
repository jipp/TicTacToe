//
//  main.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

var field: Field?
var player1: PlayerClass = PlayerFactory.create(PlayerEnum.Human, figure: Figure.X)!
var player2: PlayerClass = PlayerFactory.create(PlayerEnum.ComputerRandom, figure: Figure.O)!
var players: [PlayerClass] = [player1, player2]
var x: Int
var y: Int

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

