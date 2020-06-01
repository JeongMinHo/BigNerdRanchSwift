//
//  Town.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/01.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

struct Town {
    
    static let region = "South"
    
    var mayor = Mayor()
    
    // Ch16 예선과제
    var population = 5422 {
        didSet(oldPopulation) {
            if oldPopulation > population {
                print("인구가 줄어들었습니다!")
                mayor.alert()
            }
        }
    }
    var numberOfStoplights = 4
    
    enum Size {
        case small
        case medium
        case large
    }
    
    var townSize: Size {
        get {
           switch self.population {
            case 0...10000:
                return Size.small
            case 10001...100000:
                return Size.medium
            default:
                return Size.large
            }
        }
    }
        
    func printDescription() {
        print("Population: \(population); number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}
