//
//  Town.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/01.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

struct Town {
    var population = 5422
    var numberOfStoplights = 4
    
    func printDescription() {
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}
