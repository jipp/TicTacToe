//
//  main.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

var field: Field?
var player1: PlayerClass = PlayerFactory.create(PlayerEnum.human, figure: Figure.x)!
var player2: PlayerClass = PlayerFactory.create(PlayerEnum.computerMinMax, figure: Figure.o)!
var players: [PlayerClass] = [player1, player2]
var x: Int
var y: Int

while true {
    field = Field()
    field!.show()
    gameLoop: for i in 0..<field!.getSize() {
        (x, y) = players[i%2].getMove(field: field!)
        field!.set(x: x, y: y, figure: players[i%2].figure)
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

