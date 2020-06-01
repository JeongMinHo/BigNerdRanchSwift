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
    internal private(set) var isFallingApart = false
    
    class var noise: String {
        return "Woo..."
    }
    
    var walksWithLimp = true

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
