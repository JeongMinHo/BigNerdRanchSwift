//
//  Zombie.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/02.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

// Ch15 예선과제
class Zombie: Monster {
    class var noise: String {
        return "Woo..."
    }
    
    
    private(set) var isFallingApart: Bool
    var walksWithLimp: Bool
//    internal private(set) var isFallingApart = false
//    var walksWithLimp = true
    
    init?(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }
    
    convenience init?(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Minho")
        if walksWithLimp {
            print("This zombie has a bad knee.")
        }
    }
    
    // Ch17 본선과제
    required convenience init?(town: Town?, monsterName: String) {
        self.init(limp: false, fallingApart: false, town: town, monsterName: monsterName)
    }
    
    deinit {
        print("Zombie named \(name) is no longer with us.")
    }
    
    override func terriorizeTown() {
        
        guard let population = town?.population else { return }
        if population > 0 {
            town?.changePopulation(by: -10)
            super.terriorizeTown()
        } else {
            print("인구가 0명입니다.")
        }
    }
}
