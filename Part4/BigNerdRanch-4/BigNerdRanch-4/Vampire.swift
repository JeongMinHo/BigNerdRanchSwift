//
//  Vampire.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/02.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

// Ch15 본선과제
class Vampire: Monster {
    
    var vampires: [Vampire] = []
    
    override func terriorizeTown() {
        town?.changePopulation(by: -1)
//        vampires.append(Vampire())
        super.terriorizeTown()
    }
}
