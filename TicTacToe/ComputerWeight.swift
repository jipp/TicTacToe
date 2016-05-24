//
//  Computer.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class ComputerWeight: PlayerClass {
    override func getMove(field: Field) -> (x: Int, y: Int) {
		var weightTemp: Int = 0
		var weightAll: Int = 0
		var x: Int = 0
		var y: Int = 0
    
        print("\(figure) turn")
		for i in 0...field.getLines()-1 {
			for j in 0...field.getLines()-1 {
				weightTemp = weightPerCell(field, x:i, y:j)
				if (weightTemp > weightAll) {
					weightAll = weightTemp
                    x = i
					y = j
				}
			}
		}
		return (x, y)
	}

	func weightPerCell(field: Field, x: Int, y: Int) -> Int {
		var weight: Int = 0

		if (field.content[x][y] == Figure.empty) {
			weight += checkRow(field, y:y)
			weight += checkColumn(field, x:x)
			if (x == y) {
				weight += checkBackSlash(field)
			}
			if (x == field.getLines()-1-y) {
				weight += checkSlash(field)
			}
		}
		return weight
	}

	func checkRow(field: Field, y: Int) -> Int {
		var sum: Int = 0
    
		for x in 0...field.getLines()-1 {
			sum += field.content[x][y].rawValue
		}
		return returnWeight(sum)
	}

	func checkColumn(field: Field, x: Int) -> Int {
		var sum: Int = 0
    
		for y in 0...field.getLines()-1 {
			sum += field.content[x][y].rawValue
		}
		return returnWeight(sum)
	}

	func checkBackSlash(field: Field) -> Int {
		var sum: Int = 0
    
		for i in 0...field.getLines()-1 {
			sum += field.content[i][i].rawValue
		}
		return returnWeight(sum)
	}

	func checkSlash(field: Field) -> Int {
		var sum: Int = 0
    
		for i in 0...field.getLines()-1 {
			sum += field.content[field.getLines()-1-i][i].rawValue
		}   
		return returnWeight(sum)
	}

	func returnWeight(cell: Int) -> Int {
        if (cell*figure.rawValue > 0) {
            return Int(pow(10.0, Double(abs(cell))))*2
        } else {
            return Int(pow(10.0, Double(abs(cell))))
        }
	}
}