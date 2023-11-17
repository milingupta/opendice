//
//  RollHistory.swift
//  SoftDice
//
//  Created by Milin Gupta on 7/8/23.
//

import Foundation

class RollHistory: NSObject {
    
    static let shared = RollHistory()
    var isOldestOneFirst = true
    var isOldestTwoFirst = true
    var isOldestThreeFirst = true
    var isOldestFourFirst = true
    var isOldestFiveFirst = true
    
    private(set) var oneRollHistory: [(rollNumber: Int, rollValue: Int)] = []
    private(set) var twoRollHistory: [(rollNumber: Int, rollValue: (Int, Int))] = []
    private(set) var threeRollHistory: [(rollNumber: Int, rollValue: (Int, Int, Int))] = []
    private(set) var fourRollHistory: [(rollNumber: Int, rollValue: (Int, Int, Int, Int))] = []
    private(set) var fiveRollHistory: [(rollNumber: Int, rollValue: (Int, Int, Int, Int, Int))] = []

    private override init() {}
    
    func clearHistory() {
        oneRollHistory.removeAll()
        twoRollHistory.removeAll()
    }
        
    func appendOneRoll(_ roll: Int) {
        let rollNumber = oneRollHistory.count + 1
        oneRollHistory.append((rollNumber: rollNumber, rollValue: roll))
    }
    
    func prependOneRoll(_ roll: Int) {
        let rollNumber = oneRollHistory.count + 1
        oneRollHistory.insert((rollNumber: rollNumber, rollValue: roll), at: 0)
    }
    
    func reverseOneRollHistory() {
        oneRollHistory.reverse()
        isOldestOneFirst.toggle()
    }
    
    func appendTwoRolls(_ roll: (Int, Int)) {
        let rollNumber = twoRollHistory.count + 1
        twoRollHistory.append((rollNumber: rollNumber, rollValue: roll))
    }
    
    func prependTwoRolls(_ roll: (Int, Int)) {
        let rollNumber = twoRollHistory.count + 1
        twoRollHistory.insert((rollNumber: rollNumber, rollValue: roll), at: 0)
    }
    
    func reverseTwoRollHistory() {
        twoRollHistory.reverse()
        isOldestTwoFirst.toggle()
    }
    
    func appendThreeRolls(_ roll: (Int, Int, Int)) {
        let rollNumber = threeRollHistory.count + 1
        threeRollHistory.append((rollNumber: rollNumber, rollValue: roll))
    }
    
    func prependThreeRolls(_ roll: (Int, Int, Int)) {
        let rollNumber = threeRollHistory.count + 1
        threeRollHistory.insert((rollNumber: rollNumber, rollValue: roll), at: 0)
    }
    
    func reverseThreeRollHistory() {
        threeRollHistory.reverse()
        isOldestThreeFirst.toggle()
    }
    
    func appendFourRolls(_ roll: (Int, Int, Int, Int)) {
        let rollNumber = fourRollHistory.count + 1
        fourRollHistory.append((rollNumber: rollNumber, rollValue: roll))
    }
    
    func prependFourRolls(_ roll: (Int, Int, Int, Int)) {
        let rollNumber = fourRollHistory.count + 1
        fourRollHistory.insert((rollNumber: rollNumber, rollValue: roll), at: 0)
    }
    
    func reverseFourRollHistory() {
        fourRollHistory.reverse()
        isOldestFourFirst.toggle()
    }
    
    func appendFiveRolls(_ roll: (Int, Int, Int, Int, Int)) {
        let rollNumber = fiveRollHistory.count + 1
        fiveRollHistory.append((rollNumber: rollNumber, rollValue: roll))
    }
    
    func prependFiveRolls(_ roll: (Int, Int, Int, Int, Int)) {
        let rollNumber = fiveRollHistory.count + 1
        fiveRollHistory.insert((rollNumber: rollNumber, rollValue: roll), at: 0)
    }
    
    func reverseFiveRollHistory() {
        fiveRollHistory.reverse()
        isOldestFiveFirst.toggle()
    }
    
}
