//
//  Field.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Field {
    var content: [[Figure]]
    var z: Int

    init() {
        self.z = 3
        content = Array(count: self.z, repeatedValue: Array(count: self.z, repeatedValue: Figure.empty))
    }

    init(z: Int) {
        self.z = z
        content = Array(count: self.z, repeatedValue: Array(count: self.z, repeatedValue: Figure.empty))
    }
    
    func getLines() -> Int {
        return z
    }
    
    func getSize() -> Int {
        return z*z
    }
    
    func show() {
        for i in 0...z-1 {
            for j in 0...z-1 {
                switch content[i][j] {
                case .X:
                    print(Figure.X, terminator:"")
                case .O:
                    print(Figure.O, terminator:"")
                default:
                    print(" ", terminator:"")
                }
                if (j < z - 1) {
                    print("|", terminator:"")
                }
            }
            print()
            if (i < z - 1) {
                for _ in 1...z-1 {
                    print("--", terminator:"")
                }
                print("-")
            }
        }
        print()
    }
    
    func allowedMove(x: Int, y: Int) -> Bool {
        if (x>=0 && x<z && y>=0 && y<z) {
            if (content[x][y] == Figure.empty) {
                return true
            }
        }
        return false
    }
    
    func set(x: Int, y: Int, figure: Figure) {
        content[x][y] = figure
    }
    
    func getStatus() -> Status {
        if draw() {
            return Status.draw
        }
        if won() {
            return Status.won
        }
        return Status.ongoing
    }
    
    func draw() -> Bool {
        for i in 0...getLines()-1 {
            for j in 0...getLines()-1 {
                if (content[i][j] == Figure.empty) {
                    return false
                }
            }
        }
        return true
    }
    
    func won() -> Bool {
        var check: Bool = false
        var vSum: Int = 0
        var hSum: Int = 0
        var dSum: Int = 0
        var rSum: Int = 0
        
        for i in 0...z-1 {
            hSum = 0
            vSum = 0
            for j in 0...z-1 {
                vSum += field!.content[i][j].rawValue
                hSum += field!.content[j][i].rawValue
            }
            if (abs(vSum) == z || abs(hSum) == z) {
                check = true
                break
            }
        }
        for i in 0...z-1 {
            dSum += field!.content[i][i].rawValue
            rSum += field!.content[i][z - 1 - i].rawValue
        }
        if (abs(dSum) == z || abs(rSum) == z) {
            check = true
        }
        if (check == true) {
            return true
        }
        print("false")
        return false
    }
}