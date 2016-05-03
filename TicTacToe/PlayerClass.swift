//
//  Player.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class PlayerClass: PlayerProtocol {
    var figure: Figure
    
    init(figure: Figure) {
        self.figure = figure
    }
    
    func getFigure() -> Figure {
        return figure
    }
    
    func getOpponent() -> Figure {
        switch (figure) {
        case Figure.X: return Figure.O
        case Figure.O: return Figure.X
        default: return Figure.empty
        }
    }
    
    func getMove(field: Field) -> (Int, Int) {
        fatalError(#function + "Must be overridden")
    }
}