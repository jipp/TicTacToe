//
//  Player.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

protocol PlayerProtocol {
    var figure: Figure { get }
    
    func getFigure() -> Figure
    func getOpponent() ->  Figure
    func getMove(_ field: Field) -> (Int, Int)
}
