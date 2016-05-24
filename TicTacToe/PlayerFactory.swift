//
//  PlayerFactory.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 28.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class PlayerFactory {
    class func create(playerEnum: PlayerEnum, figure: Figure) -> PlayerClass? {
        switch playerEnum {
        case .Human: return Human(figure: figure)
        case .ComputerRandom: return ComputerRandom(figure: figure)
        case .ComputerWeight: return ComputerWeight(figure: figure)
        case .ComputerMinMax: return ComputerMinMax(figure: figure)
        default: print("\n> Player not existing\n"); return nil
        }
    }
}