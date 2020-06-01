//
//  Mayor.swift
//  BigNerdRanch-4
//
//  Created by jeongminho on 2020/06/02.
//  Copyright © 2020 jeongminho. All rights reserved.
//

import Foundation

// Ch16 본선과제, 결승 과제
struct Mayor {
    
    var anxietyLevle: Int = 0
    
    mutating func alert() {
        print("I'm deeply suddened to hear about this latest tragedy.")
        anxietyLevle += 1
    }
}
