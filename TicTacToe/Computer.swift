//
//  Computer.swift
//  TicTacToe
//
//  Created by Wolfgang Keller on 17.04.16.
//  Copyright © 2016 Wolfgang Keller. All rights reserved.
//

import Foundation

class Computer: PlayerClass {    
    override func getMove(content: [[Figure]]) -> (x: Int, y: Int) {
		var weightTemp: Int = 0
		var weightAll: Int = 0
		var x: Int = 0
		var y: Int = 0
    
		for i in 0...content.count-1 {
			for j in 0...content.count-1 {
				weightTemp = weightPerCell(content, x:i, y:j)
				if (weightTemp > weightAll) {
					weightAll = weightTemp
					x = i
					y = j
				}
				print(weightTemp)
			}
		}
		return (x, y)
	}

	func weightPerCell(content: [[Figure]], x: Int, y: Int) -> Int {
		var weight: Int = 0

		if (content[y][x] == Figure.empty) {
			weight += checkRow(content, y:y)
			weight += checkColumn(content, x:x)
			if (x == y) {
				weight += checkBackSlash(content)
			}
			if (x == content.count-1-y) {
				weight += checkSlash(content)
			}
		} 
		return weight
	}

	func checkRow(content: [[Figure]], y: Int) -> Int {
		var sum: Int = 0
    
		for x in 0...content.count-1 {
			sum += content[y][x].rawValue
		}
		return returnWeight(sum)
	}

	func checkColumn(content: [[Figure]], x: Int) -> Int {
		var sum: Int = 0
    
		for y in 0...content.count-1 {
			sum += content[y][x].rawValue
		}
		return returnWeight(sum)
	}

	func checkBackSlash(content: [[Figure]]) -> Int {
		var sum: Int = 0
    
		for i in 0...content.count-1 {
			sum += content[i][i].rawValue
		}
		return returnWeight(sum)
	}

	func checkSlash(content: [[Figure]]) -> Int {
		var sum: Int = 0
    
		for i in 0...content.count-1 {
			sum += content[content.count-1-i][i].rawValue
		}   
		return returnWeight(sum)
	}

	func returnWeight(cell: Int) -> Int { 
		for i in -content.count+1...content.count-1 {
			if (cell == i) {
				if (i*figure.rawValue > 0) {
					return Int(pow(10.0, Double(abs(i))))*2
				} else {
					return Int(pow(10.0, Double(abs(i))))
				}
			}
		}
		return -1000000
	}
}