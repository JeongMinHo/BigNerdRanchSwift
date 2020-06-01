//
//  Monster.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/02.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

class Monster {
    var town: Town?
    var name = "Monster"
    
    var victimPool: Int {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
    func terriorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
}
